//
//  Animal.hpp
//  LearningCpp
//
//  Created by fn-273 on 2020/10/27.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#ifndef Animal_hpp
#define Animal_hpp

#include <stdio.h>
#include <iostream>
#include <string>

using namespace std;

class Animal {
public:

    string name;

    Animal(string name);

    // void run();
    // void fly();
    // void sleep();
    // void hunt();

    // 将函数声明为 virtual(虚函数)，防止静态绑定的函数调用
    virtual void run();
    virtual void fly();
    virtual void sleep() = 0;
    
    // 纯虚函数，如果一个类中存在至少一个纯虚函数，那么这个类就是抽象类了，
    // 如果有其它类集成这个抽象类，就必须要实现这个纯虚函数
    virtual void hunt();
};

#endif /* Animal_hpp */
