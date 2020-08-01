# !/bin/bash
# helper tool

echo -e "         \033[32m  Dev Env install Tool By DragonLi (Version 1.0.0) \033[0m \n"

HTTP_CODE=`curl --connect-timeout 5 -o /dev/null 2>&1 -s --head -w "%{http_code}" "https://Twitter.com"`

if [ ${HTTP_CODE} -ne 200 ]

then
  
echo -e "\033[31m当前网络环境无法满足安装条件，请切换网络环境后再重试！！！\033[0m"
exit -1024  

else 

echo -e "\033[32m		恭喜，当前网络环境检测通过。😁 \033[0m"

fi

echo -e "\033[35m 🚀：begain installing Homebrew,may take some times! Please Wating ☕️☕️☕️ \033[0m"

(/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)")

if [[ $? -ne 0 ]]

then

echo -e "\033[31m install Homebrew error ！！！\n\n\n  \033[0m"

# exit -256

fi	

echo -e "\033[35m 🚀：begain rvm update 😁 \033[0m"

ruby -v && curl -L get.rvm.io | bash -s stable

source ~/.bashrc && source ~/.bash_profile
rvm -v && rvm install "ruby-2.7.0" && rvm use 2.7.0 --default


if [[ $? -ne 0 ]]
then

echo -e "\033[31m update rvm error ！！！\n\n\n  \033[0m"

# exit -512

fi

echo -e "\033[35m gem update  \033[0m"

sudo gem update --system

gem list --local 

gem sources --remove https://cdn.cocoapods.org/ && gem sources --remove https://rubygems.org/ && gem sources --add https://gems.ruby-china.com/ && gem sources -l


if [[ $? -ne 0 ]]

then

echo -e "\033[31m update gem error ！！！\n\n\n  \033[0m"

else

echo -e "\033[32m update gem  done \033[0m \n"

fi

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


echo -e "\033[32m all operation done 🍺 🍺 🍺  \033[0m \n"


echo -e "\033[32m cocoapods , you can cancel it\033[0m"

# option 
sudo gem install -n /usr/local/bin cocoapods 

exit -1024









