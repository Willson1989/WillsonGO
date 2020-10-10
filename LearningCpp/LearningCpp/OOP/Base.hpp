//
//  A.hpp
//  StudyCpp
//
//  Created by fn-273 on 2020/10/9.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#ifndef Base_hpp
#define Base_hpp

#include <stdio.h>
#include <iostream>

using namespace std;

class Base {
public:
    int a;
    Base() {
        a = 0;
        a1 = 1;
        a2 = 2;
        a3 = 3;
    }

    void desc()
    {
        cout << "class A base class" << endl;
        cout << a  << endl;
        cout << a1 << endl;
        cout << a2 << endl;
        cout << a3 << endl;
    }

public:
    int a1;
protected:
    int a2;
private:
    int a3;
};

#endif /* Base_hpp */
