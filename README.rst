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
* Recoll 1.17+
* web browser

Download
========
If your Recoll version is 1.18.2 or newer:
        https://github.com/koniu/recoll-webui/archive/master.zip
If your Recoll version version is 1.17-1.18.1:
        https://github.com/koniu/recoll-webui/archive/v1.18.1.zip
You can fetch the full git repository like this:
        ``git clone https://github.com/koniu/recoll-webui.git``

Usage
=====

**Recoll WebUI** can be used as a standalone application or through a web
server via WSGI/CGI. Regardless of the mode of operation you need Recoll
to be configured on your system as the WebUI only provides a front-end for
searching and does not handle index configuration etc.

Run standalone
--------------
Run ``webui-standalone.py`` and connect to ``http://localhost:8080``.

There's some optional command-line arguments available:::

    -h, --help            show this help message and exit
    -a ADDR, --addr ADDR  address to bind to [127.0.0.1]
    -p PORT, --port PORT  port to listen on [8080]

Run as WSGI/CGI
---------------

Example WSGI/Apache2 config

        WSGIDaemonProcess recoll user=recoll group=recoll threads=5 display-name=%{GROUP} python-path=/var/recoll-webui-master
        WSGIScriptAlias /recoll /var/recoll-webui-master/webui-wsgi.py
        <Directory /var/recoll-webui-master>
                WSGIProcessGroup recoll
                Order allow,deny
                allow from all
        </Directory>

Remarks:
* Without "python-path=" you might see errors that it can't import webui 
* Run the WSGIDeamonProcess run under the username (user=xyz) of the user that you want to have exposed via web


Example Upstart-Script for Ubuntu to run the indexer as daemon


        description "recoll indexer"

        start on runlevel [2345]
        stop on runlevel [!2345]
        
        respawn
        
        pre-start script
                exec sudo -u recoll sh -c "/usr/local/share/recoll/examples/rclmon.sh start"
        end script
        
        pre-stop script
                exec sudo -u recoll sh -c "/usr/local/share/recoll/examples/rclmon.sh stop"
        end script

Remarks:
* You need to configure the user for which the indexer should run ("sudo -u [myuser])


Example Crontab entry to have the indexer at least once a day

        22 5    * * *   recoll  recollindex



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
