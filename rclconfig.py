#!/usr/bin/env python

import locale
import re
import os
import sys
import base64

class ConfSimple:
    """A ConfSimple class reads a recoll configuration file, which is a typical
    ini file (see the Recoll manual). It's a dictionary of dictionaries which
    lets you retrieve named values from the top level or a subsection"""

    def __init__(self, confname, tildexp = False):
        f = open(confname, 'r')
        self.dotildexpand = tildexp
        self.submaps = {}

        self.parseinput(f)
        
    def parseinput(self, f):
        appending = False
        line = ''
        submapkey = ''
        for cline in f:
            cline = cline.rstrip("\r\n")
            if appending:
                line = line + cline
            else:
                line = cline
            line = line.strip()
            if line == '' or line[0] == '#':
                continue

            if line[len(line)-1] == '\\':
                line = line[0:len(line)-1]
                appending = True
                continue
            appending = False
            #print line
            if line[0] == '[':
                line = line.strip('[]')
                if self.dotildexpand:
                    submapkey = os.path.expanduser(line)
                else:
                    submapkey = line
                #print "Submapkey:", submapkey
                continue
            nm, sep, value = line.partition('=')
            if sep == '':
                continue
            nm = nm.strip()
            value = value.strip()
            #print "Name:", nm, "Value:", value

            if not self.submaps.has_key(submapkey):
                self.submaps[submapkey] = {}
            self.submaps[submapkey][nm] = value

    def get(self, nm, sk = ''):
        '''Returns None if not found, empty string if found empty'''
        if not self.submaps.has_key(sk):
            return None
        if not self.submaps[sk].has_key(nm):
            return None
        return self.submaps[sk][nm]

    def getNames(self, sk = ''):
        if not self.submaps.has_key(sk):
            return None
        return self.submaps[sk].keys()
    
class ConfTree(ConfSimple):
    """A ConfTree adds path-hierarchical interpretation of the section keys,
    which should be '/'-separated values. When a value is requested for a
    given path, it will also be searched in the sections corresponding to
    the ancestors. E.g. get(name, '/a/b') will also look in sections '/a' and
    '/' or '' (the last 2 are equivalent"""
    def get(self, nm, sk = ''):
        if sk == '' or sk[0] != '/':
            return ConfSimple.get(self, nm, sk)
            
        if sk[len(sk)-1] != '/':
            sk = sk + '/'

        # Try all sk ancestors as submaps (/a/b/c-> /a/b/c, /a/b, /a, '')
        while sk.find('/') != -1:
            val = ConfSimple.get(self, nm, sk)
            if val is not None:
                return val
            i = sk.rfind('/')
            if i == -1:
                break
            sk = sk[:i]

        return ConfSimple.get(self, nm)

class ConfStack:
    """ A ConfStack manages the superposition of a list of Configuration
    objects. Values are looked for in each object from the list until found.
    This typically provides for defaults overriden by sparse values in the
    topmost file."""

    def __init__(self, nm, dirs, tp = 'simple'):
        fnames = []
        for dir in dirs:
            fnm = os.path.join(dir, nm)
            fnames.append(fnm)
            self._construct(tp, fnames)

    def _construct(self, tp, fnames):
        self.confs = []
        for fname in fnames:
            if tp.lower() == 'simple':
                conf = ConfSimple(fname)
            else:
                conf = ConfTree(fname)
            self.confs.append(conf)

    def get(self, nm, sk = ''):
        for conf in self.confs:
            value = conf.get(nm, sk)
            if value is not None:
                return value
        return None

class RclDynConf:
    def __init__(self, fname):
        self.data = ConfSimple(fname)

    def getStringList(self, sk):
        nms = self.data.getNames(sk)
        out = []
        if nms is not None:
            for nm in nms:
                out.append(base64.b64decode(self.data.get(nm, sk)))
        return out
    
class RclConfig:
    def __init__(self, argcnf = None):
        # Find configuration directory
        if argcnf is not None:
            self.confdir = os.path.abspath(argcnf)
        elif os.environ.has_key("RECOLL_CONFDIR"):
            self.confdir = os.environ["RECOLL_CONFDIR"]
        else:
            self.confdir = os.path.expanduser("~/.recoll")
        #print "Confdir: [%s]" % self.confdir
        # Also find datadir. This is trickier because this is set by
        # "configure" in the C code. We can only do our best. Have to
        # choose a preference order. Use RECOLL_DATADIR if the order is wrong
        self.datadir = None
        if os.environ.has_key("RECOLL_DATADIR"):
            self.datadir = os.environ["RECOLL_DATADIR"]
        else:
            dirs = ("/opt/local", "/usr", "/usr/local")
            for dir in dirs:
                dd = os.path.join(dir, "share/recoll")
                if os.path.exists(dd):
                    self.datadir = dd
        if self.datadir is None:
            self.datadir = "/usr/share/recoll"
        #print "Datadir: [%s]" % self.datadir
        self.cdirs = [self.confdir,]
        self.cdirs.append(os.path.join(self.datadir, "examples"))
        #print self.cdirs
        self.config = ConfStack("recoll.conf", self.cdirs, "tree")
        self.keydir = ''

    def getConfDir(self):
        return self.confdir
    
    def setKeyDir(self, dir):
        self.keydir = dir

    def getConfParam(self, nm):
        return self.config.get(nm, self.keydir)
        
class RclExtraDbs:
    def __init__(self, config):
        self.config = config

    def getActDbs(self):
        dyncfile = os.path.join(self.config.getConfDir(), "history")
        dync = RclDynConf(dyncfile)
        return dync.getStringList("actExtDbs")
    
