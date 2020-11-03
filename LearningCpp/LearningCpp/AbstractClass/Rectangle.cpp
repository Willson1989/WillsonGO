//
//  Rectangle.cpp
//  LearningCpp
//
//  Created by fn-273 on 2020/10/27.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#include "Rectangle.hpp"
#include <iostream>

Rectangle::Rectangle(double w, double h, string c)
{
    setWidth(w);
    setHeight(h);
    setColor(c);
}

double Rectangle::area()
{
    cout << "function area of Rectangle" << endl;
    return width * height;
}

string Rectangle::getColor()
{
    cout << "function getColor of Rectangle" << endl;
    return (color.empty() ? "empty color" : color);
}
