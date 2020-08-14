//
//  main.swift
//  Play-with-Alorithms
//
//  Created by WillHelen on 2018/8/17.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

import Foundation

var aa: [[Character]] =
//    [
//        ["X","X","O","X","X","X","X","X","X","X",],
//        ["X","O","X","O","X","X","X","X","X","X",],
//        ["X","O","O","O","X","X","X","X","X","X",],
//        ["X","X","X","X","O","O","O","O","X","X",],
//        ["X","X","X","X","O","X","O","X","X","X",],
//        ["X","X","X","X","O","O","O","X","X","X",],
//        ["X","X","X","O","O","X","O","X","O","O",],
//        ["X","X","O","O","O","X","X","X","O","X",],
//        ["X","O","O","O","O","X","X","X","O","X",],
//        ["X","X","X","O","O","X","X","X","O","X",],
//        ["X","X","X","X","X","X","O","O","O","X",],
//        ["X","X","X","X","X","X","X","X","O","X",],
//        ["X","X","X","X","X","X","X","X","O","X",],
//        ["X","X","X","X","O","O","X","X","X","X",],
//        ["X","X","X","X","X","O","X","X","X","X",],
//    ]
[]
//[
//    ["X","X","X","X","X","X","X","X","X","X",],
//    ["X","O","X","O","X","O","O","X","X","X",],
//]
//[
//    ["X","X","X","X"],
//    ["X","O","O","X"],
//    ["X","X","O","X"],
//    ["X","O","X","X"],
//]

let s = Solution_05()

s.solve_2(&aa)

for a in aa {
    var p = ""
    for i in 0 ..< a.count {
        if i == a.count - 1 {
            p += "\(a[i])"
        } else {
            p += "\(a[i]),"
        }
    }
    print(p)
}

// let s = Solutio_01()
// let res = s.isBracketsBalances_reviwe_0814("[)]")
// print("res : ",res)

// let c = Solution_05.LRUCache(2)
// c.put(2,1);
// c.put(1,1);
// c.put(2,3);
// c.put(4,1);
// print("r1 : \(c.get(1))");
// print("r2 : \(c.get(2))");

// let n0 = Solution_05.Node(0)
// let n1 = Solution_05.Node(1)
// let n2 = Solution_05.Node(2)
// let n3 = Solution_05.Node(3)
// let n4 = Solution_05.Node(4)
// let n5 = Solution_05.Node(5)
//
// n0.neighbors = [n1,n2,n3,n5]
// n1.neighbors = [n0,n2]
// n2.neighbors = [n0,n1,n3,n4]
// n3.neighbors = [n0,n2]
// n4.neighbors = [n2,n5]
// n5.neighbors = [n0,n4]
//
// let s = Solution_05()
// if let newNode = s.cloneGraph_dfs(n0) {
//    let nodes = newNode.showGraphNodes()
//    for n in nodes {
//        print("\(n.toString())")
//    }
// }
