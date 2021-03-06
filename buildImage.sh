#!/bin/sh

if test -z "$1"
then
    echo "Usage: ./buildImage.sh [version]"
else
    ./premake.sh
    make -j8 config=release
    sudo docker build -t meepdocker/classroom-bot:latest -t meepdocker/classroom-bot:$1 .
fi