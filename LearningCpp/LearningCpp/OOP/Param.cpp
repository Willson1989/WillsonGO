//
//  Param.cpp
//  LearningCpp
//
//  Created by fn-273 on 2020/10/14.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#include "Param.hpp"
#include <iostream>

using namespace std;

Param :: Param() {
    val1 = 1;
    val2 = 2;
}

#pragma mark - 一元运算符重载
Param :: Param(double a, double b) : val1(a), val2(b)
{
}

// 递增递减运算符 重载
// https://www.runoob.com/cplusplus/unary-operators-overloading.html
// 重载递增前缀运算符  a = ++b
Param Param :: operator ++()
{
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
    // 保存旧值
    Param old = Param(val1, val2);
    // 递增
    ++val1;
    ++val2;
    // 返回旧的原始值
    return old;
}

// 同理，前缀和后缀的递减运算符重载
Param Param::operator--()
{
    --val1;
    --val2;
    return Param(val1, val2);
}

Param Param::operator--(int)
{
    // 保存旧值
    Param old = { val1, val2 };
    // 递减
    --val1;
    --val2;
    // 返回旧的原始值
    return old;
}

#pragma mark - 二元运算符重载  + - * /
//https://www.runoob.com/cplusplus/binary-operators-overloading.html
// 用于实现对象之间相加 obj3 = obj1 + obj2
Param Param::operator+(const Param & other)
{
    Param newVal = Param(val1 + other.val1, val2 + other.val2);
    return newVal;
}

// 用于实现对象与数字之间相加 obj2 = obj1 + 10
// 但是 10 + obj1 这种调换了两者顺序的写法却不行，
// 可以通过友元函数来实现调换顺序的相加
Param Param::operator+(int n)
{
    Param newVal = Param(val1 + n, val2 + n);
    return newVal;
}

Param operator +(int n, Param p)
{
    return p + n; // 调用第二个重载方法
}

Param Param::operator-(const Param & other)
{
    Param newVal = Param(val1 - other.val1, val2 - other.val2);
    return newVal;
}

Param Param::operator*(const Param & other)
{
    Param newVal = Param(val1 * other.val1, val2 * other.val2);
    return newVal;
}

Param Param::operator/(const Param & other)
{
    Param newVal = Param(val1 / other.val1, val2 / other.val2);
    return newVal;
}

#pragma mark - 关系运算符重载
// https://www.runoob.com/cplusplus/relational-operators-overloading.html
bool Param::operator <(const Param & other)
{
    return val1 < other.val2 && val2 < other.val2;
}

bool Param::operator >(double n)
{
    return val1 > n && val2 > n;
}

bool operator >(double n, const Param & p)
{
    return (p.val1 < n) && (p.val2 < n);
}

void Param::desc(string other)
{
    cout << other << "val1 : " << val1 << ", val2 : " << val2 << endl;
}

#pragma mark - 输入/输出运算符重载

ostream & operator <<(ostream & output, const Param & p)
{
    output << "Instance of Param, val1 : " << p.val1 << ", and val2 : " << p.val2 << endl;
    return output;
}

istream & operator >>(istream & input, Param & p)
{
    input >> p.val1 >> p.val2;
    return input;
}
