#!/bin/bash

echo "Введите ваше имя"

read username

mkdir ~/"$username"

echo "Привет, $username! Это твоя первая папка." > ~/"$username"/welcome.txt

echo "Успешно, в домашней директории создана папка - $username"
