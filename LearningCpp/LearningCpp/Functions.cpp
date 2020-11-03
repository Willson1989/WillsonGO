//
//  Functions.cpp
//  StudyCpp
//
//  Created by fn-273 on 2020/9/29.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#include "Functions.hpp"
#include <iostream>
#include <vector>
#include <functional>
#include <typeinfo>
#include <string>
#include <ctime>
#include <sstream>
#include <iostream>
#include "Param.hpp"
#include "Employee.hpp"
#include "Tiger.hpp"
#include "Hawk.hpp"
#include "Shape.hpp"
#include "Rectangle.hpp"

using namespace std;

void refrence_temp_func(int & n);
int & refrence_temp_func_1(int & n);
void changeVal_1(int index, int array[], int len, int val);
void print_array(int *arr, int len);
void genRandomNums(int len, int *arr);
int * gen_arr(int len);
void print_tm(tm *t);
void clock_study();
void print_student(struct Student *s);

struct Student {
    string name;
    string address;
    int age;
};

typedef struct Book {
    string name;
    string id;
} Book;

void polymorphisn_abstract_class_study()
{
    Animal *anim;
    Tiger t = Tiger("A");
    Hawk h = Hawk("B");

    anim = &t;
    anim->fly();
    anim->sleep();

    anim = &h;
    anim->fly();
    anim->sleep();

    /*
     输出：
     Base class Animal - A, fly
     Base class Animal - A, sleep
     Base class Animal - B, fly
     Base class Animal - B, sleep

     结果显示，即使anim分别指向了Tiger和Hawk实例，程序还是调用了父类的fly和sleep方法。
     这就是所谓的静态多态，或者静态链接、静态绑定 。
     函数调用在程序执行前就准备好了。有时候这也被称为早绑定，因为函数在程序编译期间就已经设置好了。
     */

    /*
     输出：
     Tiger - A cannot fly
     Tiger - A sleep
     Hawk  - B cannot fly
     Hawk  - B sleep

     将基类Animal中的方法声明加上 virtual 关键字之后，变为虚函数，
     此时编译器看的是指针的内容，即 anim 这个指针实际指向的是什么类型实例。
     当调用 sleep 和 fly 函数时，是在运行时期决定的，这时会调用每个实例各自的方法。
     */

    //Shape shape; // 不能实例化Shape，因为它是抽象类

    Rectangle rect = { 10, 20, "red" }; // Rectangle 继承自抽象类 Shape，如果Rectangle没有实现 Shape中的纯虚函数，则会报错。
    double area = rect.area();
    string color = rect.getColor();
    cout << "area : " << area << ", color : " << color << endl;

    /*
     输出：
     function area of Rectangle
     function getColor of Rectangle
     area : 200, color : red
     */
}

