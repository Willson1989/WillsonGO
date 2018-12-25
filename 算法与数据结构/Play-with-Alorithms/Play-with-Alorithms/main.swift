//
//  main.swift
//  Play-with-Alorithms
//
//  Created by 朱金倩 on 2018/8/17.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

import Foundation


public extension Character {
    public func ASCII() -> Int {
        var num = 0
        for scalar in String(self).unicodeScalars {
            num = Int(scalar.value)
        }
        return num
    }
}

let s = Solution()

print(s.constructRectangle(1))
print(s.constructRectangle(2))
print(s.constructRectangle(3))
print(s.constructRectangle(4))
print(s.constructRectangle(18))
print(s.constructRectangle(21))
print(s.constructRectangle(12))
print(s.constructRectangle(44))
print(s.constructRectangle(150))

