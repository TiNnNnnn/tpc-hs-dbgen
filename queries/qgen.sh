#!/bin/bash

# 设置默认轮次为1
n=${1:-1}

# 设置输出目录
outdir="slow_queries"

echo "prepare $outdir ..."
rm -rf "$outdir"
mkdir -p "$outdir"

counter=1

echo "begin generate $((n * 47)) queries..."

for ((round=1; round<=n; round++)); do
    echo "branch $round genrating..."
    for i in {1..47}; do
        name="d${counter}.sql"
        echo "generate $name"
        ./qgen $i > "$outdir/$name"
        ((counter++))
    done
done

echo "move all queries to $outdir/."
