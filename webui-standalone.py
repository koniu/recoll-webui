#!/usr/bin/env python
import bottle
import webui

bottle.debug(True)
bottle.run(host='localhost', port=8080, reloader=True)

# vim: foldmethod=marker:filetype=python:textwidth=80:ts=4:et
