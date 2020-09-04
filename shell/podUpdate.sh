#!/bin/bash
# adjust PodName ！！！
podspec_full_name="PodName.podspec"
podspec_name="PodName"
podspec_path=$podspec_full_name
podspecRepo="RepoName"
version_string=`grep -E 's.version.*=' ${podspec_full_name}`
version_number=`tr -cd [0-9][.] <<<"${version_string#*s.version          = }"`
echo -e "\033[32m\n当前版本为 ${version_number}\n请输入本次更新的版本号（例如：1.0.1 /1.1.0 /2.1.0 \033[0m"

read tag_version

if [ -z $tag_version ];then

    echo -e "\033[31m \n 输入格式错误，请重新运行脚本，输入正确格式的tag版本号\n \033[0m"
else

    reg='^[0-9]{1,4}\.[0-9]{1,4}\.[0-9]{1,2}$'
    echo "确认输入新版本信息为："${tag_version}

    if [[ "$tag_version" =~ $reg ]];then
        echo -e "\033[32m \n恭喜你，输入的版本号，格式验证通过\n \033[0m"
    else
        echo -e"\033[31m \n输入格式错误，请重新运行脚本，输入正确格式的tag版本号\n"
        exit 1
    fi
fi


echo -e "\033[32m 请输入本次更新日志（example：修复了iOS 14下布局错乱的问题） \033[0m"

read commit_msg

if [ -n "$commit_msg" ]

then

 	while read line
    do
        find_version="^s.version"
        if [[ "$line" =~ $find_version ]];then
            echo "File:${line}"
            sed -i "" "s/${line}/s.version      = \"$tag_version\"/g" $podspec_path
        fi
    done < $podspec_path

	
	git add . && git status

	git pull --rebase 

	echo -e "\033[35m 已添加全部改动文件到暂存区 \033[0m"

	git commit -m "【${tag_version}】$commit_msg "   
	
	git tag -a $tag_version -m $commit_msg

	echo -e "\033[36m begain Push to origin \033[0m"
	
	git push git push --tags 

	echo -e "\033[36m $tag_version ${podspec_name} begain Push to ZDSpecs  \033[0m"

	pod repo push ${podspecRepo} ${podspec_full_name} --allow-warnings 


	if [[ $? -eq 0 ]]

	then	
	  	echo -e "\033[35m $tag_version ${podspec_name} 组件更新成功，辛苦啦☕️\033[0m"
	
	fi

else
	echo -e "\033[31m请输入改动日志后再重试！！！\033[0m"
	exit 0
fi
