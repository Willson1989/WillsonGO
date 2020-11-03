//
//  Rectangle.hpp
//  LearningCpp
//
//  Created by fn-273 on 2020/10/27.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#ifndef Rectangle_hpp
#define Rectangle_hpp

#include <stdio.h>
#include "Shape.hpp"

using namespace std;

class Rectangle: public Shape {
public:
    Rectangle(double w, double h, string c);
    double area();
    string getColor();
};

#endif /* Rectangle_hpp */
