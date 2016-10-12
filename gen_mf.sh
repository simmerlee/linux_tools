#!/bin/bash

print_usage(){
    echo -e "\nUsgae:\n\
    gen_mf [-fxds]\n\n\
Args:\n\
    -f  force rewrite is Makefile already exist
    -x  C++ language
    -d  dynamic lib
    -s  static lib"
}

arg_f=0
arg_d=0
arg_s=0
cc=gcc
flag_name=cflags
flags="-W -c"

# parse arguments
while getopts "fxds" arg
do
    case $arg in
    f)
        arg_f=1
        ;;
    x)
        cc=g++
        flag_name=cxxflags
        ;;
    d)
        arg_d=1
        flags=$flags" -fpic"
        ;;
    s)
        arg_s=1
        ;;
    ?)
        print_usage
        ;;
    esac
done

# check if rewrite
if [ $arg_f -eq 0 ]
then
    stat Makefile >/dev/null 2>/dev/null
    ret=$?
    if [ $ret -eq 0 ]
    then
        echo -n "Makefile is already exist, rewrite it? (y/n) "
        read input
        if [ $input != "Y" -a $input != "y" ]
        then
            exit 0
        fi
    fi
fi

if [ $arg_s -eq 1 -a $arg_d -eq 1 ]
then
    echo "arguments -s and -d can not use together."
    exit 1
fi

# handle arguments
if [ $arg_s -eq 1 ]
then 
    gen_static_lib_cmd="\tar cvr \$(target) \$(objs)"
fi
if [ $arg_d -eq 1 ]
then
    gen_dynamic_lib_cmd="\t\$(cc) -shared \$(objs) -o \$(target)"
fi
if [ $arg_s -eq 0 -a $arg_d -eq 0 ]
then
    gen_exe_cmd="\t\$(cc) \$(ojbs) -o \$(target)"
fi

# generate Makefile
file_name=Makefile
echo -e "cc = $cc\n\
$flag_name = $flags\n\
target = \n\
objs = \n\n\
\$(target) : \$(objs)\n\
$gen_exe_cmd$gen_static_lib_cmd$gen_dynamic_lib_cmd \n\n\
\t\$(cc) \$($flag_name) \$< -o \$@\n\n\
clean :\n\
\trm -f \$(objs) \$(target)\n" > $file_name

