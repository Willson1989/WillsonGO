[TOC]



### 有符号整型和无符号整型的区别

`short signed int`

`short unsigned int`

都是占2个字节16位，那么下面的代码的输出结果却有不同：

```c++
#include <iostream>

using namespace std;

int main(int argc, const char *argv[])
{
    short signed int a = 50000;
    short unsigned int b = 50000;

    cout << "a : " << a << endl;
    cout << "b : " << b << endl;

    return 0;
}
```

输出结果：

```c++
a : -15536
b : 50000
```

首先 short signed int 的取值范围为 `-32767 ~ 32767`，50000显然是溢出了。

16 位整数（短整数）的情况下，十进制 **50000** 就是二进制 **11000011 01010000**

但在有符号的情况下，二进制最左边的 1，代表这个数字是负数

但是电脑是以补码形式来表示数字的，要获得原本的数字，首先要把整个二进制数 - 1

**1100001101010000 - 1 = ‭1100001101001111‬**

然后，在把答案取反码

**‭1100001101001111‬ = ‭0011110010110000‬**

把最终答案变成十进制，就是 15536

所以，一开始的二进制数 11000011 01010000，在有符号的情况下代表的就是 -15536

num1 --> 取反 --> 加1 --> -num1

-num1 --> 减1 --> 取反 --> num1







### extern 修饰符

> 当您有多个文件且定义了一个可以在其他文件中使用的全局变量或函数时，可以在其他文件中使用 extern 来得到已定义的变量或函数的引用。可以这么理解，extern 是用来在另一个文件中声明一个全局变量或函数。

main.cpp

```c++
\#include <iostream>

int count ;

extern void write_extern();

int main()
{
    count = 5;
    write_extern();
}
```



temp.cpp

```c++
\#include <iostream>

extern int count;

void write_extern(void)
{
    std::cout << "Count is " << count << std::endl;
}
```

在 temp.cpp 中定义了一个函数 write_extern，如果想在main.cpp中使用这个函数，那么需要使用extern来引用这个函数

**extern void write_extern()**。

同样，temp.cpp 中要想使用 main.cpp中定义的count变量，也需要使用 extern 来引用这个变量 **extern int count**。

如果在另一个别的cpp文件中也定义了write_extern（返回值和参数都相同），那么编译器会报错。

### switch 语句

不是每一个 case 都需要包含 break。如果 case 语句不包含 break。即使case不满足条件，控制流也会 **继续** 后续的 case，直到遇到 break 为止, 。

```c++
void check(short int n)
{
    switch (n) {
        case 1:
            cout << "the number is 1" << endl;
        case 2:
        case 3:
            cout << "the number is 2 or 3" << endl;
        case 5:
        case 6:
            cout << "the number is 5 or 6" << endl;
        default:
            break;
    }
}
```

输出:

```shell
the num is 1
the num is 2 or 3
the num is 5 or 6
```



### 函数的参数默认值

```c++
int my_sum(int a , int b = 10) {
    return a + b;
}

int main(int argc, const char *argv[])

{

    int res1 = my_sum(20); // 参数 b 使用默认值 10
    int res2 = my_sum(30, 15);
    cout << "res1 : " << res1 << endl << "res2 : " << res2 << endl;
    return 0;
}
```

输出：

```c++
res1 : 30
res2 : 45
```



### 输出类型名称

```c++
void print_types_name()
{
    cout << "name of types : " << endl;

    int n = 100;
    cout << "int : " << typeid(n).name() << endl;
    int *np = new int(33);
    cout << "int pointer : " << typeid(np).name() << endl;

    signed int si = 100;
    cout << "signed int : " << typeid(si).name() << endl;
    signed int *sip = new signed int(33);
    cout << "signed int pointer : " << typeid(sip).name() << endl;

    unsigned int usi = 100;
    cout << "unsigned int : " << typeid(usi).name() << endl;
    unsigned int *usip = new unsigned int(33);
    cout << "unsigned int pointer : " << typeid(usip).name() << endl;

    short s = 100;
    cout << "short : " << typeid(s).name() << endl;
    short *sp = new short(33);
    cout << "short pointer : " << typeid(sp).name() << endl;

    long l = 100;
    cout << "long : " << typeid(l).name() << endl;
    long *lp = new long(33);
    cout << "long pointer : " << typeid(lp).name() << endl;

    float f = 100.22;
    cout << "float : " << typeid(f).name() << endl;
    float *fp = new float(33.33);
    cout << "float pointer : " << typeid(fp).name() << endl;

    double d = 100.22;
    cout << "double : " << typeid(d).name() << endl;
    double *dp = new double(33.33);
    cout << "double pointer : " << typeid(dp).name() << endl;

    char c = 'w';
    cout << "char : " << typeid(c).name() << endl;
    char *cp = new char('w');
    cout << "char pointer : " << typeid(cp).name() << endl;
}
```

输出:

```c++
name of types :
int : i
int pointer : Pi
signed int : i
signed int pointer : Pi
unsigned int : j
unsigned int pointer : Pj
short : s
short pointer : Ps
long : l
long pointer : Pl
float : f
float pointer : Pf
double : d
double pointer : Pd
char : c
char pointer : Pc
```

gcc编译器输出的类型标识为一个字母，如果是`clang`的话，整型会输出 `int`，整型指针会输出 `int *`

### char * 和 std::string的转换

