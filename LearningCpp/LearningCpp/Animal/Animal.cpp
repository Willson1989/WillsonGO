//
//  Animal.cpp
//  LearningCpp
//
//  Created by fn-273 on 2020/10/27.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#include "Animal.hpp"

Animal::Animal(string name) : name(name)
{
}

void Animal::run()
{
    cout << "Base class Animal - " << name << ", run" << endl;
}

void Animal::fly()
{
    cout << "Base class Animal - " << name << ", fly" << endl;
}

void Animal::sleep()
{
    cout << "Base class Animal - " << name << ", sleep" << endl;
}

void Animal::hunt()
{
    cout << "Base class Animal - " << name << ", sleep" << endl;
}