void operators_overload_study()
{
    cout << "======== phase 1 ========" << endl;
    Param p_1 = { 1, 2 };
    p_1.desc("++p_1 before, ");
    Param res1 = ++p_1;
    p_1.desc("++p_1 after , ");
    res1.desc("res1 after ++p_1, ");

    cout << "======== phase 2 ========" << endl;
    Param p_1_1 = { 2, 3 };
    p_1_1.desc("p_1_1++ before, ");
    Param res2 = p_1_1++;
    p_1_1.desc("p_1_1++ after, ");
    res2.desc("res2 after p_1_1++, ");

    cout << "======== phase 2 ========" << endl;
    Param p_2 = { 1, 2 };
    Param p_3 = { 3, 5 };
    Param p_res_1 = p_2 + p_3; //可以交换顺序，相当月p_res_1 = p_3.operator+(p_2);
    p_res_1.desc("p_2 + p_3, ");

    Param p_res_2 = p_2 - p_3;
    p_res_2.desc("p_2 - p_3, ");

    Param p_res_3 = p_2 * p_3;
    p_res_3.desc("p_2 * p_3, ");

    Param p_res_4 = p_2 / p_3;
    p_res_4.desc("p_2 / p_3, ");

    Param p_res_5 = p_2 + 10;
    p_res_5.desc("p_2 + 10, ");

    Param p_res_6 = 11 + p_2; // 交换顺序的加法实际调用的是Param的友元函数
    p_res_6.desc("11 + p_2, ");
    /*
     输出：
     p_2 + p_3, val1 : 4, val2 : 7
     p_2 - p_3, val1 : -2, val2 : -3
     p_2 * p_3, val1 : 3, val2 : 10
     p_2 / p_3, val1 : 0.333333, val2 : 0.4
     p_2 + 10, val1 : 11, val2 : 12
     11 + p_2, val1 : 12, val2 : 13
     */

    cout << "======== phase 2 ========" << endl;
    Param p_4 = { 1, 2 };
    Param p_5 = { 4, 5 };
    bool p_res_7 = p_4 < p_5;
    cout << "p_4 < p_5 ? " << (p_res_7 ? "true" : "false") << endl;

    bool p_res_8 = p_4 > 0.5;
    cout << "p_4 > 0.5 ? " << (p_res_8 ? "true" : "false") << endl;

    bool p_res_9 =  6.8 > p_5;
    cout << "6.8 > p_5 ? " << (p_res_9 ? "true" : "false") << endl;

    cout << "======== phase 3 ========" << endl;
    Param p_6 = { 11, 22 };
    cout << p_6 << endl;

    //cout << "Enter the value of Param : " << endl;
    //Param p_7;
    //cin >> p_7;
    //cout << p_7;

    cout << "======== phase 4 ========" << endl;
    Param p_7 = { 11, 33 };
    Param p_8 = p_7; // 因为p_8未初始化，在赋值之后调用了拷贝构造函数
    p_8.desc("p_8 ,");
    Param p_9 = { 9, 8 };
    p_9 = p_7; // 因为p_9已经初始化，在赋值之后调用了重载的赋值运算符函数
    p_9.desc("p_9 ,");

    cout << "======== phase 5 ========" << endl;
    Param p_10;
    p_10(7, 9, 3); // 调用了运算符（）重载函数
    p_10.desc("p_10 ,");

    cout << "======== phase 6 ========" << endl;
    Param p_11 = Param();
    int val_7_p_11 = p_11[7];
    cout << "value of arr at index 7 of p_11 : " << val_7_p_11 << endl;

    cout << "======== phase 7 ========" << endl;
    SubParam sp(11);
    Param p_12 = Param(22, 33, &sp);
    (&sp)->printInfo(); // 和下面的调用方式等效
    p_12->printInfo();  // 调用了 Param 中的 -> 重载函数
    int sub_val = p_12->val;
    cout << "val in SubParam : " << sub_val << endl; // 通过 -> 符号访问了SubParam的成员变量 val

    cout << "======== phase 8 ========" << endl;
    Param p_13 = { 5, 6 };
    cout << p_13 << endl; // 调用了友元的 输出重载函数
    p_13 << cout; // 调用了成员函数的输出重载函数， 这种调用方式看起来不自然
}

void oop_study()
{
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

    cout << "========= phase 7 ==========" << endl;
    FriendEmployee fe(e1, "Special emp");
    fe.desc();

    cout << "========= phase 8 ==========" << endl;
    Employee e7 = Employee();
    Employee *ptr_e7 = &e7;
    ptr_e7->set_name("will");
    ptr_e7->set_age(10);
    ptr_e7->set_address("Shenyang");
    desc_employee_info(*ptr_e7);
}

void struct_study()
{
    Student *s1 = new Student();
    s1->name = "willson";
    s1->address = "shenyang";
    s1->age = 12;
    print_student(s1);

    Student s2;
    s2.name = "zhengyi";
    s2.address = "beijing";
    s2.age = 15;
    print_student(&s2);
}

