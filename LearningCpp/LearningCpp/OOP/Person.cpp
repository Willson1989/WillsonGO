//
//  OOP.cpp
//  StudyCpp
//
//  Created by fn-273 on 2020/10/7.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#include "Person.hpp"

using namespace std;

string Person::format_name(string addon)
{
    return this->name + addon;
}

void Person::set_name(string n)
{
    this->name = n;
}

void Person::set_age(int a) {
    age = a;
}

void Person::set_address(string addr) {
    address = addr;
}
