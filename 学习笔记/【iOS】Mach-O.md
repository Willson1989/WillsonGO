[TOC]



### [未完] Mach-O的基本结构？

### [未完] 常用的 Load commands ？

### [未完] 符号是如何完成重定位的？

### [未完] 各个Section都存放什么内容？

### [未完] Stub是什么？桩代码是什么？

### [未完] 加载Mach-O的流程，源码？

### [未完] 内存保护是什么意思，做什么的？如 segment_command_64 中的 maxprot

### [未完] mmap (一种内存映射文件的方法)

Linux 库函数 mmap( ) 原理

https://blog.csdn.net/bbzhaohui/article/details/81665370

------

### [未完] iOS 启动时间与Dyld3 （Launch Closure）

https://www.sohu.com/a/344299576_208051

https://blog.csdn.net/wo190096/article/details/102475884

------

### [未完] @rpath 的作用

------

### [未完] codeSign



------

### [未完] 动态库注入（DYLD_INSERT_LIBRARIES插入动态库）

https://www.jianshu.com/p/15eb803d2bf4

------

### [未完] 动态共享缓存库

```C++
// OS X 系统中共享缓存库的存放位置
#define MACOSX_DYLD_SHARED_CACHE_DIR	"/private/var/db/dyld/"
// iOS 系统中共享缓存库的存放位置
#define IPHONE_DYLD_SHARED_CACHE_DIR	"/System/Library/Caches/com.apple.dyld/"
```



------

### stat函数

https://blog.csdn.net/qq_40839779/article/details/82789217

Linux系统函数 - 文件系统管理

作用：获取文件信息

头文件：

```c
#include <sys/types.h> 
#include <sys/stat.h> 
#include <unistd.h>
```

函数原型：

```c
// 成功返回0，失败返回-1；
// path : 文件路径（名），
// struct stat 类型的结构体, 调用成功之后，里面保存的是path路径对应文件的信息
int stat(const char *path, struct stat *buf)
```

```c
struct stat
{
    dev_t     st_dev;     /* ID of device containing file */文件使用的设备号
    ino_t     st_ino;     /* inode number */    索引节点号 
    mode_t    st_mode;    /* protection */  文件对应的模式，文件，目录等
    nlink_t   st_nlink;   /* number of hard links */    文件的硬连接数  
    uid_t     st_uid;     /* user ID of owner */    所有者用户识别号
    gid_t     st_gid;     /* group ID of owner */   组识别号  
    dev_t     st_rdev;    /* device ID (if special file) */ 设备文件的设备号
    off_t     st_size;    /* total size, in bytes */ 以字节为单位的文件容量   
    blksize_t st_blksize; /* blocksize for file system I/O */ 包含该文件的磁盘块的大小   
    blkcnt_t  st_blocks;  /* number of 512B blocks allocated */ 该文件所占的磁盘块  
    time_t    st_atime;   /* time of last access */ 最后一次访问该文件的时间   
    time_t    st_mtime;   /* time of last modification */ /最后一次修改该文件的时间   
    time_t    st_ctime;   /* time of last status change */ 最后一次改变该文件状态的时间   
};
```

stat结构体中的st_mode 则定义了下列数种情况：

```c
    S_IFMT   0170000    文件类型的位遮罩
    S_IFSOCK 0140000    套接字
    S_IFLNK 0120000     符号连接
    S_IFREG 0100000     一般文件
    S_IFBLK 0060000     区块装置
    S_IFDIR 0040000     目录
    S_IFCHR 0020000     字符装置
    S_IFIFO 0010000     先进先出

    S_ISUID 04000     文件的(set user-id on execution)位
    S_ISGID 02000     文件的(set group-id on execution)位
    S_ISVTX 01000     文件的sticky位

    S_IRUSR(S_IREAD) 00400     文件所有者具可读取权限
    S_IWUSR(S_IWRITE)00200     文件所有者具可写入权限
    S_IXUSR(S_IEXEC) 00100     文件所有者具可执行权限

    S_IRGRP 00040             用户组具可读取权限
    S_IWGRP 00020             用户组具可写入权限
    S_IXGRP 00010             用户组具可执行权限

    S_IROTH 00004             其他用户具可读取权限
    S_IWOTH 00002             其他用户具可写入权限
    S_IXOTH 00001             其他用户具可执行权限
      
    上述的文件类型在POSIX中定义了检查这些类型的宏定义：
    S_ISLNK (st_mode)    判断是否为符号连接
    S_ISREG (st_mode)    是否为一般文件
    S_ISDIR (st_mode)    是否为目录
    S_ISCHR (st_mode)    是否为字符装置文件
    S_ISBLK (s3e)        是否为先进先出
    S_ISSOCK (st_mode)   是否为socket
    若一目录具有sticky位(S_ISVTX)，则表示在此目录下的文件只能被该文件所有者、此目录所有者或root来删除或改名，在linux中，最典型的就是这个/tmp目录啦。

```

