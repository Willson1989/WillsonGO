//
//  Hawk.hpp
//  LearningCpp
//
//  Created by fn-273 on 2020/10/27.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#ifndef Hawk_hpp
#define Hawk_hpp

#include <stdio.h>
#include "Animal.hpp"

class Hawk: public Animal {
public:
    Hawk(string name);
    void sleep();
    void run();
    void hunt();
    void fly();
};

#endif /* Hawk_hpp */
