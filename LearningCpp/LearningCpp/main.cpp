//
//  main.cpp
//  StudyCpp
//
//  Created by fn-273 on 2020/9/25.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#include <iostream>
#include "Functions.hpp"
#include "string_num_transform_study.hpp"
#include "Person.hpp"
#include "Student.hpp"
#include "Employee.hpp"
#include "Base.hpp"
#include "B.hpp"
#include "Param.hpp"

using namespace std;

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
    Param p_13 = {5,6};
    cout << p_13 << endl; // 调用了友元的 输出重载函数
    p_13<<cout; // 调用了成员函数的输出重载函数， 这种调用方式看起来不自然

//    // https://www.cnblogs.com/wxl2578/p/3388767.html
//
//    cout << "========= phase 1 ==========" << endl;
//    Employee e = Employee("willson", "0127", "7345", 19);
//
//    cout << "========= phase 2 ==========" << endl;
//    Employee e1("wn", "012711", "5", 12);
//
//    cout << "========= phase 3 ==========" << endl;
//    // 调用了拷贝构造函数
//    Employee e2 = e1;
//
//    cout << "========= phase 4 ==========" << endl;
//    // 调用了有参数的构造函数
//    Employee e3("wn1", "012711", "5", 12);
//    // 调用了拷贝赋值函数
//    e3 = e1;
//
//    cout << "========= phase 5 ==========" << endl;
//    // 调用了有参数的构造函数
//    Employee e4 = { "e4", "1111", "99", 23 };
//
//    cout << "========= phase 6 ==========" << endl;
//    // 调用了无参构造函数
//    Employee e6;
//    // 调用了拷贝赋值函数
//    e6 = e1;
//
//    cout << "========= phase 7 ==========" << endl;
//    FriendEmployee fe(e1, "Special emp");
//    fe.desc();
//
//    cout << "========= phase 8 ==========" << endl;
//    Employee e7 = Employee();
//    Employee *ptr_e7 = &e7;
//    ptr_e7->set_name("will");
//    ptr_e7->set_age(10);
//    ptr_e7->set_address("Shenyang");
//    desc_employee_info(*ptr_e7);

//    Student stu = Student("willson", 31, 1, 3, "Beijing");
//    string stu_desc = stu.stu_desc();
//    cout << "student desc : " << endl << stu_desc;
//    string_num_transform_study();
//    struct_study();
//    time_study();
//    pointer_study();
//    string_study();
//    pointer_and_refrence_study();
//    print_types_name();
//    char_pointer_string_transform();
//    auto_study();
//    float temp = 20.0;
//    float& a = temp;
//    cout << "before a : " << a << endl;
//    float res = change_val(a);
//    cout << "after  a : " << a << endl;
//
//    float fa = 99.0f;
//    cout << "before float point : " << &fa << ", val : " << fa << endl;
//    float * res_fa = change_point(&fa);
//    float new_fa = *res_fa;
//    cout << "after  float point : " << &fa << ", val : " << fa << endl;
//    cout << "after  new   point : " << res_fa << ", val : " << new_fa << endl;
    return 0;
}

int global_var_1;

extern void say();

extern string say(string);

void tempFunc_1()
{
    global_var_1 = 10;
    cout << "tempFunc_1 , global_var_1 : " << global_var_1 << endl;
}

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

int my_sum(int a, int b = 10)
{
    return a + b;
}

void my_swap(int *a, int *b)
{
    *a = *a ^ *b;
    *b = *a ^ *b;
    *a = *a ^ *b;
    cout << "a : " << *a << ", b : " << *b << endl;
}

int outside_main_var = 199;

float change_val(float & num)
{
    num = 100;
    return num;
}

float * change_point(float *num)
{
    float new_num = 13.0;
    float *new_point = &new_num;
    num = new_point;
    return new_point;
}
