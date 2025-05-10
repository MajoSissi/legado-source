#!/bin/bash
# 所有待整理书源放到临时目录
books=books
# 单文件书源
wget -O $books/Japan.json https://github.com/ZWolken/Light-Novel-Yuedu-Source/releases/latest/download/Japan_based_bookSource.json
wget -O $books/Bot.json https://static.kksk.io/uuyr/b15e68c9cbdbad2000d52b7bc9137e7f.json
# 仓库书源
git clone https://github.com/jiwangyihao/source-j-legado source-j-legado
cp source-j-legado/*.json $books
rm -rf source-j-legado
# 整合书源
node light-novel

