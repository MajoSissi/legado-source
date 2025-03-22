#!/bin/bash

# 克隆仓库
echo "开始克隆仓库..."
git clone https://github.com/jiwangyihao/source-j-legado
cd source-j-legado || exit

# 查找所有json文件
echo "查找所有json文件..."
json_files=$(find . -name "*.json" -type f -not -path "*/\.*")

# 初始化输出文件，添加数组开始符号
echo "[" > ../light-novel.json

# 记录处理过的文件数量
count=0
total=$(echo "$json_files" | wc -l)

# 遍历所有json文件
for file in $json_files; do
    count=$((count+1))
    echo "处理文件 $count/$total: $file"
    
    # 提取json文件中的数组内容（去掉开头的 [ 和结尾的 ]）
    content=$(sed -e 's/^\[//' -e 's/\]$//' "$file")
    
    # 如果内容不为空，则添加到输出文件
    if [ -n "$content" ]; then
        # 如果不是第一个文件且上一个文件有内容，添加逗号分隔
        if [ "$count" -gt 1 ]; then
            echo "," >> ../light-novel.json
        fi
        
        # 写入内容（不包含数组的开头和结尾括号）
        echo "$content" >> ../light-novel.json
    fi
done

# 添加数组结束符号
echo "]" >> ../light-novel.json

# 返回上级目录并删除克隆的仓库
cd ..
echo "清理克隆的仓库..."
rm -rf source-j-legado

echo "完成！所有json文件已合并到 light-novel.json"
