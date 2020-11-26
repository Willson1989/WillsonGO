//
//  SizeOfDemoClass.hpp
//  LearningCpp
//
//  Created by fn-273 on 2020/11/16.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#ifndef SizeOfDemoClass_hpp
#define SizeOfDemoClass_hpp

#include <stdio.h>
#include <iostream>

using namespace std;

#pragma pack(push) // 保存系统默认的对齐方式
#pragma pack(2) // 设置自己的对齐方式
struct AStruct {
    int a;
    char b;
    double c;
};
#pragma pack(pop) // 声明完之后恢复系统的对齐方式


class SizeOfDemoClass {
public:
    struct InsideClass1 {
        int sub_1_v1; // 4 bytes
        int sub_1_v2; // 4 bytes
    };

    struct InsideClass2 {
        char *sub_2_v1;
        int sub_2_v2; // 4 bytes
    };

    typedef int ValueType;

    static const int static_val_1 = 111;

    char v1;
    char v2;

    void func1()
    {
        int a = 1 + 2;
        cout << "res of 1 + 2 : " << a << endl;
    }

    void func2()
    {
        cout << "func2 " << endl;
    }
};

#endif /* SizeOfDemoClass_hpp */
