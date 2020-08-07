
#!/bin/bash
# clone/update all repo 

printf "         \033[32m  subPod Tool UpdateTime:2020/08/07 Version ：1.0.0 \033[0m \n"

printf "\033[31m firstly make sure you No connection to the VPN ！！！\n\n\n  \033[0m"

# 依赖pod组件主目录
private_pods_root_path=privatePods

if [[ -d ${private_pods_root_path} ]]; then
  
echo -e "\033[35m子组件仓库主目录已存在，即将同步所有子组件远端代码到本地。\033[0m"

else

mkdir ${private_pods_root_path}

echo -e "\033[32m当前未同步过子组件仓库，已处理子组件仓库主目录 ${private_pods_root_path} 到宿主工程主目录😁 \033[0m"

echo -e "\033[35m请输入组件仓库的注册邮箱（例如：xxx@gamil.com） \033[0m"

read pod_code_email

echo -e "\033[35m请输入组件仓库的注册名称（例如：trump） \033[0m"

read pod_code_name

fi 


echo -e "\033[34mBegain clone/update  all privatePods ! Please Wating ☕️☕️☕️\033[0m"

cat ./exapmleRepoList | while read pod_name ;do


if [[ -d ${private_pods_root_path}/${pod_name} ]]; then

echo -e "\033[36m${pod_name}组件同步远端代码中！！！\033[0m"

(cd ${private_pods_root_path}/${pod_name} && git stash && git pull && git stash pop)

else

echo -e "\033[35m${pod_name}组件下载到本地中\033[0m"

(cd ${private_pods_root_path} && git clone https://github.com/DevDragonli/${pod_name} && git config user.email $pod_code_email && git config user.name $pod_code_name )

fi 

done
