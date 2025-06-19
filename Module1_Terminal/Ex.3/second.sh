#!/bin/bash

username=$(whoami)

mkdir ~/$username

echo "Привет, $username, че как?" > "~/$username/welcome.txt"

echo "все получилось"
