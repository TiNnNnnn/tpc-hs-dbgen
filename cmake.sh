# 'n': num of batch you want to generate
# example: ./cmake.sh 4
n=${1:-1}

# set your target dir, queries will be copy to the target dir
target_dir="/home/yyk/Sqms-On-Postgresql/contrib/sqms/test/tpch_query_slow"

make clean && make
rm -rf ./queries/qgen
cp qgen ./queries

cd queries 
./qgen.sh ${n}

rm -rf ${target_dir}
mkdir -p ${target_dir}
cp -r ./slow_queries/* ${target_dir}

echo "mv $((n * 47)) queries to ${target_dir}"

cd ..
