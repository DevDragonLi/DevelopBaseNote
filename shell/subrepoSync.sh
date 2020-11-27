#!/bin/bash
# clone/update all subPod repo 
# 1.子组件首次下载并配置git信息 2.子组件更新 3.子组件缺失下载

# 使用：主目录 新建subPodconfig文件夹，新建codingrooturl文件，首行写入公司代码检出主网页
# subPodconfig文件夹下新增subPodList每行写入子组件repo地址。

printf "        \033[34m clone/update dependencies Pods Repo Tool \033[0m \n"

if [[ -d subPods ]];then
    echo -e "\033[35m即将同步所有笔记项目依赖子组件远端代码到本地。\033[0m"
else
    
    mkdir subPods
    
    echo -e "\033[36m\n首次检出子组件仓库，已为您自动处理子组件仓库主目录. \033[0m"
    echo -e "\033[35m请输入您的邮箱信息 \033[0m"
    
    read coding_code_email   

    coding_code_name=${coding_code_email%@*} >/dev/null 2>&1

    echo -e "\033[36m您输入的组件仓库配置信息如下⬇️\n\n\033[34mEmail :\033[32m${coding_code_email}\n\033[34mAuthor:\033[32m${coding_code_name}\033[0m"
fi 

echo -e "\033[35m\nBegain clone/update  all private dependencies Pods ! Please Waiting ☕️\033[0m"

if [[ -d subPodconfig ]];then
    echo 
else
   	echo -e "\033[31m无法读取依赖配置信息，同步终止！\033[0m" 
    exit 0  
fi

coding_ssh_url=`head -n +1 subPodconfig/codingrooturl` 

cat ./subPodconfig/subPodList | while read pod_name ;do

    if [[ -d NotePods/${pod_name} ]]; then

        (cd subPods/${pod_name} && git stash  >/dev/null 2>&1 && git pull --rebase >/dev/null 2>&1 && git stash pop  >/dev/null 2>&1)   
       
        cd subPods/${pod_name}
        # (cp -f  ../../subPodconfig/pre-commit .git/hooks/pre-commit) hook机制
        this_pod_git_name=`git config user.name` 

        if [ -n "$this_pod_git_name" ];then
            echo -e "\033[36mHello ${this_pod_git_name} : \033[34m${pod_name}组件已同步完成！！！\033[0m"
        else
            #未配置
            echo -e "\033[34m   ${pod_name}组件已同步完成！！！\n\033[0m"
            echo -e "\033[31m${pod_name} Git Info unSettings，Please following below cmd run by Youself！\n 1.config user.name xxx\n 2.config user.email xxx\033[0m"
        fi

        cd ../../
    else
        (cd subPods && git clone ${coding_ssh_url}${pod_name}  >/dev/null 2>&1 && cd ${pod_name} && git config user.email $coding_code_email && git config user.name $coding_code_name )
        
        echo -e "\033[35m🚴本地缺失的${pod_name}组件,已下载到本地子组件库中。\033[0m"
    fi 

done

