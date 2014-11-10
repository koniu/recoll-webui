#!/usr/bin/env python
import os
import argparse
import webui

# handle command-line arguments
parser = argparse.ArgumentParser()
parser.add_argument('-a', '--addr', default='127.0.0.1',help='address to bind to [127.0.0.1]')
parser.add_argument('-p', '--port', default='8080', type=int, help='port to listen on [8080]')
args = parser.parse_args()

# change to webui's directory and import
if os.path.dirname(__file__) != "":
    os.chdir(os.path.dirname(__file__))

# set up webui and run in own http server
webui.bottle.debug(True)
webui.bottle.run(host=args.addr, port=args.port, reloader=False)

# vim: foldmethod=marker:filetype=python:textwidth=80:ts=4:et