[https://blog.csdn.net/qq_41959101/article/details/107722121](https://blog.csdn.net/qq_41959101/article/details/107722121)

```c++
void char_pointer_string_transform()
{
    char carr[7] = { 'w', 'i', 'l', 'l' };
    // char *cp = carr;
    // 通过 string 的初始化函数，将 char* 转换成 string
    string str = string(carr);
    cout << "str : " << str << endl;

    // 使用 std::string 的 data() 和 c_str() 来得到 char * 指针变量
    // 但是 data() 和 c_str() 返回类型都是 const char * ，所以要用const char *来接收
    string str1 = "helen";
    const char *cp1 = str1.data();
    const char *cp2 = str1.c_str();

    cout << "str1 : " << str1 << endl;
    cout << "char pointer 1 : " << cp1 << endl;
    cout << "chat pointer 2 : " << cp2 << endl;

    // 如果要转换为非const 的 char *
    // 1
    char cp3[5];
    strcpy(cp3, str1.c_str());

    // 2
    char *cp4;
    cp4 = (char *)malloc(str1.length() * sizeof(char));
    strcpy(cp4, str1.c_str());

    cout << "chat pointer 3 : " << cp3 << endl;
    cout << "chat pointer 4 : " << cp4 << endl;
}
```



###  指针和引用

[https://blog.csdn.net/smartgps2008/article/details/90648015](https://blog.csdn.net/smartgps2008/article/details/90648015)

[https://blog.csdn.net/jimmychao1982/article/details/38228421](https://blog.csdn.net/jimmychao1982/article/details/38228421)

> 引用是别名，指针是地址。

**引用**相当于变量的别名，所以声明的时候就必须有初值。一旦声明，这个引用就会一直跟着这个变量，即使用另一个变量对它进行赋值，也只是改变了值，引用还是那个引用。

**指针**则不同，它虽然指向了一个变量，但是可以通过赋值再让它指向另一个变量。

所以引用是”**专一的**“，指针是”**善变的**“

```c++
int i = 10;
int j = 99;

int& r = i;
cout << "i : " << i << endl;
// 语句r = j并不能将 r 修改成为j的引用，只是把 r 的值改变成为 99 。由于 r 是 i 的引用，所以 i 的值也变成了99。

r = j;
cout << "after set r to j , r : " << r << ", i : " << i << ", j : " << j << endl;

i = 77;
cout << "after set i to 77 , r : " << r << ", i : " << i << ", j : " << j << endl;

j = 11;
cout << "after set j to 11 , r : " << r << ", i : " << i << ", j : " << j << endl;
//int & m = 19; // 编译错误，引用必须与合法的存储单元关联，并且不可以为null
//int & n; // 引用在声明的时候必须有初值

/*

输出：
i : 10
after set r to j , r : 99, i : 99, j : 99
after set i to 77 , r : 77, i : 77, j : 99
after set j to 11 , r : 77, i : 77, j : 11
*/
```

**引用**可以当做参数传进函数中去，如果函数内对引用进行操作，外部原来的引用和对应的变量也会发生改变。

```c++
using namespace std;

void refrence_temp_func(int & n);
int & refrence_temp_func_1(int & n);

void pointer_and_refrence_study()
{
    int b = 10;
    int & br = b;
  
    refrence_temp_func(br);
    cout << "b : " << b << ", br : " << br << endl;
  
    int bb = 8;
    int & bbr = bb;
    // 现在 new_bbr 和 bbr 都是 bb的引用了，改变他们任何一个值，所有的值都会发生改变
    int & new_bbr = refrence_temp_func_1(bbr);
    cout << "before , bb : " << bb << ", bbr : " << bbr << ", new_bbr : " << new_bbr << endl;
    new_bbr += 6;
    cout << "after , bb : " << bb << ", bbr : " << bbr << ", new_bbr : " << new_bbr << endl;
}

void refrence_temp_func(int & n)
{
    n = n + 1;
}

int & refrence_temp_func_1(int & n)
{
    n += 1;
    int & m = n;
    return m;
}

/*
输出：
b : 11, br : 11
before , bb : 9, bbr : 9, new_bbr : 9
after , bb : 15, bbr : 15, new_bbr : 15
*/
```

常量引用

```c++
int a = 8;
const int& ra = a;
// ra = 9; // 编译错误，ra是常量引用，所以不能给修改ra的值，但是可以通过改变a的值来改变ra的值
a = 9;
cout << "after set a , ra : " << ra << endl;

/*
输出：
after set a , ra : 9
*/
```

常量指针 `const int *` 代表该指针变量指向一个常量，这个常量的值不可以改变，但是可以改变这个指针变量，指向别的变量

```c++
int ci = 10;
const int * cip = &ci;
// *cip = 99; // 错误，虽然 ci 不是const，但是 cip 是指向 const int 的指针，所以 *cip = 99 是错误的。
cout << "before, ci : " << ci << ", cip value : " << *cip << endl;
ci = 99;
cout << "after, ci : " << ci << ", cip value : " << *cip << endl;

/*
输出：
before, ci : 10, cip value : 10
after, ci : 99, cip value : 99
*/
```

指针常量，`int * const` 代表这个指针变量是一个常量，指这个指针自己的值（即变量的地址）是不可以改变的。

```c++
int *const pci = &ci;
*pci = 88;
int ci1 = 90;

// pci = &ci1; // 错误，pci是指针常量，声明并赋给初值之后就不能改变指向了。
```



###  随机数

[https://www.cnblogs.com/xiaokang01/p/9786751.html](https://www.cnblogs.com/xiaokang01/p/9786751.html)

`rand()`方法可以生成随机数

```c++
#include <iostream>
#include <cstdlib>

using namespace std;

int main()
{
    for (int i = 0; i < 10; i++) {
    	cout << rand()%100<< " ";
    }
    return 0;
}
```

83 86 77 15 93 35 86 92 49 21 在100中产生随机数， 但是因为没有随机种子所以，下一次运行也是这个数，因此就要引出`srand`。

`srand()` 可用来设置 `rand()` 产生随机数时的随机数种子。通过设置不同的种子，我们可以获取不同的随机数序列。

可以利用`srand((int)(time(NULL))`的方法，利用系统时钟，产生不同的随机数种子。

不过要调用`time()`，需要加入头文件`< ctime >`。

```c++
#include <iostream>
#include <cstdlib>
#include <ctime>

//为了方便的使用我们可以用宏定义来替换 rand函数
#define random(x) rand()%(x)

using namespace std;

int main()
{
    // 产生随机种子 把0换成NULL也行
    srand((int)time(0));
    for (int i = 0; i < 10; i++) {
    	cout << random(100) << " ";
    }
    return 0;
}
```

其他的随机数的范围通式

产生一定范围随机数的通用表示公式是：

要取得 **[0,n)**  就是 **`rand() % n`** 表示 从 0 到 n - 1 的数

要取得 **[a,b)** 的随机整数，使用**`(rand() % (b-a))+ a;`**

要取得 **[a,b]** 的随机整数，使用**`(rand() % (b-a+1))+ a;`**

要取得 **(a,b]** 的随机整数，使用**`(rand() % (b-a))+ a + 1;`**

通用公式: **a + rand() % n** ；其中的a是起始值，n是整数的范围。

要取得 a 到 b 之间的随机整数，另一种表示：**`a + (int)b * rand() / (RAND_MAX + 1)`**。

要取得 0～1 之间的浮点数，可以使用 **`rand() / double(RAND_MAX)`**。

```c++
#include <iostream>
#include <cstdlib>
#include <ctime>

#define random(a,b) (rand()%(b-a)+a)

using namespace std;

int main()
{
    srand((int)time(0)); // 产生随机种子 把0换成NULL也行
    for (int i = 0; i < 10; i++) {
        cout << random(5, 10) << " ";
    }
    return 0;
}
// 5 5 9 7 9 6 5 5 7 7 产生5到10之间的数， 不包括5 和 10
```



###  从函数返回数组

[https://www.runoob.com/w3cnote/cpp-return-array.html](https://www.runoob.com/w3cnote/cpp-return-array.html)

C++ 中的函数是不允许返回一个数组的，但是可以返回一个指针

```c++
// 错误
// int [] return_arr() {
//
// }

// 返回一个指针
int* return_arr() {
}
```

但是这其中有一个比较容易犯的错误，看下面的例子

```c++
using namespace std;

void print_arr(int *arr, int len)
{
    for (int i = 0; i < len; i++) {
        if (i == len - 1) {
        	cout << *(arr + i) << endl;
        } else {
        	cout << *(arr + i) << ", ";
        }
    }
}

int * get_arr(int len)
{
    int ret[len];
    for (int i = 0; i < len; i++) {
        ret[i] = i;
    }
    return ret;
}

int main(int argc, const char *argv[])
{
    int *arr = get_arr(4);
    print_arr(arr, 4);
}
```

上面的例子输出 0, 32766, 3820, 1

但是应该输出 0, 1, 2, 3

因为在 `get_arr` 方法中，中声明的数组 `ret`， 在 `get_arr` 执行完之后就被释放了，所以输出的不是准确的值。

解决方法是使用**动态分配内存**的方式在函数中 `new` 一个数组。这样这个数组的内存空间就是自己管理的了，所以要记住在不使用的时候自己通过`delete` 释放掉。

**内存的原则是谁分配谁释放，所以在应该在函数外创建这个数组，然后再在函数外释放掉它**。

```c++
using namespace std;
void print_arr(int *arr, int len)
{
    for (int i = 0; i < len; i++) {
        if (i == len - 1) {
            cout << *(arr + i) << endl;
        } else {
            cout << *(arr + i) << ", ";
        }
    }
}

// 数组指针作为参数传进来，然后对数组进行操作。
void get_arr(int len, int * arr) {
    for (int i = 0; i < len; i++) {
        arr[i] = i;
    }
}

int main(int argc, const char *argv[])
{
    int *arr = new int[4]; // 为数组分配内存空间
    get_arr(4, arr);
    print_arr(arr, 4);
    delete [] arr; // 不用的时候释放掉
}
```



###  字符串

[https://blog.csdn.net/qq_42659468/article/details/90381985](https://blog.csdn.net/qq_42659468/article/details/90381985)

**C 风格字符串**

```c++
// strcat

char s1[20] = { 'w', 'i', 'l', 'l' }
char s2[20] = { 'h', 'e', 'l', 'e' };

// 声明一个字符串时，这个字符串是一个常量，
// 所以 char * 前面要加上 const
const char * s3 = "willson";
// 将 s1 和 s2 拼接并赋给 s1，所以s1应该有足够大。
strcat(s1, s2);
cout << "after strcat 1 : " << s1 << endl;
// 输出：after strcat 1 : willhele

// 或者不指定容量
char s11[] = "willson";
char s22[] = "helenZhu";
strcat(s11, s22);
cout << "after strcat 2 : " << s11 << endl;
// 输出：after strcat 2 : willsonhelenZhu

// strcpy
char s_cpy_1[] = "hi";
char s_cpy_2[] = "good morning";
cout << "strcpy before : " << s_cpy_1 << endl;
strcpy(s_cpy_1, s_cpy_2);
cout << "strcpy after : " << s_cpy_1 << endl;
// 输出：
// strcpy before : hi
// strcpy after : good morning

// strlen
char s_len[] = "thank you";
size_t s_len_len = strlen(s_len);
cout << "length of s_len : " << s_len_len << endl;
// 输出： length of s_len : 9

// strchr
char s_strchr[] = "nice_to_see_you";
char *first = strchr(s_strchr, 'c');
cout << "content after first c : " << first << endl;
*first = '\0'; // 将 first 位置的字符赋值为结束符 \0
cout << "content before first c : " << s_strchr << endl;
// 输出：
// content after first c : ce_to_see_you
// content before first c : ni

// strstr
char s_strstr[] = "nice_to_see_you_too~~";
char *first_str = strstr(s_strstr, "to");
cout << "content after first string 'to' : " << first_str << endl;
*first_str = '\0'; // 将 first 位置的字符赋值为结束符 \0
cout << "content before first string 'to' : " << s_strstr << endl
// 输出：
// content after first string 'to' : to_see_you_too~~
// content before first string 'to' : nice_
```



**C++ 风格字符串**

```c++
string s_cpp_1 = "Hello_";
string s_cpp_2 = "world";
string s_cpp_3;
s_cpp_3 = s_cpp_1;
cout << "copy , s_cpp_3 : " << s_cpp_3 << endl;
// 输出： copy , s_cpp_3 : Hello_

s_cpp_3 = s_cpp_1 + s_cpp_2;
cout << "concat, s_cpp_3 : " << s_cpp_3 << endl;
// 输出： concat, s_cpp_3 : Hello_world

int len_cpp = (int)s_cpp_3.length();
int len_cpp_1 = (int)s_cpp_3.size();
cout << "length of s_cpp_3 : " << len_cpp << endl;
cout << "length_1 of s_cpp_3 : " << len_cpp_1 << endl;
// 输出：
// length of s_cpp_3 : 11
// length_1 of s_cpp_3 : 11

// 子字符串，从索引位置4开始
string s_cpp_4 = string(s_cpp_3, 4);
cout << "substring of s_cpp_3 from index 4 : " << s_cpp_4 << endl;
// 输出： substring of s_cpp_3 from index 4 : o_world

// 子字符串，从索引位置1开始，长度为4
string s_cpp_5 = string(s_cpp_3, 1, 4);
cout << "substring (1, 4) of s_cpp_3 : " << s_cpp_5 << endl;
// 输出： substring (1, 4) of s_cpp_3 : ello

// 初始化字符串，6个A
string s_cpp_6 = string(6, 'A');
cout << "number of 'A' is 6 : " << s_cpp_6 << endl;
// 输出： number of 'A' is 6 : AAAAAA

// 清空字符串，并设置为 "ABC"
string s_cpp_7 = "I_am_very_good";
s_cpp_7.assign("ABC");
cout << "assign(\"ABC\") : " << s_cpp_7 << endl;
// 输出： assign("ABC") : ABC

// 清空字符串，并设置为"AB"，保留两个字符
string s_cpp_8 = "I_am_very_good";
s_cpp_8.assign("ABC", 2);
cout << "assign(\"ABC\",2) : " << s_cpp_8 << endl;
// 输出： assign("ABC",2) : AB

// 清空字符串，设置为 "ABC" 中的从 位置1 开始，保留 1个 字符
string s_cpp_9 = "I_am_very_good";
s_cpp_9.assign("ABCDEF", 1, 3);
cout << "assign(\"ABCDEF\", 1, 3) : " << s_cpp_9 << endl;
// 输出： assign("ABCDEF", 1, 3) : BCD

// 清空字符串，然后字符串设置为 5个 'A'
string s_cpp_10 = "I_am_very_good";
s_cpp_10.assign(5, 'A');
cout << "assign(5, 'A') : " << s_cpp_10 << endl;
// 输出： assign(5, 'A') : AAAAA
string s_cpp_11 = "will_done";
cout << "s_cpp_11 before resize(4) : " << s_cpp_11 << ", len : " << s_cpp_11.length() << endl;

// 设置当前 str 的大小为10，若大小大与当前串的长度，\0 来填充
s_cpp_11.resize(4);
cout << "s_cpp_11 after resize(4) : " << s_cpp_11 << ", len : " << s_cpp_11.length() << endl;
// 输出：
// s_cpp_11 before resize(4) : will_done, len : 9
// s_cpp_11 after resize(4) : will, len : 4

string s_cpp_12 = "good";
cout << "s_cpp_12 length before resize(10, 'X') : " << s_cpp_12.length() << endl;
// 设置当前 str 的大小为10，若大小大与当前串的长度，字0符c 来填充
s_cpp_12.resize(10, 'X');
cout << "s_cpp_12 after resize(10, 'X') : " << s_cpp_12 << ", len : " << s_cpp_12.length() << endl;
// 输出：
// s_cpp_12 length before resize(10, 'X') : 4
// s_cpp_12 after resize(10, 'X') : goodXXXXXX, len : 10

string s_cpp_swap_1 = "will";
string s_cpp_swap_2 = "helen";
cout << "swap, s1 before: " << s_cpp_swap_1 << ", s2 : " << s_cpp_swap_2 << endl;
// 交换 str1 和 str 的字符串
s_cpp_swap_1.swap(s_cpp_swap_2);
cout << "swap, s1 after : " << s_cpp_swap_1 << ", s2 : " << s_cpp_swap_2 << endl;
// 输出：
// swap, s1 before: will, s2 : helen
// swap, s1 after : helen, s2 : will

// 反转字符串
string s_cpp_13 = "net";
reverse(s_cpp_13.begin(), s_cpp_13.end());
cout << "reverse, s_cpp_12 : " << s_cpp_13 << endl;
// 输出：reverse, s_cpp_12 : ten

//删除
string s_cpp_14 = "willson";
s_cpp_14.erase();
cout << "erase, s_cpp_14 : " << s_cpp_14 << endl;
// 输出： erase, s_cpp_14 :

string s_cpp_15 = "willson";
// 删除从索引位置1开始到末尾的字符
s_cpp_15.erase(3);
cout << "erase(3), s_cpp_15 : " << s_cpp_15 << endl;
// 输出： erase(3), s_cpp_15 : wil

string s_cpp_16 = "willson";
// 删除从索引位置1开始的2个字符
s_cpp_16.erase(3, 2);
cout << "erase(3, 2), s_cpp_16 : " << s_cpp_16 << endl;
// 输出： erase(3, 2), s_cpp_16 : wilon

// 替换
string s_cpp_17 = "willson";
// 从索引位置2开始的2个字符替换成 XXXX
s_cpp_17.replace(2, 2, "XXXX");
cout << "replace(2, 2, \"XXXX\"), s_cpp_17 : " << s_cpp_17 << endl;
// 输出： replace(2, 2, "XXXX"), s_cpp_17 : wiXXXXson

string s_cpp_18 = "willson";
cout << "s_cpp_18 is empty : " << (s_cpp_18.empty() == 1 ? "true" : "false") << endl;
s_cpp_18.clear();
cout << "s_cpp_18 is empty : " << (s_cpp_18.empty() == 1 ? "true" : "false") << endl;
// 输出：
// s_cpp_18 is empty : false
// s_cpp_18 is empty : true

// 查找
string s_cpp_19 = "willson";
// 查找字符 s，在字符串中出现的第一个的索引
int find_19 = (int)s_cpp_19.find('l');
cout << "willson, find('l') : " << find_19 << endl;
// 输出： willson, find('l') : 2

string s_cpp_20 = "willson";
// 查找子字符串 son 第一个出现的索引位置
int find_20 = (int)s_cpp_20.find("son");
cout << "willson, find(\"son\") : " << find_20 << endl;
// 输出： willson, find("son") : 4

string s_cpp_21 = "abcabcabc";
// 从索引4的位置开始查找字符 a 第一次出现的位置
int find_21 = (int)s_cpp_21.find('a', 4);
cout << "abcabcabc, find('a', 4) : " << find_21 << endl;
// 输出： abcabcabc, find('a', 4) : 6

string s_cpp_22 = "abcabcdabc";
// 从索引2的位置开始查找字符传 abcd 的前3个字符第一次出现的位置
int find_22 = (int)s_cpp_22.find("abcd", 2, 3);
cout << "abcabcddabc, find(\"abc\", 4) : " << find_22 << endl;
// 输出： abcabcddabc, find("abc", 4) : 3

// 子串
string s_cpp_23 = "willson";
// 子串，从索引2开始到结尾的子字符串
string s_cpp_23_sub = s_cpp_23.substr(2);
cout << "willson, substring from index 2 : " << s_cpp_23_sub << endl;
// 输出： willson, substring from index 2 : llson

string s_cpp_24 = "willson";
// 子串，从索引2开始3个字符的子字符串
string s_cpp_24_sub = s_cpp_23.substr(2, 3);
cout << "willson, substring from index 2, last 3 : " << s_cpp_24_sub << endl;
// 输出： willson, substring from index 2, last 3 : lls
```



###  日期和时间

[https://www.runoob.com/cplusplus/cpp-date-time.html](https://www.runoob.com/cplusplus/cpp-date-time.html)

```c++
#include <ctime>

#include <iostream>

using namespace std;

int main(int argc, const char *argv[])
{
    // 获取当前时间
    time_t now = time(0);

    // 该返回一个表示当地时间的字符串指针，字符串形式 day month year hours:minutes:seconds year\n\0。
    char *now_str = ctime(&now);
    cout << "time string - now : " << now_str << endl;
    // 输出：time string - now : Wed Oct  7 18:07:49 2020

    tm *tm_now = localtime(&now);
    print_tm(tm_now);

    tm *tm_custom = new tm();
    // 1989-01-27
    tm_custom->tm_year = 1989 - 1900;
    tm_custom->tm_mon = 0;
    tm_custom->tm_mday = 27;
    // 根据 tm 生成 time_t
    time_t my_birthday_time_t = mktime(tm_custom);
    const char *my_birthday_time_str = ctime(&my_birthday_time_t);
    cout << "my birthday : " << my_birthday_time_str << endl;
    // 输出：my birthday : Fri Jan 27 00:00:00 1989

    tm *tm_custom_1 = new tm();
    tm_custom_1->tm_year = 1989 - 1900;
    tm_custom_1->tm_mon = 0;
    tm_custom_1->tm_mday = 27;
    tm_custom_1->tm_hour = 10;
    time_t time_t_val_1 = mktime(tm_custom_1);

    tm *tm_custom_2 = new tm();
    tm_custom_2->tm_year = 1989 - 1900;
    tm_custom_2->tm_mon = 0;
    tm_custom_2->tm_mday = 27;
    tm_custom_2->tm_hour = 11;
    time_t time_t_val_2 = mktime(tm_custom_2);

    // difftime(t1, t2) ：返回t1 和 t2 之间的秒数。difftime(t1, t2) = t1 - t2
    int sec_diff = difftime(time_t_val_1, time_t_val_2);
    cout << "time_1 : " << ctime(&time_t_val_1);
    cout << "time_2 : " << ctime(&time_t_val_2);
    cout << "seconds between time_1 and time_2 : " << sec_diff << endl;
    /*
     输出:
     time_1 : Fri Jan 27 10:00:00 1989
     time_2 : Fri Jan 27 11:00:00 1989
     seconds between time_1 and time_2 : -3600
     */
}

// 格式化输出
void print_tm(tm *t)
{
    cout << "时间: ";
    cout << (1900 + t->tm_year) << " 年 ";
    cout << (1 + t->tm_mon) <<  " 月 ";
    cout << t->tm_mday <<  " 日 - ";
    cout << t->tm_hour << ":" << t->tm_min << ":" << t->tm_sec << endl;
    cout << "年内天数: " << t->tm_yday << endl;
    cout << "周内天数: " << t->tm_wday << endl;
    cout << endl;
}

void clock_study()
{
    clock_t begin, end;
    begin = clock();
    cout << "seconds science app start : " << ((double)begin / CLOCKS_PER_SEC) << endl;
    for (int i = 0; i < 900000000; i++) { }
    end = clock();
    double diff = ((double)(end - begin)) / CLOCKS_PER_SEC;
    cout << "seconds of for loop statement : " << diff << endl;
}
```



### 在 hpp 中使用std::string 报错

我使用xCode编辑C++的代码，在hpp文件中定义了一个使用了 std::string 的函数，但是报错 `Unknown type name 'string'`，如下：

MyUtils.hpp

```c++
#ifndef MyUtils_h
#define MyUtils_h

#include <stdio.h>

using namespace std;

int toInt(string s);
int toFloat(string s);
int toDouble(string s);

string toString(int in);

#endif /* MyUtils_h */
```

但是在 MyUtils.cpp 中使用string却没有问题。

在hpp中引入 <string> 库之后，编译通过了。

```c++
#ifndef MyUtils_h
#define MyUtils_h

#include <stdio.h>
#include <string> // std::string 类型定义在 string 标准库中了

using namespace std;

int toInt(string s);
int toFloat(string s);
int toDouble(string s);

string toString(int in);

#endif /* MyUtils_h */
```



###  define 和 const 区别

[参考1](https://blog.csdn.net/lee371042/article/details/79830974)， [参考2](https://blog.csdn.net/heart_love/article/details/50720847?utm_medium=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.channel_param&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.channel_param)

1. 编译器对二者的处理方式不同：

**#define** 预处理阶段，只做展开处理不做运算处理。

**const** 编译阶段和运行阶段使用。

2. 类型和安全检查

**#define** 没有任何类型，在预处理阶段不做任何类型检查。

**const** 有类型，在编译阶段进行类型安全检查。

3. 存储方式不同：

**#define** 宏定义不分配内存，给出的是立即数，有多少次使用就进行多少次替换，在内存中会有多个拷贝，消耗内存大。

**const** 常量需要分配内存，不需要多次拷贝，可以节省内存。



### 字符串和数字的转换

[http://c.biancheng.net/view/1527.html](http://c.biancheng.net/view/1527.html)

[https://www.cnblogs.com/iceix/p/12713895.html](https://www.cnblogs.com/iceix/p/12713895.html)

* 字符串输入输出流 istringstream 和 ostringstream

**头文件**：

```c++
#include <sstream>
#include <iostream>
```

**字符 -> 数字**

按照输入字符串中内容的顺序依次输入给对应的变量

```c++
string s1 = "willson 80 90";
istringstream istr1 = istringstream(s1);
string name1;
int n1, n2;
// 按照输入字符串中内容的顺序依次输入给对应的变量
istr1 >> name1 >> n1 >> n2;
cout << name1 << " , " << n1 << " , " << n2 << endl;
// 输出：willson , 80 , 90
```

重新输入并不会改变变量的值。

例如下面的代码，`fn1` 和 `fn2` 在上面的输入之后值应该分别为 231.234 和 87,

但是在下面的语句执行完之后 `fn1` 的值应该是 87, `fn2` 的值应该是 231.234 ，

通过`cout`输出之后发现 `fn1` 和 `fn2` 的值并没有改变。

```c++
string s2 = "231.234 hello 87";
istringstream istr2(s2);
string name2;
float fn1, fn2;
istr2 >> fn1 >> name2 >> fn2;
cout << fn1 << " , " << name2 <<  " , " << fn2 << endl;
// 输出：231.234 , hello , 87

istr2 >> fn2 >> name2 >> fn1;
cout << fn2 << " , " << name2 <<  " , " << fn1 << endl;
// 输出：87 , hello , 231.234
```



使用 `istringstream` 输入内容给多个变量的时候，要注意内容和变量的类型匹配。

下面的代码中，将 13.45 输入到整型变量 `in1` 之后，`in1` 只会接收小数点之前的内容即 13，

而小数点之后的内容会输入给 `name3`, 而之后的字符串 will，则会交给 `fn1_1`，

但是因为类型不匹配，所以 `fn1_1` 的值是 0。

```c++
const char *s3 = "13.45 will 99";
istringstream istr3(s3);

int in1;
string name3;
float fn1_1;

istr3 >> in1 >> name3 >> fn1_1;
cout << in1 << " , " << name3 << " , " << fn1_1 << endl;
// 输出：13 , .45 , 0
```

**数字 -> 字符**

如果输入字符串包含多个值，需要用一个或多个空格分隔，其他字符都无效。

```c++
istringstream input("90  100     110");
ostringstream output;
//istringstream input("90,100,110");
//上面的 90,100,110 会导致 a 为 90，b 和 c 都为 0。
int a, b, c;
input >> a >> b >> c;
output << (a + b + c);
string sum_str = output.str();
cout << "input nums , a : " << a << " , b : " << b << ", c " << c << endl;
cout << "sum : " << sum_str << endl;
```



* **字符串流 stringstream**

`stringstream` 相当于 `istringstream` 和 `ostringstream` 的整合

```c++
stringstream stream;
float num_float = 32.12;
string num_float_str;
// 使用 流插入操作符 << 将数据输入给 stringstream。
stream << num_float;
// 然后使用 流提取操作符 >> 将 stringstream 中的数据输出到 num_float_str 字符串变量中。
stream >> num_float_str;
cout << "num_float_str : " << num_float_str << endl;
// 输出：num_float_str : 32.12

stringstream stream2 = stringstream("99.45");
float num_float_1;
stream2 >> num_float_1;
cout << "num_float_1 : " << num_float_1 << endl;
// 输出：num_float_1 : 99.45
```



* **便利方法 to_string 和 stoi、stof 等**

数字转字符串

```c++
int var_int = 199;
long var_long = 234000000;
float var_float = 89.9;
float var_double = 12.34567;

string var_int_str = to_string(var_int);
string var_float_str = to_string(var_float);
string var_long_str = to_string(var_long);
string var_double_str = to_string(var_double);

cout << "var_int_str : " << var_int_str << endl;
cout << "var_float_str : " << var_float_str << endl;
cout << "var_long_str : " << var_long_str << endl;
cout << "var_double_str : " << var_double_str << endl;
/*
 输出：
 var_int_str : 199
 var_float_str : 89.900002
 var_long_str : 234000000
 var_double_str : 12.345670
 */
```



**字符串转数字**

```c++
string var_str_int = "989";
string var_str_long = "1239000000";
string var_str_float = "989.12";
string var_str_double = "345.98908812";

int val_int = stoi(var_str_int);
long val_long = stol(var_str_long);
float val_float = stof(var_str_float);
double val_double = stod(var_str_double);

cout << "val_int    : " << val_int << endl;
cout << "val_long   : " << val_long << endl;
cout << "val_float  : " << val_float << endl;
cout << "val_double : " << val_double << endl;
/*
 输出：
 val_int    : 989
 val_long   : 1239000000
 val_float  : 989.12
 val_double : 345.989
 */
```



方法参数说明，想stoi方法，参数不只有一个，下面是函数的定义：

```c++
int stoi(const strings str, size_t* pos = 0, int base = 10)
long stol(const strings str, size_t* pos = 0, int base = 10)
float stof(const strings str, size_t* pos = 0)
double stod(const strings str, size_t* pos = 0)
```

`pos` : 保存了 `str` 中无法被转换的第一个字符的索引位置，例如 123abc，那么pos=3

`base` : 用于转换的进制，默认值是10，即十进制，2是二进制。

示例：

```c++
string val_str_int_1 = "123abd";
string val_str_int_2 = "0001110abd"; // 2进制不需要加0b前缀

size_t pos_1;
size_t pos_2;

int val_int_1 = stoi(val_str_int_1, &pos_1, 10);
int val_int_2 = stoi(val_str_int_2, &pos_2, 2);

cout << "val_int_1 : " << val_int_1 << ", pos : " << pos_1 << endl;
cout << "val_int_2 : " << val_int_2 << ", pos : " << pos_2 << endl;

/*
 val_int_1 : 123, pos : 3
 val_int_2 : 14, pos : 7
 */
```

### 类的访问修饰符（public，protected， private）

类成员可以被定义为 `public`、`private` 或 `protected`。默认情况下是定义为 `private`。

```c++
class Base {
    public: // 公有成员
        // 在类的外部可以被访问
        // 子类可以访问
        int val_public;
 
    protected: // 受保护成员
        // 在类的外部不可被访问
        // 子类可以访问
        int val_protected; 
 
  
    private: // 私有成员
        // 在类的外部不可被访问
        // 子类不可访问
        int val_protected;
};
```

`public`，`protected`， `private` 在类的继承上的应用

首先有基类 Base：

```c++
class Base {
public:
    int a;
    Base() {
        a = 0;
        a1 = 1;
        a2 = 2;
        a3 = 3;
    }

    void desc()
    {
        cout << "class A base class" << endl;
        cout << a  << endl;
        cout << a1 << endl;
        cout << a2 << endl;
        cout << a3 << endl;
    }
public:
    int a1;
protected:
    int a2;
private:
    int a3;
};
```

有 A、B、C、D 四个类分别使用 public、 protected、private 和默认的方式继承 Base 类：

```c++
#include <stdio.h>
#include <iostream>
#include "Base.hpp"

using namespace std;

class A: public Base { // public 继承
public:
    int a; // 重写
    void desc()
    {
        cout << "class B public extends from A" << endl;
        cout << a  << endl; // 正确， a  是 基类 Base 的 public 成员
        cout << a1 << endl; // 正确， a1 是 基类 Base 的 public 成员
        cout << a2 << endl; // 正确， a2 是 基类 Base 的 protected 成员
        cout << a3 << endl; // 错误， a3 是 基类 Base 的 private 成员
        cout << endl;
    }
};

class B: protected Base { // protected 继承
public:
    void desc()
    {
        cout << "class C protected extends from A" << endl;
        cout << a1 << endl; // 正确， a1 是 基类 Base 的 public 成员
        cout << a2 << endl; // 正确， a2 是 基类 Base 的 protected 成员
        cout << a3 << endl; // 错误， a3 是 基类 Base 的 private 成员
        cout << endl;
    }
};

class C: private Base { // private 继承
public:
    void desc()
    {
        cout << "class D private extends from A" << endl;
        cout << a  << endl; // 正确， a  是 基类 Base 的 public 成员
        cout << a1 << endl; // 正确， a1 是 基类 Base 的 public 成员
        cout << a2 << endl; // 正确， a2 是 基类 Base 的 protected 成员
        cout << a3 << endl; // 错误， a3 是 基类 Base 的 private 成员
        cout << endl;
}
    
    
class D: Base { // 默认是 private 继承
public:
    void desc()
    {
        cout << "class D private extends from A" << endl;
        cout << a  << endl; // 正确， a  是 基类 Base 的 public 成员
        cout << a1 << endl; // 正确， a1 是 基类 Base 的 public 成员
        cout << a2 << endl; // 正确， a2 是 基类 Base 的 protected 成员
        cout << a3 << endl; // 错误， a3 是 基类 Base 的 private 成员
        cout << endl;
    }
};
```

main.cpp

```c++
int main(int argc, const char *argv[])
{
    A a = A();
    B b = B();
    C c = C();
    D d = D();
    
    cout << a.a1 << endl; // 正确，基类的 public 成员外部可以访问
    cout << a.a2 << endl; // 错误，基类的 protected 成员外部不能访问
    cout << a.a3 << endl; // 错误，基类的 private 成员外部不能访问
  
    cout << b.a1 << endl; // 错误，基类的 public 成员，protected继承之后，在派生类中变成了 protected
    cout << b.a2 << endl; // 错误，基类的 protected 成员外部不能访问
    cout << b.a3 << endl; // 错误，基类的 private 成员外部不能访问

    cout << c.a1 << endl; // 错误，基类的 public 成员，private 继承之后，在派生类中变成了 private
    cout << c.a2 << endl; // 错误，基类的 protected 成员，private 继承之后，在派生类中变成了 private
    cout << c.a3 << endl; // 错误，基类的 private 成员外部不能访问
  
    cout << c.a1 << endl; // 错误，基类的 public 成员，默认（private）继承之后，在派生类中变成了 private
    cout << c.a2 << endl; // 错误，基类的 protected 成员，默认（private）继承之后，在派生类中变成了 private
    cout << c.a3 << endl; // 错误，基类的 private 成员外部不能访问
}
```

`struct` 的默认是 `public` 继承



| 继承方式      | 基类的public成员  | 基类的protected成员 | 基类的private成员 |     继承引起的访问控制关系变化概括     |
| :------------ | :---------------- | :------------------ | :---------------- | :------------------------------------: |
| public继承    | 仍为public成员    | 仍为protected成员   | 不可见            |  基类的非私有成员在子类的访问属性不变  |
| protected继承 | 变为protected成员 | 变为protected成员   | 不可见            |   基类的非私有成员都为子类的保护成员   |
| private继承   | 变为private成员   | 变为private成员     | 不可见            | 基类中的非私有成员都称为子类的私有成员 |

### 在hpp文件中使用 ifndef ... define 防止重复引用

C++程序的入口是 main.cpp 中的 main 函数，在编译的时候，编译器会将 #include 后面的文件中内容全部展开。那么如果两个 include 的头文件中直接或者间接应用了同一个文件，那么就会发生重复引用的问题，导致编译失败。

例如有 Base、A、B 三个类文件，他们分别对应 .hpp 和 .cpp 两个文件。

Base.hpp

```c++
#include <stdio.h>
class Base {
	 // ... 
};
```

A.hpp

```c++
#include "Base.hpp"
class A: Base { 
    // ....
};
```

B.hpp

```c++
#include "Base.hpp"
class B: Base { 
    // ....
};
```

如果在 main.cpp 中分别导入 A.hpp 和 B.hpp ，会发现报错了， `Redefinition of 'Base'`

```c++
#include "A.hpp"
#include "B.hpp"
int main(int argc, const char *argv[])
{
    //....
}
```

原因是 A.hpp 和 B.hpp 都导入了 Base.hpp，在编译展开的时候 Base中的内容出现了两次，所以导致错误。

解决方法是使用宏命令来避免重复导入，即已经导入的就不需要导入了。将 Base.hpp 修改如下：

Base.hpp

```c++
#ifndef Base_hpp
#define Base_hpp

#include <stdio.h>

class Base {
	 // ... 
};

#endif /* Base_hpp */
```

第一次展开时发现没有定义宏变量 Base_hpp，那么就定义宏变量，同时展开了 Base 类的相关内容。第二次展开的时候就不会走进ifndef里面了。



### 拷贝构造函数和拷贝赋值函数

https://www.cnblogs.com/wxl2578/p/3388767.html

使用已经创建的对象初始化一个新对象的时候，会调用**拷贝构造函数**

两个已经创建的对象之间赋值，会调用**拷贝赋值函数**

Employee.hpp

```c++
#include <stdio.h>
#include <string>

class Employee {
public:
    Employee();

    Employee(std::string id,
             std::string depart,
             int level = 1);

    // 拷贝构造函数
    Employee(const Employee & obj);

    // 拷贝赋值函数
    Employee& operator = (const Employee & obj);

    // 析构函数
    ~Employee(void);
    
    void work();

private:
  	std::string name;
    std::string emp_user_id;
    std::string emp_depart_id;
    int emp_level;
};
```

Employee.cpp

```c++
/*
 使用参数列表初始化成员变量
 但是父类的成员变量不能写到参数列表中，只能在构函数的函数体中进行赋值初始化
 */
Employee::Employee(string nm, string id, string depart, int lvl) : name(nm)emp_user_id(id), emp_depart_id(depart), emp_level(lvl)
{
    cout << "constructor (muti arguments) of class Employee" << endl;
}

/*
 拷贝构造函数
 拷贝构造函数通过同一类型的对象初始化新创建的对象。
 类对象的赋值操作会自动触发拷贝构造函数:

 Employee e1("wn", "012711", "5", 12);
 Employee e2 = e1;

 但是对已经创建了的对象重新赋值不会调用拷贝构造函数，而是会调用拷贝赋值函数
 Employee e1("wn", "012711", "5", 12);
 Employee e3("wn1", "012711", "5", 12);
 e3 = e1;

 如果不自己实现，编译器自动实现这个函数。
 */
Employee::Employee(const Employee & obj)
{
    cout << "invoked copy constructor of class Employee" << endl;
    name = obj.name + "_copy";
    emp_user_id = obj.emp_user_id + "_copy";
    emp_depart_id = obj.emp_depart_id + "_copy";
    set_age(obj.age);
}


// 拷贝赋值函数
Employee& Employee::operator=(const Employee & obj)
{
    cout << "invoked copy operator of class Employee" << endl;
    name = obj.name + "_operator";
    emp_user_id = obj.emp_user_id + "_operator";
    emp_depart_id = obj.emp_depart_id + "_operator";
    set_age(obj.age);
    return *this;
}

// 析构函数，类的对象被释放时会被调用
Employee::~Employee(void)
{
    cout << "Employee instance is deallocated" << endl;
}

```

main.cpp

```c++
int main(int argc, const char *argv[])
{
    // https://www.cnblogs.com/wxl2578/p/3388767.html

    cout << "========= phase 1 ==========" << endl;
    Employee e = Employee("willson", "0127", "7345", 19);

    cout << "========= phase 2 ==========" << endl;
    Employee e1("wn", "012711", "5", 12);

    cout << "========= phase 3 ==========" << endl;
    // 调用了拷贝构造函数
    Employee e2 = e1;

    cout << "========= phase 4 ==========" << endl;
    // 调用了有参数的构造函数
    Employee e3("wn1", "012711", "5", 12);
    // 调用了拷贝赋值函数
    e3 = e1;

    cout << "========= phase 5 ==========" << endl;
    // 调用了有参数的构造函数
    Employee e4 = { "e4", "1111", "99", 23 };

    cout << "========= phase 6 ==========" << endl;
    // 调用了无参构造函数
    Employee e6;
    // 调用了拷贝赋值函数
    e6 = e1;
}
/*
输出：
========= phase 1 ==========
constructor (muti arguments) of class Employee
========= phase 2 ==========
constructor (muti arguments) of class Employee
========= phase 3 ==========
invoked copy constructor of class Employee
========= phase 4 ==========
constructor (muti arguments) of class Employee
invoked copy operator of class Employee
========= phase 5 ==========
constructor (muti arguments) of class Employee
========= phase 6 ==========
constructor (no arguments) of class Employee
invoked copy operator of class Employee
*/
```



### 运算符重载

https://www.runoob.com/cplusplus/cpp-overloading.html

创建一个Param类，如下：

Param.hpp

```c++
#include <stdio.h>
#include <string>
#include <iostream>

using namespace std;

class Param {
private:
    int arr[SIZE];
public:
    double val1;
    double val2;

    Param();
    Param(double val1, double val2);
    Param(const Param & p);
    void desc(string other);
```

Param.cpp

```C++
#include <iostream>
using namespace std;

Param::Param()
{
    val1 = 1;
    val2 = 2;
    for (int i = 0; i < SIZE; i++) {
        arr[i] = i;
    }
}

Param::Param(double a, double b) : val1(a), val2(b) { }

// 拷贝构造函数
Param::Param(const Param & p)
{
    cout << "copy constructor of Param instance " << endl;
    val1 = p.val1;
    val2 = p.val2;
    subParam = p.subParam;
}

void Param::desc(string other)
{
    cout << other << "val1 : " << val1 << ", val2 : " << val2 << endl;
}

```

#### 1. 双目算术运算符重载

加、减、乘、除、取模等

这里以加法运算符 + 为例进行重载

```c++
// 用于 obj1 + obj2
Param operator + (const Param  & other); 
// 用于 obj + num
Param operator + (int num); 
// 通过友元函数来实现调换顺序的相加 num + obj
friend Param operator + (int n, Param obj); 
```

```c++
Param Param::operator+(const Param & other)
{
    cout << "operator + overload(obj1 + obj2)" << endl;
    Param newVal = Param(val1 + other.val1, val2 + other.val2);
    return newVal;
}

// 用于实现对象与数字之间相加 obj2 = obj1 + 10
// 但是 10 + obj1 这种调换了两者顺序的写法却不行，
// 可以通过友元函数来实现调换顺序的相加
Param Param::operator+(int n)
{
    cout << "operator + overload(obj + n)" << endl;
    Param newVal = Param(val1 + n, val2 + n);
    return newVal;
}

//友元函数来实现调换顺序的相加
Param operator +(int n, Param p) 
{
    cout << "operator + overload(n + obj), friend function " << endl;
    return p + n; // 调用第二个重载方法
}

```

main.cpp

```c++
int main(int argc, const char *argv[])
{
    Param p_2 = { 1, 2 };
    Param p_3 = { 3, 5 };
    //可以交换顺序，相当于p_res_1 = p_3.operator+(p_2);
    Param p_res_1 = p_2 + p_3; 
    p_res_1.desc("p_2 + p_3, ");


    Param p_res_5 = p_2 + 10;
    p_res_5.desc("p_2 + 10, ");

    // 交换顺序的加法实际调用的是Param的友元函数
    Param p_res_6 = 11 + p_2;  // operator+(11, p_2)
    p_res_6.desc("11 + p_2, ");
}
/*
输出：
operator + overload(obj1 + obj2)
p_2 + p_3, val1 : 4, val2 : 7

operator + overload(obj + n)
p_2 + 10, val1 : 11, val2 : 12

operator + overload(n + obj), friend function 
11 + p_2, val1 : 12, val2 : 13
*/
```

------

#### 2.自增自减运算符

这里以自增运算符 ++ 为例

```c++
// 重载递增前缀运算符 ++p
Param operator++ ();
// 重载自增后缀运算符 p++
Param operator++ (int);
```

```c++
// 递增递减运算符 重载
// https://www.runoob.com/cplusplus/increment-decrement-operators-overloading.html
// 重载递增前缀运算符  a = ++b
Param Param::operator ++()
{
    cout << "operator ++ (prefix)  overload(++obj)" << endl;
    ++val1;
    ++val2;
    return Param(val1, val2);
}

/*
 a = b++
 注意，int 在 括号内是为了向编译器说明这是一个后缀形式，而不是表示整数。
 这个形参是0，但是在函数体中是用不到的，只是用作区分。
 前缀形式重载调用 Param operator ++ () ，后缀形式重载调用 operator ++ (int)。
 */
Param Param:: operator ++(int)
{
    cout << "operator ++ (surfix)  overload(obj++)" << endl;
    // 保存旧值
    Param old = Param(val1, val2);
    // 递增
    ++val1;
    ++val2;
    // 返回旧的原始值
    return old;
}
```

main.cpp

```c++
int main(int argc, const char *argv[])
{
    cout << "======== phase 1 ========" << endl;
    Param p_1 = { 1, 2 };
    p_1.desc("++p_1 before, ");
    Param res1 = ++p_1; 
    p_1.desc("++p_1 after , ");
    res1.desc("res1 after ++p_1, ");
    
    cout << "======== phase 2 ========" << endl;
    Param p_1_1 = {2,3};
    p_1_1.desc("p_1_1++ before, ");
    Param res2 = p_1_1++; 
    p_1_1.desc("p_1_1++ after, ");
    res2.desc("res2 after p_1_1++, ");
}
/*
======== phase 1 ========
++p_1 before, val1 : 1, val2 : 2
operator ++ (prefix)  overload(++obj)
++p_1 after , val1 : 2, val2 : 3
res1 after ++p_1, val1 : 2, val2 : 3
======== phase 2 ========
p_1_1++ before, val1 : 2, val2 : 3
operator ++ (surfix)  overload(obj++)
p_1_1++ after, val1 : 3, val2 : 4
res2 after p_1_1++, val1 : 2, val2 : 3
*/
```

------

#### 3.关系运算符重载

```c++
// 关系运算符 大于 小于
bool operator < (const Param & other);
bool operator < (double n);
bool operator > (double n);
friend bool operator > (double n, Param & p); // 用于 n > p
```

```c++
// https://www.runoob.com/cplusplus/relational-operators-overloading.html
//(1) obj1 < obj2
bool Param::operator <(const Param & other)
{
    cout << "operator < overload(obj1 < obj2)" << endl;
    return val1 < other.val2 && val2 < other.val2;
}

//(2) obj < n
bool Param::operator <(double n)
{
    cout << "operator < overload(obj < n)" << endl;
    return (val1 < n) && (val2 < n);
}

//(3) obj > n
bool Param::operator >(double n)
{
    cout << "operator > overload(obj > n)" << endl;
    return val1 > n && val2 > n;
}

//(4) 友元函数实现  n > obj
bool operator >(double n, Param & p)
{
    cout << "operator > overload(n > obj), friend function " << endl;
    return p < n; // 调用了重载函数(2)
}
```

main.cpp

```c++
int main(int argc, const char *argv[])
{
    Param p_4 = { 1, 2 };
    Param p_5 = { 4, 5 };
    bool p_res_7 = p_4 < p_5; // p_4.operator<(p_5)
    cout << "p_4 < p_5 ? " << (p_res_7 ? "true" : "false") << endl;

    bool p_res_8 = p_4 > 0.5; // p_4.operator>(0.5)
    cout << "p_4 > 0.5 ? " << (p_res_8 ? "true" : "false") << endl;

    bool p_res_9 =  6.8 > p_5; // 调用了有元函数 operator>(6.8, p_5)
    cout << "6.8 > p_5 ? " << (p_res_9 ? "true" : "false") << endl;
}
/*
operator < overload(obj1 < obj2)
p_4 < p_5 ? true
operator > overload(obj > n)
p_4 > 0.5 ? true
operator > overload(n > obj), friend function 
6.8 > p_5 ? true
*/
```

------

#### 4.赋值运算符重载

```c++
void operator = (const Param & other);
```

```c++
void Param::operator=(const Param & p)
{
    cout << "operator = overload " << endl;
    val1 = p.val1;
    val2 = p.val2;
}
```

main.cpp

```c++
int main(int argc, const char *argv[])
{
    Param p_7 = { 11, 33 };
    Param p_8 = p_7; // 因为p_8未初始化，在赋值之后调用了拷贝构造函数
    p_8.desc("p_8 ,");
    Param p_9 = { 9, 8 };
    p_9 = p_7; // 因为p_9已经初始化，在赋值之后调用了重载的赋值运算符函数
    p_9.desc("p_9 ,");
}
/*
copy constructor of Param instance 
p_8 ,val1 : 11, val2 : 33
operator = overload 
p_9 ,val1 : 11, val2 : 33
*/
```

------

#### 5.下标运算符重载

重载下标运算符可以让对象具备数组的访问元素的能力。下面通过使用下标来访问Param的数组成员变量中的指定索引的元素。

```c++
int operator[] (int index);
```

```c++
int Param::operator[](int index)
{
    cout << "operator [] overload " << endl;
    if (index < 0 || index >= SIZE) {
        return -1;
    }
    return arr[index];
}
```

main.cpp

```c++
int main(int argc, const char *argv[])
{
    Param p_11 = Param();
    int val_7_p_11 = p_11[7];
    cout << "value of arr at index 7 of p_11 : " << val_7_p_11 << endl;
}
/*
operator [] overload 
value of arr at index 7 of p_11 : 7
*/
```

------

#### 6.输入/输出运算符重载

https://www.runoob.com/cplusplus/input-output-operators-overloading.html

C++可以使用流提取运算符 >> 和流插入运算符 << 来输入和输出内置数据类型，但是如果是想通过这种方式输入或输出自定义的类型，

那么需要让这个类型对这两个运算符进行重载。

在这里，有一点很重要，我们需要把运算符重载函数声明为类的友元函数，这样我们就能不用创建对象而直接调用函数。

下面的实例演示了如何重载提取运算符 >> 和插入运算符 <<。

```c++
ostream & operator << (ostream & o);
istream & operator >> (istream & i);
friend ostream &operator << (ostream & o, const Param & p);
friend istream &operator >> (istream & i, Param & p);
```

```c++
// cout << p
ostream & operator <<(ostream & output, const Param & p)
{
    cout << "output operator << overload (friend function)" << endl;
    output << "Instance of Param, val1 : " << p.val1 << ", and val2 : " << p.val2 << endl;
    return output;
}

// cin >> p
istream & operator >>(istream & input, Param & p)
{
    cout << "input operator >> overload (friend function) " << endl;
    input >> p.val1 >> p.val2;
    return input;
}

// p<<cout
ostream & Param::operator<<(ostream & output)
{
    cout << "output operator << overload (property function)" << endl;
    output << "Instance of Param, val1 : " << val1 << ", and val2 : " << val2 << endl;
    return output;
}

// p>>cin
istream & Param::operator>>(istream & input)
{
    cout << "input operator >> overload (property function) " << endl;
    input >> val1 >> val2;
    return input;
}
```

main.cpp

```c++
int main(int argc, const char *argv[])
{
    Param p_13 = {5,6};
    cout << p_13 << endl; // 调用了友元的 输出重载函数
    p_13<<cout; // 调用了成员函数的输出重载函数， 这种调用方式看起来不自然
}
/*
output operator << overload (friend function)
Instance of Param, val1 : 5, and val2 : 6

output operator << overload (property function)
Instance of Param, val1 : 5, and val2 : 6
*/
```

------

#### 7.函数调用运算符 () 重载

```c++
void operator() (int a, int b, int c);
```

```c++
void Param::operator()(int a, int b, int c)
{
    cout << "operator () overload " << endl;
    val1 = a + b;
    val2 = a + c;
}
```

main.cpp

```c++
int main(int argc, const char *argv[])
{
    Param p_10;
    p_10(7, 9, 3); // 调用了运算符（）重载函数
    p_10.desc("p_10 ,");
}
/*
operator () overload 
p_10 ,val1 : 16, val2 : 10
*/
```

------

#### 8.类成员访问运算符 -> 重载

https://www.runoob.com/cplusplus/class-member-access-operator-overloading.html

类成员访问运算符（ -> ）可以被重载，但它较为麻烦。它被定义用于为一个类赋予"指针"行为。运算符 -> 必须是一个成员函数。如果使用了 -> 运算符，返回类型必须是指针或者是类的对象。

运算符 -> 通常与指针引用运算符 * 结合使用，用于实现"智能指针"的功能。这些指针是行为与正常指针相似的对象，唯一不同的是，当您通过指针访问对象时，它们会执行其他的任务。比如，当指针销毁时，或者当指针指向另一个对象时，会自动删除对象。

间接引用运算符 -> 可被定义为一个一元后缀运算符。也就是说，给出一个类。

下面先定义一个新的类 SubParam，我们通过重载Param的 -> 运算符来访问SubParam中的成员：

```c++
class SubParam {
public:
    SubParam(int val);
    void printInfo();
private:
    int val;
};
```

```c++
SubParam::SubParam(int val)
{
    this->val = val;
}

void SubParam::printInfo()
{
    cout << "SubParam, val : " << val << endl;
}
```

Param中添加初始化方法和重载函数，修改如下：

```c++
class Param {
private:
    int arr[SIZE];
  
public:
    double val1;
    double val2;
    SubParam *subParam;

    Param();
    Param(double val1, double val2);
    Param(double val1, double val2, SubParam *const sp);
    Param(const Param & p);
  
    // 类成员访问运算符 -> 重载
    SubParam *operator->();
}
```

```c++
Param::Param()
{
    val1 = 1;
    val2 = 2;
    for (int i = 0; i < SIZE; i++) {
        arr[i] = i;
    }
}

Param::Param(double a, double b) : val1(a), val2(b) { }

Param::Param(double a, double b, SubParam *const sp)
{
    val1 = a;
    val2 = b;
    subParam = sp;
}

// 拷贝构造函数
Param::Param(const Param & p)
{
    cout << "copy constructor of Param instance " << endl;
    val1 = p.val1;
    val2 = p.val2;
    subParam = p.subParam;
}

// ->重载函数中返回了 SubParam 的指针变量，
// 通过这个重载函数，就可以直接访问SubParam的成员变量和调用成员函数了
SubParam * Param::operator ->()
{
    cout << "operator -> overload " << endl;
    return subParam;
}
```

main.cpp

```c++
int main(int argc, const char *argv[])
{
    SubParam sp(11);
    Param p_12 = Param(22, 33, &sp);
    (&sp)->printInfo(); // 和下面的调用方式等效
    p_12->printInfo();  // 调用了 Param 中的 -> 重载函数
    int sub_val = p_12->val;
    cout << "val in SubParam : " << sub_val << endl; // 通过 -> 符号访问了SubParam的成员变量 val
}
/*
SubParam, val : 11
operator -> overload 
SubParam, val : 11
operator -> overload 
val in SubParam : 11
*/
```



### [未完] 菱形继承和虚基类

http://c.biancheng.net/view/2280.html

### [未完] union

### [未完] vector 的基本操作以及和数组的不同

### [未完] 字符串、数组的拷贝

### [未完] inline 内联函数

### [未完] 友元类和友元函数

### [未完] .mm文件 以及 .cpp 和 .hpp 文件

### [未完] vector 的使用

### [未完] auto 关键字的用法

### [未完] 类型限定符volatile

### [未完] thread_local

### [未完] decltype

### [未完] 模板函数

### [未完] do ... while(0) 在宏定义冲的作用