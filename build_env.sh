#!/bin/bash
mkdir -m 777 -p cache/buildozer cache/gradle
docker build -t builder docker/ --no-cache
