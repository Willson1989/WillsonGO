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

#pragma mark - SubParam
SubParam::SubParam(int val)
{
    this->val = val;
}

void SubParam::printInfo()
{
    cout << "SubParam, val : " << val << endl;
}

#pragma mark - Param
Param::Param()
{
    val1 = 1;
    val2 = 2;
    for (int i = 0; i < SIZE; i++) {
        arr[i] = i;
    }
}

Param::Param(double a, double b) : val1(a), val2(b)
{
}

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

#pragma mark - 一元运算符重载
// https://www.runoob.com/cplusplus/unary-operators-overloading.html
Param Param:: operator -()
{
    cout << "operator - overload(-obj)" << endl;
    Param p = { -val1, -val2 };
    return p;
}

#pragma mark - ++ 和 -- 运算符重载
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

// 同理，前缀和后缀的递减运算符重载
Param Param::operator--()
{
    cout << "operator -- (prefix)  overload(--obj)" << endl;
    --val1;
    --val2;
    return Param(val1, val2);
}

Param Param::operator--(int)
{
    cout << "operator -- (surfix)  overload(obj--)" << endl;
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

Param operator +(int n, Param p)
{
    cout << "operator + overload(n + obj), friend function " << endl;
    return p + n; // 调用第二个重载方法
}

Param Param::operator-(const Param & other)
{
    cout << "operator - overload(obj1 - obj2)" << endl;
    Param newVal = Param(val1 - other.val1, val2 - other.val2);
    return newVal;
}

Param Param::operator*(const Param & other)
{
    cout << "operator * overload(obj1 * obj2)" << endl;
    Param newVal = Param(val1 * other.val1, val2 * other.val2);
    return newVal;
}

Param Param::operator/(const Param & other)
{
    cout << "operator / overload(obj1 / obj2)" << endl;
    Param newVal = Param(val1 / other.val1, val2 / other.val2);
    return newVal;
}

#pragma mark - 关系运算符重载
// https://www.runoob.com/cplusplus/relational-operators-overloading.html
// obj1 < obj2
bool Param::operator <(const Param & other)
{
    cout << "operator < overload(obj1 < obj2)" << endl;
    return val1 < other.val2 && val2 < other.val2;
}

bool Param::operator <(double n)
{
    cout << "operator < overload(obj < n)" << endl;
    return (val1 < n) && (val2 < n);
}

// obj > n
bool Param::operator >(double n)
{
    cout << "operator > overload(obj > n)" << endl;
    return val1 > n && val2 > n;
}

// 友元函数实现  n > obj
bool operator >(double n, Param & p)
{
    cout << "operator > overload(n > obj), friend function " << endl;
    return p < n;
}

#pragma mark - 输入/输出运算符重载

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

#pragma mark - 赋值运算符重载
void Param::operator=(const Param & p)
{
    cout << "operator = overload " << endl;
    val1 = p.val1;
    val2 = p.val2;
}

#pragma mark - 函数调用运算符 () 重载
void Param::operator()(int a, int b, int c)
{
    cout << "operator () overload " << endl;
    val1 = a + b;
    val2 = a + c;
}

#pragma mark - 下标运算符重载
int Param::operator[](int index)
{
    cout << "operator [] overload " << endl;
    if (index < 0 || index >= SIZE) {
        return -1;
    }
    return arr[index];
}

#pragma mark - 类成员访问运算符 -> 重载
// https://www.runoob.com/cplusplus/class-member-access-operator-overloading.html
SubParam * Param::operator ->()
{
    cout << "operator -> overload " << endl;
    return subParam;
}

#pragma mark -

void Param::desc(string other)
{
    cout << other << "val1 : " << val1 << ", val2 : " << val2 << endl;
}
