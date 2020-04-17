# Markdown

### Markdown 文件自动生成目录？

- [下载和安装 pandoc](https://github.com/jgm/pandoc/releases)
- `pandoc --version` ,确认已安装 
- 生成链接目录,部分`file`,可能会有错乱,还需要手动纠正一下.

	- `pandoc -s --toc README.md -o README.md` 
	- `-depth=[数字]` ,可以指定级🌲
	- `pandoc -s --toc --toc-depth=5 README.md -o README.md `


### 基本语法

>  https://github.com/younghz/Markdown

- 代码 : ``` 代码块 ```

```objc
 __block  NSInteger startNumber = 10;
        RACSignal *signal =[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            startNumber +=10;
            [subscriber sendNext:@(startNumber)];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
            }];
        }] replay];

```

- 收起 :<details>

<details>
<summary> 标题 </summary>

- 1.不同数目个#,代表不同的字体大小  
- ======  -------  一级和二级标题等,不常用
</details>




###  常用

-  不同数目个#,代表不同的字体大小


- ======  -------  一级和二级标题等,不常用

DragonLi
======
DragonLi
----------

- 有序列表和无序列表 (+ * - )

	- roundPoint
	
	- roundPoint
	
	1. 第一
	
	
	2. 第二


- **引用 >**  多级引用、标题、列表、代码块、分割线

> 引用Example

> test

- 强调两个*或-代表加粗，一个*或-代表斜体
 
	- **加粗文本**
	  
	-  *斜体文本* 


- 链接图片(com + shfit + I)和地址(com + shfit + K)

- [显示的地址文本](https://github.com/DevDragonLi)

- ![可有可无](图片地址)


-  表格

居左：:----
居中：:----:或-----
居右：----:


|LFL|DragonLi|Test|
|:---|:---:|---:|
|leftTest| centerTest |rightTest|


- 分隔---用三个以上的*、-、_来建立一个分隔线

***

---

___


- <u>下划线文本</u>

- <font face="微软雅黑" color="red" size="6">内容</font>


### 有任何问题及时反馈 email -> `dragonli_52171@163.com` 

