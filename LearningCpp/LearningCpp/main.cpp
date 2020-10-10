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

using namespace std;

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

    cout << "========= phase 7 ==========" << endl;
    FriendEmployee fe(e1, "Special emp");
    fe.desc();
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