void time_study()
{
    // 获取当前时间
    time_t now = time(0);

    // 该返回一个表示当地时间的字符串指针，字符串形式 day month year hours:minutes:seconds year\n\0。
    char *now_str = ctime(&now);
    cout << "time string - now : " << now_str << endl;
    // 输出：time string - now : Wed Oct  7 18:07:49 2020

    tm *tm_now = localtime(&now);
    print_tm(tm_now);
    clock_study();

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

void clock_study()
{
    clock_t begin, end;

    begin = clock();

    cout << "seconds science app start : " << ((double)begin / CLOCKS_PER_SEC) << endl;

    for (int i = 0; i < 900000000; i++) {
    }

    end = clock();

    double diff = ((double)(end - begin)) / CLOCKS_PER_SEC;

    cout << "seconds of for loop statement : " << diff << endl;
}

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

void pointer_study()
{
    const char *names[4] = { "willson", "zhengyi", "helen", "zhujinqian" };
    for (int i = 0; i < 4; i++) {
        const char *name = names[i];
        cout << "name in array : " << name << endl;
    }
}

void string_study()
{
    // C 风格字符串

    // strcat
    char s1[20] = { 'w', 'i', 'l', 'l' };
    char s2[20] = { 'h', 'e', 'l', 'e' };
    // 将 s1 和 s2 拼接并赋给 s1，所以s1应该有足够大。
    strcat(s1, s2);
    cout << "after strcat 1 : " << s1 << endl;
    // after strcat 1 : willhele

    // 或者不指定容量
    char s11[] = "willson";
    char s22[] = "helenZhu";
    strcat(s11, s22);
    cout << "after strcat 2 : " << s11 << endl;
    // after strcat 2 : willsonhelenZhu

    // strcpy
    char s_cpy_1[] = "hi";
    char s_cpy_2[] = "good morning";
    cout << "strcpy before : " << s_cpy_1 << endl;
    strcpy(s_cpy_1, s_cpy_2);
    cout << "strcpy after  : " << s_cpy_1 << endl;
    // strcpy before : hi
    // strcpy after  : good morning

    // strlen
    char s_len[] = "thank you";
    size_t s_len_len = strlen(s_len);
    cout << "length of s_len : " << s_len_len << endl;
    // length of s_len : 9

    // strchr
    char s_strchr[] = "nice_to_see_you";
    char *first = strchr(s_strchr, 'c');
    cout << "content after  first c : " << first << endl;
    *first = '\0'; // 将 first 位置的字符赋值为结束符 \0
    cout << "content before first c : " << s_strchr << endl;
    // content after  first c : ce_to_see_you
    // content before first c : ni

    // strstr
    char s_strstr[] = "nice_to_see_you_too~~";
    char *first_str = strstr(s_strstr, "to");
    cout << "content after  first string 'to' : " << first_str << endl;
    *first_str = '\0'; // 将 first 位置的字符赋值为结束符 \0
    cout << "content before first string 'to' : " << s_strstr << endl;
    // content after  first string 'to' : to_see_you_too~~
    // content before first string 'to' : nice_

    // C++ 风格字符串
    string s_cpp_1 = "Hello_";
    string s_cpp_2 = "world";
    string s_cpp_3;

    s_cpp_3 = s_cpp_1;
    cout << "copy , s_cpp_3 : " << s_cpp_3 << endl;
    // copy , s_cpp_3 : Hello_

    s_cpp_3 = s_cpp_1 + s_cpp_2;
    cout << "concat, s_cpp_3 : " << s_cpp_3 << endl;
    // concat, s_cpp_3 : Hello_world

    int len_cpp = (int)s_cpp_3.length();
    int len_cpp_1 = (int)s_cpp_3.size();
    cout << "length of s_cpp_3 : " << len_cpp << endl;
    cout << "length_1 of s_cpp_3 : " << len_cpp_1 << endl;
    // length of s_cpp_3 : 11
    // length_1 of s_cpp_3 : 11

    // 子字符串，从索引位置4开始
    string s_cpp_4 = string(s_cpp_3, 4);
    cout << "substring  of s_cpp_3 from index 4 : " << s_cpp_4 << endl;
    // substring  of s_cpp_3 from index 4 : o_world

    // 子字符串，从索引位置1开始，长度为4
    string s_cpp_5 = string(s_cpp_3, 1, 4);
    cout << "substring (1, 4) of s_cpp_3 : " << s_cpp_5 << endl;
    // substring (1, 4) of s_cpp_3 : ello

    // 初始化字符串，6个A
    string s_cpp_6 = string(6, 'A');
    cout << "number of 'A' is 6 : " << s_cpp_6 << endl;
    // number of 'A' is 6 : AAAAAA

    // 清空字符串，并设置为 "ABC"
    string s_cpp_7 = "I_am_very_good";
    s_cpp_7.assign("ABC");
    cout << "assign(\"ABC\") : " << s_cpp_7 << endl;
    // assign("ABC") : ABC

    // 清空字符串，并设置为"AB"，保留两个字符
    string s_cpp_8 = "I_am_very_good";
    s_cpp_8.assign("ABC", 2);
    cout << "assign(\"ABC\",2) : " << s_cpp_8 << endl;
    // assign("ABC",2) : AB

    // 清空字符串，设置为 "ABC" 中的从 位置1 开始，保留 1个 字符
    string s_cpp_9 = "I_am_very_good";
    s_cpp_9.assign("ABCDEF", 1, 3);
    cout << "assign(\"ABCDEF\", 1, 3) : " << s_cpp_9 << endl;
    // assign("ABCDEF", 1, 3) : BCD

    // 清空字符串，然后字符串设置为 5个 'A'
    string s_cpp_10 = "I_am_very_good";
    s_cpp_10.assign(5, 'A');
    cout << "assign(5, 'A') : " << s_cpp_10 << endl;
    // assign(5, 'A') : AAAAA

    string s_cpp_11 = "will_done";
    cout << "s_cpp_11 before resize(4) : " << s_cpp_11 << ", len : " << s_cpp_11.length() << endl;
    // 设置当前 str 的大小为10，若大小大与当前串的长度，\0 来填充
    s_cpp_11.resize(4);
    cout << "s_cpp_11 after resize(4) : " << s_cpp_11 << ", len : " << s_cpp_11.length() << endl;
    // s_cpp_11 before resize(4) : will_done, len : 9
    // s_cpp_11 after resize(4) : will, len : 4

    string s_cpp_12 = "good";
    cout << "s_cpp_12 length before resize(10, 'X') : " << s_cpp_12.length() << endl;
    // 设置当前 str 的大小为10，若大小大与当前串的长度，字0符c 来填充
    s_cpp_12.resize(10, 'X');
    cout << "s_cpp_12 after resize(10, 'X') : " << s_cpp_12 << ", len : " << s_cpp_12.length() << endl;
    // s_cpp_12 length before resize(10, 'X') : 4
    // s_cpp_12 after resize(10, 'X') : goodXXXXXX, len : 10

    string s_cpp_swap_1 = "will";
    string s_cpp_swap_2 = "helen";
    cout << "swap, s1 before: " << s_cpp_swap_1 << ", s2 : " << s_cpp_swap_2 << endl;
    // 交换 str1 和 str 的字符串
    s_cpp_swap_1.swap(s_cpp_swap_2);
    cout << "swap, s1 after : " << s_cpp_swap_1 << ", s2 : " << s_cpp_swap_2 << endl;
    // swap, s1 before: will, s2 : helen
    // swap, s1 after : helen, s2 : will

    // 反转字符串
    string s_cpp_13 = "net";
    reverse(s_cpp_13.begin(), s_cpp_13.end());
    cout << "reverse, s_cpp_12 : " << s_cpp_13 << endl;
    //reverse, s_cpp_12 : ten

    //删除
    string s_cpp_14 = "willson";
    s_cpp_14.erase();
    cout << "erase, s_cpp_14 : " << s_cpp_14 << endl;
    // erase, s_cpp_14 :

    string s_cpp_15 = "willson";
    // 删除从索引位置1开始到末尾的字符
    s_cpp_15.erase(3);
    cout << "erase(3), s_cpp_15 : " << s_cpp_15 << endl;
    // erase(3), s_cpp_15 : wil

    string s_cpp_16 = "willson";
    // 删除从索引位置1开始的2个字符
    s_cpp_16.erase(3, 2);
    cout << "erase(3, 2), s_cpp_16 : " << s_cpp_16 << endl;
    // erase(3, 2), s_cpp_16 : wilon

    // 替换
    string s_cpp_17 = "willson";
    // 从索引位置2开始的2个字符替换成 XXXX
    s_cpp_17.replace(2, 2, "XXXX");
    cout << "replace(2, 2, \"XXXX\"), s_cpp_17 : " << s_cpp_17 << endl;
    // replace(2, 2, "XXXX"), s_cpp_17 : wiXXXXson

    string s_cpp_18 = "willson";
    cout << "s_cpp_18 is empty : " << (s_cpp_18.empty() == 1 ? "true" : "false")  << endl;
    s_cpp_18.clear();
    cout << "s_cpp_18 is empty : " << (s_cpp_18.empty() == 1 ? "true" : "false")  << endl;
    // s_cpp_18 is empty : false
    // s_cpp_18 is empty : true

    // 查找
    string s_cpp_19 = "willson";
    // 查找字符 s，在字符串中出现的第一个的索引
    int find_19 = (int)s_cpp_19.find('l');
    cout << "willson, find('l') : " << find_19 << endl;
    // willson, find('l') : 2

    string s_cpp_20 = "willson";
    // 查找子字符串 son 第一个出现的索引位置
    int find_20 = (int)s_cpp_20.find("son");
    cout << "willson, find(\"son\") : " << find_20 << endl;
    // willson, find("son") : 4

    string s_cpp_21 = "abcabcabc";
    // 从索引4的位置开始查找字符 a 第一次出现的位置
    int find_21 = (int)s_cpp_21.find('a', 4);
    cout << "abcabcabc, find('a', 4) : " << find_21 << endl;
    // abcabcabc, find('a', 4) : 6

    string s_cpp_22 = "abcabcdabc";
    // 从索引2的位置开始查找字符传 abcd 的前3个字符第一次出现的位置
    int find_22 = (int)s_cpp_22.find("abcd", 2, 3);
    cout << "abcabcddabc, find(\"abc\", 4) : " << find_22 << endl;
    // abcabcddabc, find("abc", 4) : 3

    // 子串
    string s_cpp_23 = "willson";
    // 子串，从索引2开始到结尾的子字符串
    string s_cpp_23_sub = s_cpp_23.substr(2);
    cout << "willson, substring from index 2 : " << s_cpp_23_sub << endl;
    // willson, substring from index 2 : llson

    string s_cpp_24 = "willson";
    // 子串，从索引2开始3个字符的子字符串
    string s_cpp_24_sub = s_cpp_23.substr(2, 3);
    cout << "willson, substring from index 2, last 3 : " << s_cpp_24_sub << endl;
    // willson, substring from index 2, last 3 : lls
}

void array_study()
{
    int arr1[4] = { 1, 2, 3, 4 };
    int len_arr1 = sizeof(arr1) / sizeof(int);
    int *parr1 = arr1;
    cout << "arr size : " << sizeof(arr1) << endl;
    cout << "items of arr1 : " << endl;
    for (int i = 0; i < len_arr1; i++) {
        cout << "item : " << *(parr1 + i) << endl;
    }

    changeVal_1(2, arr1, len_arr1, 99);
    print_array(arr1, len_arr1);
    changeVal_1(1, arr1, len_arr1, 33);
    print_array(arr1, len_arr1);

    char var[4] = { 'a', 'b', 'c', 'd' };
    char *pvar = var;

    // cout 会把 char 数组和 char * 指针当做字符串处理，所以会输出字符串的内容，而不是首字母的地址
    cout << "pvar : " << pvar << ", var array : " << var << endl;
    // 需要将 char * 类型转换成别的指针， int *、 double * 、 void * 都可以，然后使用cout才能输出首字母的地址
    cout << "address of first char in var : " << (int *)pvar << endl;

    int *a = gen_arr(4);
    print_array(a, 4);
    delete [] a;
}

int * gen_arr(int len)
{
    //int arr[len];
    int *arr = new int[len];
    for (int i = 0; i < len; i++) {
        arr[i] = i;
    }
    return arr;
}

void genRandomNums(int len, int *arr)
{
    for (int i = 0; i < len; i++) {
        int a = rand() % 100;
        arr[i] = a;
    }
}

void changeVal_1(int index, int array[], int len, int val)
{
    if (index < 0 || index >= len) {
        return;
    }
    array[index] = val;
}

void changeVal_2(int index, int *array, int len, int val)
{
    if (index < 0 || index >= len) {
        return;
    }
    array[index] = val;
}

void print_array(int *arr, int len)
{
    for (int i = 0; i < len; i++) {
        if (i == len - 1) {
            cout << *(arr + i) << endl;
        } else {
            cout << *(arr + i) << ", ";
        }
    }
}

void pointer_and_refrence_study()
{
    // 引用相当于变量的别名，所以声明的时候就必须有初值。
    // 一旦声明，这个引用就会一直跟着这个变量，即使用另一个变量对它进行赋值，也只是改变了值，引用还是那个引用。
    // 指针则不同，它虽然指向了一个变量，但是可以通过赋值再让它指向另一个变量。
    // 所以引用是”专一的“，指针是”善变的“
    int i = 10;
    int j = 99;
    int& r = i;
    cout << "i : " << i << endl;
    // 语句r = j并不能将 r 修改成为j的引用，只是把 r 的值改变成为 99 。由于 r 是 i 的引用，所以 i 的值也变成了99。
    r = j;
    cout << "after set r to j  , r : " << r << ", i : " << i << ", j : " << j << endl;
    i = 77;
    cout << "after set i to 77 , r : " << r << ", i : " << i << ", j : " << j << endl;
    j = 11;
    cout << "after set j to 11 , r : " << r << ", i : " << i << ", j : " << j << endl;
    //int & m = 19; // 编译错误，引用必须与合法的存储单元关联，并且不可以为null
    //int & n; // 引用在声明的时候必须有初值

    int aa = 9;
    int & aar = aa;
    int & aar1 = aar;
    aar1 += 10;
    cout << "after adding , aa : " << aa << ", aar : " << aar << ", aar1 : " << aar1 << endl;

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
    cout << "after  , bb : " << bb << ", bbr : " << bbr << ", new_bbr : " << new_bbr << endl;

    // 常量引用
    int a = 8;
    const int& ra = a;
    // ra = 9; // 编译错误，ra是常量引用，所以不能给修改ra的值，但是可以通过改变a的值来改变ra的值
    a = 9;
    cout << "after set a , ra : " << ra << endl;

    // 常量指针  const int * 代表该指针变量指向一个常量，这个常量的值不可以改变，但是可以改变这个指针变量，指向别的变量
    int ci = 10;
    const int *cip = &ci;
    // *cip = 99; // 错误，虽然 ci 不是const，但是 cip 是指向 const int 的指针，所以 *cip = 99 是错误的。
    cout << "before, ci : " << ci << ", cip value : " << *cip << endl;
    ci = 99;
    cout << "after,  ci : " << ci << ", cip value : " << *cip << endl;

    // 指针常量，int * const 代表这个指针变量是一个常量，指这个指针自己的值（即变量的地址）是不可以改变的。
    int *const pci = &ci;
    *pci = 88;
    // int ci1 = 90;
    // pci = &ci1; // 错误，pci是指针常量，声明并赋给初值之后就不能改变指向了。
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

void auto_study()
{
    int n = 100;
    const type_info &nInfo = typeid(n);
    cout << nInfo.name() << " | " << nInfo.hash_code() << endl;
}

void decltype_study()
{
}

int outside_global_var = 199;

void lambda_study()
{
    int a = 1, b = 2, c = 3;

    // [ = ]， lambda 所在作用域中，会按值捕获所有局部变量
    auto func1 = [ = ](int x, int y) -> int {
            return a + b + x + y;
        };

    int res_func1 = func1(4, 5);
    cout << "func1 result : " << res_func1 << endl;

    // auto func2 = [&a, &b](int x) -> int {
    //     a = x; // 由于&a的存在，在lambda函数体内部可以改变变量 a 的值
    //     return a + b + c; // 报错，因为函数对象参数中没有写 =， 所以不能使用func2所在作用域中的局部变量 c
    // };

    // [ =, &a, &b ]， 在 lambda 所在作用域中，会按值捕获除了 a 和 b 之外的所有局部变量，a 和 b 都是按引用捕获。
    auto func2 = [ =, &a, &b ](int x) -> int {
            a = x;     // 由于&a的存在，在lambda函数体内部可以改变变量 a 的值
            return a + b + c;
        };

    cout << "before call func2, a : " << a << ", b : " << b << endl;
    int res_func2 = func2(8);
    cout << "after  call func2, a : " << a << ", b : " << b << ", result : " << res_func2 << endl;

    // [&, c]， 在 func3 所在作用域中，只会按值捕获局部变量 c，其他局部变量都是按引用捕获。
    auto func3 = [&, c] (int x) -> int {
            a = 10;     // 改变 a 的值，会影响外部变量的值
            b = 20;     // 改变 b 的值，会影响外部变量的值
            return a + b + c;
        };

    cout << "before call func3, a : " << a << ", b : " << b << endl;
    int res_func3 = func3(9);
    cout << "after  call func3, a : " << a << ", b : " << b << ", result : " << res_func3 << endl;

    int d = 0;

    auto func4 = [&d]() {
            d++;
        };

    while (d < 10) {
        cout << "inside while, d : " << d << endl;
        func4();
    }
    cout << "outside while d : " << d << endl;

    // 访问或修改定义在当前文件中的全局变量（outside_global_var），无需指定任何捕获。
    auto func5 = []() -> void {
            outside_global_var += 10;
        };

    cout << "before call func5, outside_global_var : " << outside_global_var << endl;
    func5();
    cout << "after  call func5, outside_global_var : " << outside_global_var << endl;

    static int static_in_main_var = 88;

    // 访问或修改当前作用域中的静态变量（static_in_main_var），无需指定任何捕获。
    auto func6 = []() {
            static_in_main_var += 10;
        };

    cout << "before call func6, static_in_main_var : " << static_in_main_var << endl;
    func6();
    cout << "after  call func6, static_in_main_var : " << static_in_main_var << endl;

    /*
     Lambda 函数是一个依赖于实现的函数对象类型,这个类型的名字只有编译器知道。
     如果用户想把 lambda 函数做为一个参数来传递, 那么形参的类型必须是模板类型
     或者必须能创建一个 std::function 类似的对象去捕获 lambda 函数。
     使用 auto 关键字可以帮助存储 lambda 函数。
     */
    // 一个没有指定任何捕获的 lambda 函数, 可以显式转换成一个具有相同声明形式函数指针
    auto func7 = [](int x, int y) -> int {
            cout << "lambda body of func7" << endl;
            return x + y;
        };

    int (*func_pointer)(int, int);
    func_pointer = func7;

    // 一个没有指定任何捕获的 lambda 函数, 可以被std::function类型的对象捕获
    std::function<int(int, int)> func_var = func7;

    int r1_func7 = func7(5, 6);
    int r2_func7 = func_pointer(5, 6);
    int r3_func7 = func_var(5, 6);

    cout << "r1_func7 : " << r1_func7 << endl;
    cout << "r2_func7 : " << r2_func7 << endl;
    cout << "r3_func7 : " << r3_func7 << endl;

    int age = 29;
    // 加上 mutable 修饰符之后，可以修改传递进来的局部变量的拷贝（注意是能修改拷贝，原局部变量的值不变）
    auto add_age = [age](int x) mutable -> int {
            age += x;
            return age;
        };

    cout << "before call lambda add_age, age : " << age << endl;
    int new_age = add_age(9);
    cout << "after  call lambda add_age, age : " << age << ", new_age : " << new_age << endl;
}

void printByteInfo()
{
    cout << "type : " << "************size**************" << endl;
    cout << "bool : " << "byte count : " << sizeof(bool) << " byts" << endl;
    cout << "\t\t max : " << numeric_limits<bool>::max() << endl;
    cout << "\t\t min : " << numeric_limits<bool>::min() << endl;
    cout << endl;

    cout << "char : " << "byte count : " << sizeof(char) << " byts" << endl;
    cout << "\t\t max : " << numeric_limits<char>::max() << endl;
    cout << "\t\t min : " << numeric_limits<char>::min() << endl;
    cout << endl;

    cout << "signed char : " << "byte count : " << sizeof(signed char) << " byts" << endl;
    cout << "\t\t max : " << numeric_limits<signed char>::max() << endl;
    cout << "\t\t min : " << numeric_limits<signed char>::min() << endl;
    cout << endl;

    cout << "unsigned char : " << "byte count : " << sizeof(unsigned char) << " byts" << endl;
    cout << "\t\t max : " << numeric_limits<unsigned char>::max() << endl;
    cout << "\t\t min : " << numeric_limits<unsigned char>::min() << endl;
    cout << endl;

    cout << "short int : " << "byte count : " << sizeof(short int) << " byts" << endl;
    cout << "\t\t max : " << numeric_limits<short int>::max() << endl;
    cout << "\t\t min : " << numeric_limits<short int>::min() << endl;
    cout << endl;

    cout << "short unsigned int : " << "byte count : " << sizeof(short unsigned int) << " byts" << endl;
    cout << "\t\t max : " << numeric_limits<short unsigned int>::max() << endl;
    cout << "\t\t min : " << numeric_limits<short unsigned int>::min() << endl;
    cout << endl;

    cout << "short signed int : " << "byte count : " << sizeof(short signed int) << " byts" << endl;
    cout << "\t\t max : " << numeric_limits<short signed int>::max() << endl;
    cout << "\t\t min : " << numeric_limits<short signed int>::min() << endl;
    cout << endl;

    cout << "int : " << "byte count : " << sizeof(int) << " byts" << endl;
    cout << "\t\t max : " << numeric_limits<int>::max() << endl;
    cout << "\t\t min : " << numeric_limits<int>::min() << endl;
    cout << endl;

    cout << "signed int : " << "byte count : " << sizeof(signed int) << " byts" << endl;
    cout << "\t\t max : " << numeric_limits<signed int>::max() << endl;
    cout << "\t\t min : " << numeric_limits<signed int>::min() << endl;
    cout << endl;

    cout << "unsigned int : " << "byte count : " << sizeof(unsigned int) << " byts" << endl;
    cout << "\t\t max : " << numeric_limits<unsigned int>::max() << endl;
    cout << "\t\t min : " << numeric_limits<unsigned int>::min() << endl;
    cout << endl;

    cout << "long int : " << "byte count : " << sizeof(long int) << " byts" << endl;
    cout << "\t\t max : " << numeric_limits<long int>::max() << endl;
    cout << "\t\t min : " << numeric_limits<long int>::min() << endl;
    cout << endl;

    cout << "signed long int : " << "byte count : " << sizeof(signed long int) << " byts" << endl;
    cout << "\t\t max : " << numeric_limits<signed long int>::max() << endl;
    cout << "\t\t min : " << numeric_limits<signed long int>::min() << endl;
    cout << endl;

    cout << "unsigned long int : " << "byte count : " << sizeof(unsigned long int) << " byts" << endl;
    cout << "\t\t max : " << numeric_limits<unsigned long int>::max() << endl;
    cout << "\t\t min : " << numeric_limits<unsigned long int>::min() << endl;
    cout << endl;

    cout << "float : " << "byte count : " << sizeof(float) << " byts" << endl;
    cout << "\t\t max : " << numeric_limits<float>::max() << endl;
    cout << "\t\t min : " << numeric_limits<float>::min() << endl;
    cout << endl;

    cout << "double : " << "byte count : " << sizeof(double) << " byts" << endl;
    cout << "\t\t max : " << numeric_limits<double>::max() << endl;
    cout << "\t\t min : " << numeric_limits<double>::min() << endl;
    cout << endl;

    cout << "long double : " << "byte count : " << sizeof(long double) << " byts" << endl;
    cout << "\t\t max : " << numeric_limits<long double>::max() << endl;
    cout << "\t\t min : " << numeric_limits<long double>::min() << endl;
    cout << endl;

    cout << "long : " << "byte count : " << sizeof(long) << " byts" << endl;
    cout << "\t\t max : " << numeric_limits<long>::max() << endl;
    cout << "\t\t min : " << numeric_limits<long>::min() << endl;
    cout << endl;

    cout << "signed long : " << "byte count : " << sizeof(signed long) << " byts" << endl;
    cout << "\t\t max : " << numeric_limits<signed long>::max() << endl;
    cout << "\t\t min : " << numeric_limits<signed long>::min() << endl;
    cout << endl;

    cout << "unsigned long : " << "byte count : " << sizeof(unsigned long) << " byts" << endl;
    cout << "\t\t max : " << numeric_limits<unsigned long>::max() << endl;
    cout << "\t\t min : " << numeric_limits<unsigned long>::min() << endl;
    cout << endl;
}

void print_student(struct Student *s)
{
// void print_student(Student *s) { // 不写struct也行
    cout << " name : " << s->name;
    cout << " address : " << s->address;
    cout << " age : " << s->age;
    cout << endl;
}