st_mode 的结构:

st_mode 主要包含了 3 部分信息：

- 15-12 位保存文件类型
- 11-9 位保存执行文件时设置的信息
- 8-0 位保存文件访问权限

------

### bzero函数

* 原型

```c++
extern void bzero(void *s, int n);
```

* 参数说明

  s 要置零的数据的起始地址； n 要置零的数据字节个数。

  

* 头文件

```c++
#include <string.h>
```

* 作用

  置字节字符串前n个字节为零且包括‘\0’。

  

* 示例

```c++
#include <string.h>
int main(int argc, const char *argv[])
{
    struct {
        int a;
        char s[5];
        float f;
    } tt;
    char s[20];
    bzero(&tt, sizeof(tt)); // struct initialization to zero
    bzero(s, 20);
    printf("Initail Success");
    getchar();
    
    return 0;
}
```

------

### pread函数

https://blog.csdn.net/zhangge3663/article/details/83105200

pread 用来指定偏移量地读取文件内容

头文件：#include <fcntl.h>

1. fd：要读取数据的文件描述符
2. buf：数据缓存区指针，存放读取出来的数据
3. count：读取数据的字节数
4. offset：读取的起始地址的偏移量，读取地址=文件开始+offset。注意，执行后，文件偏移指针不变。如果文件内容为 HelloWorld，offset 为5，那么读取到buff中的内容为World

```c
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, const char *argv[])
{
    const char *filePath = "/Users/XXX/Desktop/file01";

    // 位于头文件 <fcntl.h>
    int fd = open(filePath, O_RDWR);

    char buff[200];

    int read_offset = 5;
  
    // 位于头文件 <unistd.h>
    size_t res = pread(fd, buff, sizeof(buff), read_offset);

    if (res == -1) {
        printf("reading file failed, path : %s", filePath);
    } else {
        printf("reading file succeed , content : \n %s", buff);
    }
    // 使用完文件记得关闭
    // 位于头文件 <unistd.h>
    close(fd);

    return 0;
}
```

------

### [未完] 虚拟地址空间

https://www.jianshu.com/p/b6356e0ec63c

------

### 32位操作系统如何计算内存空间？

1. 内存的一个存储单元是 一个字节（也就是8位），而不是一位。
2. 内存的每一个字节都必须有一个地址，这样才能根据这个地址找到对应的内存（类似于门牌号）
3. 所谓32位系统是指的寻址范围，一共可以表示2^32个地址，对应的就是2^32个存储单元，也即2^32个字节的内存。**再强调一次：一个地址对应的是一个字节的内存！**
4. 综上，32位系统最大能支持的内存为：2^32/2^10/2^10/2^10=2^2=4GB

32位表示32个开关，32个开关则有 `4294967296` 种可能（4294967296个地址）
内存换算：1G = 1024M = 1024 * 1024KB = 1024 * 1024 * 1024Byte = 1073741824 Byte
内存 = 4294967296 种可能 / 1073741824Byte = 4GB

参考：

https://www.jianshu.com/p/5a44f69466cc

------

### 静态链接和动态链接的不同？

https://www.jianshu.com/p/c4b803c38d9a

库用于模块拆分，多个模块组成一个程序。

根据模块链接的时机或者方式，可以分为静态库和动态库

**静态库：**

Windows下的 .lib  Unix下的 .a, Mac 下的 .a 、.framework

静态库在链接的阶段会被完整地拷贝到可执行文件中，最终会是可执行文件的体积增大。

如果有多个可执行文件，则会有多个该静态库的冗余拷贝。

如果要更新静态库的内容，则需要把所有包含这个静态库的可执行文件重新编译生成一次。

**动态库：**

与静态库相反，动态库在编译和链接阶段不会被拷贝到可执行文件中，可执行文件中只会存储指向动态库的引用（使用了动态库的符号，以及对应库的路径）。

等程序运行的时候，动态库才会被真正加载进来。

此时，现根据记录的动态库的路径找到对应的库，再根据使用的符号从库中找到符号的真正的地址。

动态库的优点：

1. 减少可执行文件的体积，动态库在链接时不会打进去，只有在系统加载可执行文件并运行该程序的时候才会加载使用的动态库，所以可执行文件的体积会少很多
2. 代码共享，很多程序都动态地链接了这个lib，那么这个lib在内存和磁盘中只存在一份。所以动态库也被称为共享库。
3. 易于维护，由于动态库不在可执行文件中，那么当要修改动态库的时候，不需要重新编译链接生成可执行文件。

------

