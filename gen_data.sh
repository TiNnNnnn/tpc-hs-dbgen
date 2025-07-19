#'n': sf
#example: ./gen_data.sh 5 (generate 5G data) 
n=${1:-1}

target_dir="/home/yyk/Sqms-On-Postgresql/contrib/sqms/test2/tbl_data"
# tbl_data will be divide into multi batchs. here create target_dir2
target_batch_dir="/home/yyk/Sqms-On-Postgresql/contrib/sqms/test2/tbl_batches"

rm -rf tbl
mkdir tbl

echo "generating data for scale factor ${n} GB"
./dbgen -s ${n} -f

echo "copying data to tbl directory"
for i in `ls *.tbl`
do
 name="tbl/$i"
 echo $name
 `touch $name`
 `chmod 777 $name`
 sed 's/|$//' $i >> $name;
done

echo "---------------------------------"
du -h ./tbl/*.tbl | sort -hr
echo "---------------------------------"

rm -rf ${target_dir}
mkdir -p ${target_dir}

rm -rf ${target_batch_dir}
mkdir -p ${target_batch_dir}

cp -r ./tbl/* ${target_dir}

#echo "importing data to postgresql"
#/home/yyk/Sqms-On-Postgresql/bin/psql -p 44444 -U postgres -f ./import.sql