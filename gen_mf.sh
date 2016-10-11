#!/bin/bash

file_name=Makefile
echo "cc = " >> $file_name
echo "cflags = " >> $file_name
echo "target = " >> $file_name
echo "objs = " >> $file_name
echo -e "\n\$(target) : \$(objs)\n" >> $file_name
echo -e "\t\$(cc) \$(cflags) \$< -o \$@\n" >> $file_name
echo "clean :" >> $file_name
echo -e "\trm -f \$(objs) \$(target)" >> $file_name
