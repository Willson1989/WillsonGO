//
//  SolutionUtils.c
//  Play-with-Alorithms
//
//  Created by fn-273 on 2020/9/17.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#include "SolutionUtils.h"

int binary_num_leading_zeros(int x)
{
    return __builtin_clz(x);
}

int binary_num_tailing_zeros(int x)
{
    return __builtin_ctz(x);
}
