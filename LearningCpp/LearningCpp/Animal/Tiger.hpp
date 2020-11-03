//
//  Tiger.hpp
//  LearningCpp
//
//  Created by fn-273 on 2020/10/27.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#ifndef Tiger_hpp
#define Tiger_hpp

#include <stdio.h>
#include "Animal.hpp"
#include <string>

class Tiger: public Animal {
public:
    Tiger(string name);
    void sleep();
    void run();
    void hunt();
    void fly();
};

#endif /* Tiger_hpp */
