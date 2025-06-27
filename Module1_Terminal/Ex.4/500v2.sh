#!/bin/bash

if [ -z "$1" ]; then 
    echo "Введите директорию: $0 <Директория>"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Файл не существует или не является директорией"
    exit 1
fi

count_txt=0
count_exe=0
count_empty_dir=0

found_txt=0
for item_txt in "$1"/*.txt; do
    if [ -f "$item_txt" ]; then
        if [ $found_txt -eq 0 ]; then
            echo "=====Текстовые файлы====="
            found_txt=1
        fi
        echo "Текстовый файл $(basename "$item_txt") и его первые 3 строчки:"
        head -n 3 "$item_txt"
        ((count_txt++))
    fi
done
if [ $found_txt -eq 0 ]; then 
    echo "Текстовые файлы не обнаружены"
fi

found_exe=0
for item_exe in "$1"/*; do 
    if [ -f "$item_exe" ] && [ -x "$item_exe" ]; then 
        if [ $found_exe -eq 0 ]; then
            echo -e "\n=====Исполняемые файлы====="
            found_exe=1
        fi
        echo "Размер исполняемого файла: $(basename "$item_exe") - $(du -sh "$item_exe" | cut -f1)"
        ((count_exe++))
    fi
done
if [ $found_exe -eq 0 ]; then 
    echo -e "\nИсполняемые файлы не обнаружены"
fi

found_empty=0
for edir in "$1"/*/; do
    if [ -d "$edir" ] && [ -z "$(ls -A "$edir" 2>/dev/null)" ]; then 
        if [ $found_empty -eq 0 ]; then
            echo -e "\n=====Пустые директории====="
            found_empty=1
        fi
        echo "Предупреждение: директория: $(basename "$edir") пустая"
        ((count_empty_dir++))
    fi
done
if [ $found_empty -eq 0 ]; then 
    echo -e "\nПустые директории не обнаружены"
fi

echo -e "\nРезультаты:"
echo "Количество исполняемых файлов: $count_exe"
echo "Количество пустых директорий: $count_empty_dir"
echo "Количество текстовых файлов: $count_txt"