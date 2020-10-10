//
//  Employee.cpp
//  StudyCpp
//
//  Created by fn-273 on 2020/10/10.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#include "Employee.hpp"

using namespace std;

Employee::Employee()
{
    cout << "constructor (no arguments) of class Employee" << endl;
}

//Employee::Employee(std::string nm, std::string id, std::string depart, int lvl)
//{
//    name = nm;
//    emp_user_id = id;
//    emp_depart_id = depart;
//    emp_level = lvl;
//}

/*
 使用参数列表初始化成员变量
 但是父类的成员变量不能写到参数列表中，只能在构函数的函数体中进行赋值初始化
 */
Employee::Employee(string nm, string id, string depart, int lvl) : emp_user_id(id), emp_depart_id(depart), emp_level(lvl)
{
    cout << "constructor (muti arguments) of class Employee" << endl;
    name = nm;
}

/*
 拷贝构造函数
 拷贝构造函数通过同一类型的对象初始化新创建的对象。
 类对象的赋值操作会自动触发拷贝构造函数:

 Employee e1("wn", "012711", "5", 12);
 Employee e2 = e1;

 但是对已经创建了的对象重新赋值不会调用拷贝构造函数，而是会调用拷贝赋值函数
 Employee e3("wn1", "012711", "5", 12);
 e3 = e1;

 如果不自己实现，编译器默认自动实现这个函数。
 */
Employee::Employee(const Employee & obj)
{
    cout << "invoked copy constructor of class Employee" << endl;
    name = obj.name + "_copy";
    emp_user_id = obj.emp_user_id + "_copy";
    emp_depart_id = obj.emp_depart_id + "_copy";
    set_age(obj.age);
}

// 析构函数，类的对象被释放时会被调用
Employee::~Employee(void)
{
    cout << "Employee instance is deallocated" << endl;
}

// 拷贝赋值函数
Employee& Employee::operator=(const Employee & obj)
{
    cout << "invoked copy operator of class Employee" << endl;
    name = obj.name + "_operator";
    emp_user_id = obj.emp_user_id + "_operator";
    emp_depart_id = obj.emp_depart_id + "_operator";
    set_age(obj.age);
    return *this;
}

int Employee::get_level()
{
    return emp_level;
}

string Employee::get_user_id()
{
    return emp_user_id;
}

string Employee::get_depart_id()
{
    return emp_depart_id;
}

// Employee 的友元函数
void desc_employee_info(const Employee & emp)
{
    cout << "Employee info : " << endl;
    cout << "name    : " << emp.name << endl;
    cout << "id      : " << emp.emp_user_id << endl;
    cout << "depart  : " << emp.emp_depart_id << endl;
    cout << "level   : " << emp.emp_level << endl;
    cout << endl;
}

// Employee 的友元类
FriendEmployee::FriendEmployee(const Employee &emp, string addonInfo)
{
    // 由于 emp 成员变量只是声明而没被初始化，所以在赋值之后会调用 Employee 的拷贝构造函数
    this->emp = emp;
    this->addonInfo = addonInfo;
}

void FriendEmployee::desc()
{
    /*
     FriendEmployee 是 Employee 的友元类，
     所以 emp_user_id 、emp_depart_id、emp_level 这些私有成员变量都可以访问。
     */
    cout << "FriendEmployee info : " << endl;
    cout << "name      : " << emp.name << endl;
    cout << "id        : " << emp.emp_user_id << endl;
    cout << "depart    : " << emp.emp_depart_id << endl;
    cout << "level     : " << emp.emp_level << endl;
    cout << "addonInfo : " << addonInfo << endl;
    cout << endl;
}
