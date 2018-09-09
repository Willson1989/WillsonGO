//
//  main.swift
//  Play-with-Alorithms
//
//  Created by 朱金倩 on 2018/8/17.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

import Foundation

public extension Character {
    
    public func getASCII(_ c : Character) -> Int {
        var num = 0
        for scalar in String(c).unicodeScalars {
            num = Int(scalar.value)
        }
        return num
    }
    
    var letterIndex : Int {
        return getASCII(self) - getASCII("a")
    }
    
}

let zys = Solution()

let c1 : Character = "A"

print(c1.letterIndex)



let dic : [String : String] = ["name" : "will"]

let containAgeKey = dic.keys.contains(where: {$0 == "age"})




