#!/bin/bash

VERSION_SUFFIX=7.3.2.1-debian

docker build -t elastic/filebeat:${VERSION_SUFFIX} ./
