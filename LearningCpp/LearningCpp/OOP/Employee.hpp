//
//  Employee.hpp
//  StudyCpp
//
//  Created by fn-273 on 2020/10/10.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#ifndef Employee_hpp
#define Employee_hpp

#include <stdio.h>
#include "Person.hpp"
#include <string>

class Employee: public Person {
public:
    /*
     友元类
     在友元类内部，可以访问当前类和父类中的所有成员变量和函数
    */
    friend class FriendEmployee;
    /*
     友元函数（虽然定义在类里面，但并不是类的成员函数）
     在友元函数内部，可以访问当前类和父类中的所有成员变量和函数
     */
    friend void desc_employee_info(const Employee & emp);

    Employee();

    Employee(std::string name,
             std::string id,
             std::string depart,
             int level = 1);

    // 拷贝构造函数
    Employee(const Employee & obj);

    // 拷贝赋值函数
    Employee& operator = (const Employee & obj);

    // 析构函数
    ~Employee(void);

    int get_level();
    std::string get_user_id();
    std::string get_depart_id();

private:
    std::string emp_user_id;
    std::string emp_depart_id;
    int emp_level;
};

// FriendEmployee 作为 Employee 的友元类，可以访问 Employee 包括私有的任何成员变量和函数，
class FriendEmployee {
public:
    FriendEmployee(const Employee & emp, string addonInfo);
    void desc();

private:
    Employee emp;
    std::string addonInfo;
};

#endif /* Employee_hpp */
