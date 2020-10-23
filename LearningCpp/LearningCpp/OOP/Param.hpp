//
//  Param.hpp
//  LearningCpp
//
//  Created by fn-273 on 2020/10/14.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#ifndef Param_hpp
#define Param_hpp

#include <stdio.h>
#include <string>
#include <iostream>

using namespace std;

class Param {
public:

    double val1;
    double val2;

    Param();

    Param(double val1, double val2);

    Param(const Param & p);

    void desc(std::string other);

    Param operator - ();

    // 重载递增前缀运算符  ++p
    Param operator++ ();

    // 重载自增后缀运算符 p++
    Param operator++ (int);

    Param operator-- ();

    Param operator-- (int);

    Param operator + (const Param  & other); // 用于 obj1 + obj2
    Param operator + (int num); // 用于 obj + num
    friend Param operator + (int n, Param obj); // 用于 num + obj

    Param operator - (const Param  & other);

    Param operator *(const Param  & other);

    Param operator / (const Param  & other);

    // 关系运算符 大于 小于
    bool operator < (const Param & other);
    bool operator > (double n);
    friend bool operator > (double n, const Param & p); // 用于 n > p

    // 输入输出运算符
    friend ostream &operator << (ostream & o, const Param & p);

    friend istream &operator >> (istream & i, Param & p);

    // 赋值运算符重载
    void operator = (const Param & other);

    //函数调用运算符 () 重载
};

#endif /* Param_hpp */
