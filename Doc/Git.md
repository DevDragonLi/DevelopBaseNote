#  Git 分布式世界

- [git-scm](http://git-scm.com)
- [Git命令图谱- @吴坚｜南航软件工程师](https://github.com/TeamStuQ/skill-map/blob/master/data/map-Git.md)
- [Gitflow -工作流 ](Gitflow.md)

# content list 

- **[base operation](#baseoperation)**    
- **[branch](#branch)**    
- **[merge  fetch conflict  reset ](#operation)**   
- **[rebase](#rebase)**
- **[tag](#tag)**     
- **[remote](#remoteoperation)**
- **[gitconfig](#gitconfig)**    
- **[alias](#alias)**    
- **[gitignore](#gitignore)**   
				
## <a name="baseoperation"></a> base operation

- `git init [project-name]` 	新建一个目录，将其初始化为Git代码库 
	
	- **工作区(Working Directory):** 当前 `.git` 根目录,除 `.git`
	- **版本库(Repository)** 工作区有⼀一个隐藏⽬目录`.git` stage(或者叫index)的暂存区:**git add”把⽂文件添加进去，实际上就是把⽂文件修改添加到暂存区**

- `git add [name]` 	添加当前目录的所有文件到暂存区 (和svn的不同)

- `git status `		显示有变更的文件 
- `git commit -m "change message"` 	提交日志 **实际上就是把暂存区的所有内容提交到当前分⽀支**

- `git commit --amend -m "again adjust change message"`	如果代码没有任何新变化，则用来改写上一次commit的提交信息
- `git checkout [filename]` 把filename文件在工作区的修改全部撤销

	- 一种是filename自修改后还没有被放到暂存区，现在，撤销修改就回到和版本库⼀模⼀样的状态;
	- 一种是filename已经添加到暂存区后，⼜作了修改，现在，撤销修改就回到添加到暂存区后的状态.

- `git rm -f [filename]` 文件从版本库中删除
- `git log`	显示当前分支的版本历史 
- `git log -p [filename]` 查看 README.md 的修改历史，例如：
	
	> git log -p README.md 
	
-  **git log --pretty=oneline** 

	```
	DragonLi-2:pythonRepo LFL$ git log --pretty=oneline
	4d43c74252ea01a0ffac5cff71c5853259e208f2 (HEAD -> master) adjust diff fix #1
	22c3340902e72394e7b2a5aab136cc76576f7ddb add coding
	446a8635555c20af39fd1c1856734e72af6cbb70 python.py
	
	```
- **git reflog⽤用来记录你的每⼀次命令** 
	- 要重返未来，用git reflog查看命令历史，以便确定要回到未来的哪个版本
	- `git reset --hard commit_id`   
- `git clone [url]`  检出新仓库
- `git remote add origin [url]`  本地仓库关联远程仓库
	- `git remote -v ` 查看远程库的信息
	- `git branch --set-upstream branch-name origin/branch-name` 创建本地分⽀支和远程分⽀支的链接关系 
- `git push -u origin master` 
	-  加上了-u参数,Git不但会把本地的
master分⽀支内容推送的远程新的master分⽀支
	- 还会把本地的master分⽀支和远程的master 分⽀支关联起来在以后的推送或者拉取时就可以简化命令
- `git pull`   同步远程代码


## <a name="branch"></a> branch
- **git checkout -b [branchname]** 新建一个分支，并切换到该分支 
	- git checkout命令加上-b参数表⽰示创建并切换:`git branch [branchname]` && `git checkout [branchname]`
	- `git branch [branch-name]` 新建一个分支，但依然停留在当前分支

- `git checkout [branch-name]` 切换到指定分支，并更新工作区

- `git branch --track [branch] [remote-branch]` 新建一个分支，与指定的远程分支建立追踪关系,假如远程变化,本地通知 

- `git checkout -b branch-name origin/branch- name` 在本地创建和远程分⽀支对应的分⽀支，使⽤本地和远程分⽀支的名称最好一致;

- `git branch -a` 列出所有本地分支和远程分支  **当前分⽀支前⾯面会标⼀一个*号**

- `git branch -r` 列出所有远程分支

- `git branch --merged`               显示所有已合并到当前分支的分支

- `git branch --no-merged`     		   显示所有未合并到当前分支的分支

- `git branch -d [branch-name]` 删除分支

- `git push origin --delete [branch-name]` 删除远程分支

## <a name="operation"></a> merge  fetch conflict  reset 

- `git merge [branch name]`  当前分支合并指定的`branch name` 

- `git merge --no-ff -m "merge with no-ff" dev`
	- 禁⽤用“Fast forward” ,创建⼀一个新的commit
	- `git log --graph --pretty=oneline --abbrev-commit` 查看分支历史

	```
	*   0e6b883 (HEAD -> master) merge with no-ff
	|\
	| * 562c386 (dev) dev frist change
	|/
	* 7aa1788 add string
	* 22c3340 add coding

	```	

- 冲突的解决? (移除如下标识部分,并确定保留的代码即可)

```
>>>>>>>>>>>>>>>>>>>
			HEAD
	653ghsjfkvdf4533fdsf			
>>>>>>>>>>>>>>>>>>>

```	
- `git cherry-pick [commit]` 

- `git fetch [remote]` 下载远程仓库的所有变动 
- **reset**
	-  `git reset --hard HEAD^1`    回退上次提交版本
	-  `git reset —hard commit_id`  回退指定commit_id版本
	-  `git push --force` 			 强制推送远程同步 

- **stash:**暂存操作--->在开发的过程中，突然来了个紧急的BUG或是任务，但是当前的任务或BUG还没有修复好，代码也不能提交，怎么办呢？
	- git stash list 查看当前暂存的列表
	- git stash apply stash@{0}  取出某个暂存的代码
	- git stash pop	 如果使用pop，取出最后一次存在的暂存，同时删除取出的暂存


## <a name="rebase"></a> rebase

 > **使用变基rebase可以让提交历史变得更简洁**. 
 
 > rebase原理就是, *从目标分支和要变基的分支向上查找出共同祖先节点`A`, 然后把要变基的分支到`A`节点的所有提交,提取出相应的修改生成一个副本*, 并追加到目标分创建相对应的提交. 此时变基的分支指向目标分支master的后面某一次提交. 此时只要使用修改master指向指针使用merge即可.

 - rebase <目标分支名> [需要移动变基底的分支]
 	-  `git rebase master experiment`	
 - 此时目标分支后面会追加另一个分支的提交. 此时只需要切换到master分支,合并分支即可
 	 -  `git checkout master` 
 	 -  `git merge experiment`
    		
##  <a name="tag"></a> tag 
	
> 标签是版本库的⼀一个快照:指向某个commit的指针,不能移动的指针
	
- `git tag [tag]`  ⽤于新建一个标签，默认为HEAD [标签不是按时间顺序列出，⽽是按字母排序的]
	- `git log --pretty=oneline --abbrev-commit`   查看`历史提交commit_id `
	- `git tag v0.9 commit_id` 
- `git tag -a v10.00 -m "version 0.00 released" 5874564` 带有说明的标签
 	- -a指定标签名
	- -m指定说明⽂文字
- `git show v10.00`  查看对应的 `tag` 信息

	```
	ragonLi-2:pythonRepo LFL$ git show v10.00
	tag V10.00
	Tagger: DragonLi <DragonLi_52171@163.com>
	Date:   Thu May 17 10:39:54 2018 +0800
	10.0正式版
	commit 0e6b8835b865773594befcf2e22ec4440256dc8c (HEAD -> master, tag: V10.00)

	```
- `git push [remote] --tags` ⼀一次性推送全部尚未推送到远程的本地标签`tag`  
	- `git push [remote] --[tagname]` 推送某个标签到远程
- `git checkout -b [branch] [tag]` 新建一个分支，指向某个tag 
- `标签已经推送到远程，要删除远程标签就⿇麻烦⼀一点，先从本地删除`
	- `git tag -d [tag]` 删除本地tag
	- `git push origin :refs/tags/V10.00` 从远程删除。删除命令也是push


## <a name="remoteoperation"></a> remote
 - 对远程仓库的名称进行修改
 	- `git remote rename oldName newName`
 - 移除一个远程仓库
 	- `git remote rm repoName` 
- 查看某一个仓库更多的信息时
	- `git remote show origin` 
 	

## <a name="gitconfig"></a> gitconfig
- `git config --list` 
	- Git的设置文件为.gitconfig
	- 它可以在用户主目录下（全局配置），也可以在项目目录下（项目配置）。

- 首次配置Git操作命令:

```
1.配置个人信息
git config [--global] user.name "[name]"
git config [--global] user.email "[email address]"
  	
2. Git会适当地显⽰不同的颜⾊
git config --global color.ui true                         

```

## <a name="alias"></a> alias 
- `git config --global alias.[new_name] "[old_name]"` 规则 
- `git config --global alias.ci commit` 给 commit 起一个别名叫 ci

## <a name="gitignore"></a> .gitignore

- 在Git工作区的根目录下创建⼀个特殊的.gitignore⽂文件，然后把要忽略的文件名填进去，Git就会自动忽略这些⽂文件
- [所有配置文件可以直接在线浏览](https://github.com/github/gitignore)
- 配置忽略文件规范
	- 所有空行或者以 ＃ 开头的行都会被 Git 忽略
	- * :匹配零个或多个任意字符
	- 可参考如下样板
	
```
# 忽略所有以 .c结尾的文件

*.c
	
# 但是 init.c 会被git追踪

!init.c
	
# 只忽略当前文件夹下的TODO文件, 不包括其他文件夹下的TODO例如: subdir/TODO

/TODO
	
# 忽略所有在build文件夹下的文件

build/
	
# 忽略 doc/note.txt, 但不包括多层下.txt例如: doc/server/arch.txt

doc/*.txt
	
# 忽略所有在doc目录下的.pdf文件
doc/**/*.pdf
		
```

- **忽略⽂件的原则**
	- 忽略操作系统自动⽣成的文件，比如 MAC系统下的 `.ds_store`
	- 忽略编译生成的中间⽂文件、可执⾏文件等，也就是如果一个文件是通过另一个⽂件自动⽣成的，那自动生成的⽂文件就没必要放进版本库，比如 Xcode 产生的一些对应工程的缓存文件. 忽略你自己的带有敏感信息的配置文件，⽐比如存放⼝令的配置⽂件


##  参考
- [廖雪峰 Git](https://www.liaoxuefeng.com/)

###  终端如果觉得太繁琐,可以使用可视化工具.`SourceTree`等


