//
//  Student.hpp
//  StudyCpp
//
//  Created by fn-273 on 2020/10/9.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#ifndef Student_hpp
#define Student_hpp

#include <stdio.h>
#include "MyUtils.hpp"
#include "Person.hpp"

using namespace std;

class Student: Person {
public:

    int get_score();
    void set_score(int s);
    void set_address(string addr);
    string stu_desc();

    Student(string name, int age, int class_num, int grade_num, string address) {
        this->name = name;
        this->age = age;
        this->address = address;
        this->class_num = class_num;
        this->grade_num = grade_num;
    }

protected:
    int grade_num;
    int class_num;

private:
    int score;
};

#endif /* Student_hpp */
