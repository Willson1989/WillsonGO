//
//  Hawk.cpp
//  LearningCpp
//
//  Created by fn-273 on 2020/10/27.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#include "Hawk.hpp"

Hawk::Hawk(string name) : Animal(name)
{
}

void Hawk::run()
{
    cout << "Hawk - " << name << " run" << endl;
}

void Hawk::hunt()
{
    cout << "Hawk - " << name << " hunt" << endl;
}

void Hawk::fly()
{
    cout << "Hawk - " << name << " cannot fly" << endl;
}

void Hawk::sleep()
{
    cout << "Hawk - " << name << " sleep" << endl;
}
