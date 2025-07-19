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

# for ((round=1; round<=n; round++)); do
#     echo "branch $round genrating..."
#     for i in {1..47}; do
#         name="d${counter}.sql"
#         echo "generate $name"
#         ./qgen $i > "$outdir/$name"
        
#         ((counter++))
#     done
# done

for ((round=1; round<=n; round++)); do
    for i in {1..47}; do
        name="q${counter}.sql"
        seed=$(date +%s%N)  # 当前时间作为种子
        echo "generate $name with seed=$seed"
        ./qgen -r "$seed" -p $((RANDOM % 100 + 1)) $i > "$outdir/$name"
        ((counter++))
        sleep 0.1
    done
done


echo "move all queries to $outdir/."
