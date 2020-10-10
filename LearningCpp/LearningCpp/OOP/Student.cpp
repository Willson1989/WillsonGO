//
//  Student.cpp
//  StudyCpp
//
//  Created by fn-273 on 2020/10/9.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#include "Student.hpp"
#include <sstream>

void Student::set_score(int s)
{
    score = s;
}

int Student::get_score()
{
    return score;
}

void Student::set_address(string addr)
{
    address = addr;
}

string Student::stu_desc()
{
    stringstream s("");
    s << "student name : " << name;
    s << ", age : " << age;
    s << ", class : " << class_num << " - " << grade_num;
    s << ", address : " << address;
    s << endl;
    return s.str();
}

