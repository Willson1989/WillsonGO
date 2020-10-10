//
//  OOP.hpp
//  StudyCpp
//
//  Created by fn-273 on 2020/10/7.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#ifndef OOP_hpp
#define OOP_hpp

#include <stdio.h>
#include <iostream>
#include <string>

using namespace std;

class Person {
public:
    string format_name(string addon);
    void set_name(string name);
    void set_age(int a);
    void set_address(string addr);
    
protected:
    string name;
    int age;
    string address;
    
private:
    int wealth_level;
};

#endif /* OOP_hpp */

