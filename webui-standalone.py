#!/usr/bin/env python
import os
# change to webui's directory and import
os.chdir(os.path.dirname(__file__))
import webui
# set up webui and run in own http server
webui.bottle.debug(True)
webui.bottle.run(host='localhost', port=8080, reloader=False)

# vim: foldmethod=marker:filetype=python:textwidth=80:ts=4:et
