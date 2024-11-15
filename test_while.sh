FILE_PATH=$(cd "$(dirname "$0")"; pwd)/test_file
FILE_NAME="test_file"
FILE_NUM=0

if [ ! -d $FILE_PATH ]; then 
    mkdir $FILE_PATH
fi

cd $FILE_PATH
if [ ! -f $FILE_NAME ]; then 
    touch $FILE_NAME
elif [ ! -f ${FILE_NAME}${FILE_NUM} ]; then
    mv $FILE_NAME ${FILE_NAME}${FILE_NUM}
else
    while [ -f ${FILE_NAME}${FILE_NUM} ]
    do
        FILE_NUM=$((FILE_NUM + 1))
    done
    mv $FILE_NAME ${FILE_NAME}${FILE_NUM}
fi

touch $FILE_NAME