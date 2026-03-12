#!/bin/bash

# 清除.gitignore中指定的所有文件

# 进入项目根目录
cd "$(dirname "$0")"

echo "开始清除.gitignore中指定的文件..."

# 检查.gitignore文件是否存在
if [ ! -f ".gitignore" ]; then
    echo "错误：.gitignore文件不存在！"
    exit 1
fi

# 读取并解析.gitignore文件
# 忽略注释、空行，处理例外规则
ignored_patterns=()
exception_patterns=()

while IFS= read -r line || [ -n "$line" ]; do
    # 跳过注释和空行
    if [[ "$line" =~ ^#.*$ ]] || [[ -z "$line" ]]; then
        continue
    fi
    
    # 处理例外规则（以!开头的模式）
    if [[ "$line" =~ ^!.*$ ]]; then
        exception_pattern="${line#!}"  # 移除开头的!
        exception_patterns+=($exception_pattern)
        continue
    fi
    
    # 添加到忽略模式列表
    ignored_patterns+=($line)
done < ".gitignore"

# 显示要删除的模式
echo "将删除以下模式匹配的文件："
for pattern in "${ignored_patterns[@]}"; do
    echo "  - $pattern"
done

# 显示例外规则
echo "\n例外（不会删除）："
for pattern in "${exception_patterns[@]}"; do
    echo "  - $pattern"
done

# 询问用户是否继续
read -p "\n确定要删除这些文件吗？(y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "操作已取消"
    exit 0
fi

echo "\n开始删除文件..."

# 删除匹配忽略模式但不匹配例外模式的文件
deleted_files=0

for pattern in "${ignored_patterns[@]}"; do
    # 查找匹配的文件
    files=$(find . -name "$pattern" -type f 2>/dev/null)
    
    for file in $files; do
        # 检查是否匹配任何例外模式
        skip=false
        for exception in "${exception_patterns[@]}"; do
            if [[ "$file" == *"$exception"* ]]; then
                skip=true
                break
            fi
        done
        
        if [ "$skip" = false ]; then
            # 删除文件
            rm -f "$file"
            if [ $? -eq 0 ]; then
                echo "已删除: $file"
                ((deleted_files++))
            fi
        fi
    done
    
    # 处理目录模式
    if [[ "$pattern" == */* ]] && [[ "$pattern" != */\* ]]; then
        if [ -d "$pattern" ]; then
            # 检查是否匹配任何例外模式
            skip=false
            for exception in "${exception_patterns[@]}"; do
                if [[ "$pattern" == *"$exception"* ]]; then
                    skip=true
                    break
                fi
            done
            
            if [ "$skip" = false ]; then
                # 删除目录及其内容
                rm -rf "$pattern"
                if [ $? -eq 0 ]; then
                    echo "已删除目录: $pattern"
                    ((deleted_files++))
                fi
            fi
        fi
    fi
done

echo "\n清除完成！总共删除了 $deleted_files 个文件或目录。"