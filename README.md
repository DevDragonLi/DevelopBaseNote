# Dev Base

> 备注：[从`iOSInterviewsAndDevNotes`Repo 抽出专注于通用开发整理](https://github.com/DevDragonLi/iOSDevNotesAndInterviews)

| CATEGORY | FILENAME |  
|:----|:----|
| Git |[分布式世界常用指令使用总结](./Doc/Git.md)<br>[GitFlow -工作流](./Doc/Gitflow.md)[命令图谱- @吴坚｜南航软件工程师](https://github.com/TeamStuQ/skill-map/blob/master/data/map-Git.md)<br>[git-from-the-inside-out](https://maryrosecook.com/blog/post/git-from-the-inside-out)<br>[Git指令速查-图](images/git-commend.jpg)<br>[Git Repo DestroyRemove Commited files 仓库瘦身](./Doc/git-remove-commited-files.md)|
| Markdown相关 |[Markdown入门常见语法](./Doc/Markdown.md)<br>[Markdown 文件自动生成目录](./Doc/Markdown.md)|
|通用 Shell |[文件夹内多个MD文件列表自动生成README可用的展示列表GenREADME](./shell/READMEList.sh)|

### iOS相关脚本

> mac开发环境安装一键安装 （网络环境检测，可以顺畅访问后执行后续操作）

- **`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/DevDragonLi/DevelopBaseNote/master/shell/devEnvInstallTool.sh)"`**
	- Homebrew
	- rvm 2.6.3 
	- gem update
	- oh-my-zsh
	- cocoapods

- [Xcode 缓存清理](./shell/deleteXCodeCache.sh)
- [组件化项目批量管理子组件脚本：同步/缺失下载](./shell/repoSync.sh)
- [Pod组件合法性校验脚本](./shell/checkpod.sh)
- [pod自动化更新脚本（已基本完善）](./shell/podUpdate.sh)
	- 展示当前版本
	- 手动输入新版本及校验Tag
	- 后续流程一键操作
