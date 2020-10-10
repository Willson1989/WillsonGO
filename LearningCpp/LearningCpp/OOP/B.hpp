//
//  B.hpp
//  StudyCpp
//
//  Created by fn-273 on 2020/10/9.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#ifndef B_hpp
#define B_hpp

#include <stdio.h>
#include <iostream>
#include "Base.hpp"

#endif /* B_hpp */

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
//        cout << a3 << endl; // 错误， a3 是 基类 Base 的 private 成员
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
//        cout << a3 << endl; // 错误， a3 是 基类 Base 的 private 成员
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
//        cout << a3 << endl; // 错误， a3 是 基类 Base 的 private 成员
        cout << endl;
    }
};
    
    
class D: Base { // 默认是 private 继承
public:
    void desc()
    {
        cout << "class D private extends from A" << endl;
        cout << a  << endl; // 正确， a  是 基类 Base 的 public 成员
        cout << a1 << endl; // 正确， a1 是 基类 Base 的 public 成员
        cout << a2 << endl; // 正确， a2 是 基类 Base 的 protected 成员
//        cout << a3 << endl; // 错误， a3 是 基类 Base 的 private 成员
        cout << endl;
    }
};
