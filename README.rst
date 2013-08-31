============
Recoll WebUI
============

**Recoll WebUI** is a Python-based web interface for **Recoll** text search
tool for Unix/Linux.

.. image:: http://i.imgur.com/n8qTnBg.png

* WebUI homepage: https://github.com/koniu/recoll-webui
* Recoll homepage: http://www.lesbonscomptes.com/recoll

Requirements
============

All you need to use the WebUI is:

* Python 2.x
* Recoll 1.18.1+
* web browser

Usage
=====

**Recoll WebUI** can be used as a standalone application or through a web
server via WSGI/CGI. Regardless of the mode of operation you need Recoll
to be configured on your system as the WebUI only provides a front-end for
searching and does not handle index configuration etc.

Standalone
----------
Run ``webui-standalone.py`` and connect to ``http://localhost:8080``.

To change the default port, edit ``webui-standalone.py``.

WSGI/CGI
--------
TODO


Issues
======

Can't open files when Recoll WebUI is running on a server
---------------------------------------------------------
By default links to files in the result list correspond to the file's
physical location on the server. If you have access to the file tree
via a local mountpoint or eg. ftp/http you can provide replacement
URLs in the WebUI settings. If in doubt, ask your network administrator.

Opening files via local links
-----------------------------
For security reasons modern browsers prevent linking to local content from
'remote' pages. As a result URLs starting with file:// will not, by default,
be opened when linked from anything else than pages in file:// or when
accessed directly from the address bar. Here's ways of working around it:

Firefox
~~~~~~~
1. Insert contents of ``examples/firefox-user.js`` into
   ``~/.mozilla/firefox/<profile>/user.js``
2. Restart Firefox

Chrom{e,ium}
~~~~~~~~~~~~
Install *LocalLinks* extension:

* http://code.google.com/p/locallinks/
* https://chrome.google.com/webstore/detail/locallinks/jllpkdkcdjndhggodimiphkghogcpida

Opera
~~~~~
1. Copy ``examples/opera-open.sh`` into your PATH (eg. ``/usr/local/bin``)
2. Go to ``Tools > Preferences > Advanced > Programs > Add``
3. In ``Protocol`` field enter ``local-file``
4. Select ``Open with other application`` and enter ``opera-open.sh``
5. In WebUI settings replace all ``file://`` with ``local-file://``
