//
//  Tiger.cpp
//  LearningCpp
//
//  Created by fn-273 on 2020/10/27.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#include "Tiger.hpp"

Tiger::Tiger(string name) : Animal(name)
{
}

void Tiger::run()
{
    cout << "Tiger - " << name << " run" << endl;
}

void Tiger::hunt()
{
    cout << "Tiger - " << name << " hunt" << endl;
}

void Tiger::fly()
{
    cout << "Tiger - " << name << " cannot fly" << endl;
}

void Tiger::sleep()
{
    cout << "Tiger - " << name << " sleep" << endl;
}


