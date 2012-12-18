#!env python
import os
import bottle
import webui

os.chdir(os.path.dirname(__file__))
application = bottle.default_app()
# vim: foldmethod=marker:filetype=python:textwidth=80:ts=4:et
