#!/bin/bash

echo -e "\033[32m 请输入本次更新日志（example：修复了iOS 14下布局错乱的问题） \033[0m"

read commit_msg

# 需要替换为真实pod名称
podspec_name='podspecName'


if [ -n "$commit_msg" ]

then

	git add .

	git status

	git pull --rebase 

	echo -e "\033[35m 已添加全部改动文件到暂存区 \033[0m"
	
	version_string=`grep -E 's.version.*=' ${podspec_name}.podspec`

	version_number=`tr -cd [0-9][.] <<<"${version_string#*s.version          = }"`

	git commit -m "【${version_number}】$commit_msg "   

	git pull --rebase 
	
	git tag -a $version_number -m $commit_msg

	echo -e "\033[36m begain Push to Origin \033[0m"
	
	git push

	git push --tags 

	echo -e "\033[36m $version_number ${podspec_name} begain Push to ZDSpecs  \033[0m"

	pod repo push ZDSpecs ${podspec_name}.podspec --allow-warnings 


	if [[ $? -eq 0 ]]

	then	
	  	echo -e "\033[35m $version_number ${podspec_name} 组件更新成功，辛苦啦☕️☕️☕️☕️ \033[0m"
	
	fi

else
	echo -e "\033[31m请输入改动日志后再重试！！！\033[0m"
	exit -1024
fi