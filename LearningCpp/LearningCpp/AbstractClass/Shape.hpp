//
//  Shape.hpp
//  LearningCpp
//
//  Created by fn-273 on 2020/10/27.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#ifndef Shape_hpp
#define Shape_hpp

#include <stdio.h>
#include <string>

using namespace std;

class Shape {
public:

    // = 0 是为了告诉编译器，这个函数是纯虚函数，没有具体实现细节，
    // 具体的实现细节交给继承它的子类来实现。
    // 如果一个类中存在至少一个纯虚函数，那么这个类就是一个抽象类
    virtual double area() = 0;
    virtual string getColor() = 0;

    void setWidth(double w)
    {
        width = w;
    }

    void setHeight(double h)
    {
        height = h;
    }

    void setColor(string c)
    {
        color =  c;
    }

protected:
    double width;
    double height;
    string color;
};

#endif /* Shape_hpp */
