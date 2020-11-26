# !/bin/bash
# podspec file must be s.version ✅ 【而非spec.version或者其他】

echo -e "\033[32m\n			Welcome User Auto Update Pod Tool 【2.0.0】\n\033[0m"

echo -e "\033[36m提示:使用此脚本前，请确保已同步远端代码仓库并无冲突文件！\n\033[0m"

podspec_full_name=`find *.podspec`
# podspec_url
function check_podspecFileExist () {
	if [ -z ${podspec_full_name} ];then
    	echo -e "\033[31m \n❌：不存在'CocoaPods'组件描述文件，已退出。\033[0m"
		exit 0
	fi
}

check_podspecFileExist

version_string=`grep -E 's.version.*=' ${podspec_full_name}`

version_number=`tr -cd [0-9][.] <<<"${version_string#*s.version=}"`

version_number_adjust=${version_number#*.} # .1.0.0 > 1.0.0

pod_name=${podspec_full_name/.podspec/}

echo -e "\033[35m${pod_name}组件当前版本为${version_number_adjust}\033[36m 【提示:请输入本次更新的版本号（例如：1.0.1/1.0.1.0)】\033[0m"

read user_input_podspec_version  # 用户输入需要调整更新的组件版本信息

function check_input_podspec_version () {

	if [ -z $user_input_podspec_version ];then
    echo -e "\033[31m❌：未输入任何有效信息，请重新运行脚本，输入正确的组件版本号\033[0m"
	exit 0
	else
	# 备注：此脚本CocoaPods组件版本仅支持三/位版本号，其他版本类型不是此脚本的服务对象！！！
    pod_three_version_reg='^[0-9]{1,4}\.[0-9]{1,4}\.[0-9]{1,4}$'
	pod_four_version_reg='^[0-9]{1,4}\.[0-9]{1,4}\.[0-9]{1,4}\.[0-9]{1,4}$'
	echo 
    echo "你输入组件新版本为：${user_input_podspec_version}"

    	if [[ "$user_input_podspec_version" =~ $pod_three_version_reg ]] || [[ "$user_input_podspec_version" =~ $pod_four_version_reg ]];then
        
			echo -e "\033[32m\n✅：恭喜你输入的新版本通过校验\n \033[0m"
    	else

			echo -e "\033[31m❌：输入组件新版本不符合此脚本规范，请重新运行脚本，输入版本号"
			echo -e "\033[31m Tips：当前组件为三位版本规则，例如1.0.0/1.0.0.9999/1.0.0.0/1.0.0.0.9999"
        	exit 0
		fi
	fi
}

check_input_podspec_version

function update_spec_version() {
    while read line
	do
        find_pod_version="^s.version"
        if [[ "$line" =~ $find_pod_version ]];then
			# update user input message
            sed -i "" "s/${line}/s.version      = \"$user_input_podspec_version\"/g" $podspec_full_name
        fi
    done < $podspec_full_name
}

echo -e "\033[36m请输入本次更新日志（Example：修复了iOS 14下布局错乱的问题） \033[0m"

read commit_msg

function check_pod_compiler() {
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/DevDragonLi/DevelopBaseNote/master/shell/checkpod.sh)"
}

if [ -n "$commit_msg" ];then

	check_pod_compiler 
	
	update_spec_version

	git add .
	# 【提交信息】（组件名称：组件版本)
	commit_msg_txt="[$commit_msg]:(${pod_name}=${user_input_podspec_version})" 
	
	git commit -m ${commit_msg_txt}
	
	git tag -a $user_input_podspec_version -m ${commit_msg_txt}
	
	echo -e "\033[36mAll Changed Files Commit，Begain Push Remote Repo，Please Waiting😁\033[0m"

	(git push >/dev/null 2>&1) && (git push origin $user_input_podspec_version >/dev/null 2>&1)
	
	pod_repo_update_info=`mktemp`
	
    pod trunk push --swift-version=5.0 --skip-import-validation --skip-tests --use-json --allow-warnings --verbose > $pod_repo_update_info
	# 私有组件则  pod trunk push改为 pod repo push xxx --sources=${podspec_url}
    if [ "$?" -eq 0 ];then   
		echo -e "\033[35m $pod_name:${user_input_podspec_version} 组件更新成功,辛苦啦☕️\033[0m"
	else
		cat ${pod_repo_update_info}  | tail -n 1024
		echo -e "\033[31m$pod_name:${user_input_podspec_version} 组件更新失败,参考上述信息解决后再执行此脚本\033[0m"
	fi
	
else
	echo -e "\033[31m请输入组件更新日志后，再执行此脚本！！！\033[0m"
	exit 0
fi