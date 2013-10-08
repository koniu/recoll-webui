#!/usr/bin/env python
import os
# change to webui's directory and set up
os.chdir(os.path.dirname(__file__))
import webui
application = webui.bottle.default_app()
# vim: foldmethod=marker:filetype=python:textwidth=80:ts=4:et
