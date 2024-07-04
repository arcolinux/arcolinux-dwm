#!/bin/bash

make clean
make
sudo make install
make clean

echo
tput setaf 2
echo "################################################################"
echo "Press super + shift + r to reload your new Chadwm build"
echo "################################################################"
tput sgr0
echo
