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

let ss = "   1"

print(s.lengthOfLastWord("   a"))
print(s.lengthOfLastWord("a"))
print(s.lengthOfLastWord("a   "))
print(s.lengthOfLastWord("ddd da  dddcc   "))
print(s.lengthOfLastWord("    "))
print(s.lengthOfLastWord(" "))
print(s.lengthOfLastWord("asdasda"))
print(s.lengthOfLastWord("asdasd "))
print(s.lengthOfLastWord("   aaasdasd"))

