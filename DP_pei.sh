#!/bin/bash
#=================================================
#	System Required: Centos
#	Description: PEI Issue
#	Version: 1.0.31
#	Author: Peiygah
#=================================================
. ~/.bash_profile
B_f="\e[34m" && Y_f="\e[33m" && R_f="\e[31m" && F_r="\e[0m"
Info="${B_f}[Info]${F_r}"
Error="${R_f}[Error]${F_r}"
peifiles="/tmp/peifiles.txt"
backup(){
	printf "${Info}Plz paste Update files"
	read pppa1
	>$peifiles;vi $peifiles;
	sed -e "s/\t/\//g" -e 's/\/\//\//g' -e 's/\$/\\\$/g' -i $peifiles
	sed -e ":label;N;s/\n/ /;b label" -i $peifiles
	Files=`cat $peifiles`
	printf "${Info}Plz input Issue\n"
	read Issue
	if [ -z "$Files" -o -z "$Issue" ];then printf  "${Error}Input is empty!\n";exit 1;fi;
	printf "${Info}Check files\n"
	for i in $Files; do if [ ! -f $i ];then printf "${Error}${i} is not exist!\n";fi;done
	cd /home/backup
	mkdir -p `date +"%Y%m%d"`/$Issue;cd `date +"%Y%m%d"`/$Issue;
	filezip=$(basename `pwd`)_bak.zip
	printf "${Info}${Y_f}cd `pwd`${F_r}\n${Info}Backup files to ${filezip}\n"
	if [ -f "$filezip" ] ;then printf "${Info}${filezip} is exist! Continue by ${filezip:0:-4}_1.zip backup? (yes & other cancel) ";read pd1;if [ "${pd1,,}" == "y" -o "${pd1,,}" == "yes" ];then  filezip=${filezip:0:-4}_1.zip;else printf "${Error}Cancel backup\n";exit 0;fi;fi;
	for i in $Files; do if [ -f $i ];then zip -r $filezip $i;fi;done
	printf "${Info}Check ${filezip}\n"
	unzip -l $filezip|sed -e "1,2d" -e "3s/ .* / $filezip /"
	cd /home/mdb
	mkdir -p `date +"%Y%m%d"`/$Issue;cd `date +"%Y%m%d"`/$Issue;
	printf "${Info}Next\n${Info}${Y_f}cd `pwd`${F_r}\n"
}
printf "${B_f}==========【Peiy 1.0.31】=======${F_r}\n\n"
backup
