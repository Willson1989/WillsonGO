//
//  main.swift
//  Play-with-Alorithms
//
//  Created by 朱金倩 on 2018/8/17.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

import Foundation

let zys = Solution()
var aa = [1,2,6,3,4,5,6]
let list = NodeList(values: aa)

let matrix = zys.generateMatrix(2)
for a in matrix {
    for i in a {
        print(i, separator: "", terminator: ", ")
    }
    print()
}



protocol Flyable {
    func goFly()
}

extension Flyable {
    func goFly() {
        if let o = self as? Bird {
            print("\(o.name) is flying")
        } else {
            print("somthing is flying")
        }
    }
}

protocol Bird {
    var name : String { get }
    var canFly : Bool { get }
}

extension Bird {
    var canFly : Bool {
        return self is Flyable
    }
}

struct Penguin : Bird {
    var name : String = "Penguin"
}

struct Eagle : Bird, Flyable{
    var name : String = "Eagle"
}

struct ButterFly : Flyable {
    var name : String = "ButterFly"
}

//let p = Penguin()
//let e = Eagle()
//print("Penguin p can fly : \(p.canFly)")
//e.goFly()
//let b = ButterFly()
//b.goFly()



