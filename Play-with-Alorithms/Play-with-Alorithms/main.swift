//
//  main.swift
//  Play-with-Alorithms
//
//  Created by WillHelen on 2018/8/17.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

import Foundation

let s = Solution_05()


let c = 6
//let a = [[1,0], [0,5], [1,5], [5,4], [4,3], [4,2], [1,2]]
let a = [[1,0],[0,1]]

let canFinish = s.canFinish(c, a)
let canFinish_1 = s.canFinish_dfs(c, a)

print("canFinish : ", canFinish)
print("canFinish_1 : ", canFinish)

//let g = TopoLogicalSorting.Graph(capacity: 6)
//g.addEdge(from: 0, to: 5)
//g.addEdge(from: 0, to: 1)
//g.addEdge(from: 1, to: 5)
//g.addEdge(from: 5, to: 2)
//g.addEdge(from: 5, to: 4)
//g.addEdge(from: 4, to: 3)
//g.addEdge(from: 4, to: 2)
//g.addEdge(from: 3, to: 5)
//
//let toposortres = g.topologicalSort()
//
//print("toposortres : ", toposortres)


//let s = Solution_05()
//
//let a = [-2,-2,1,1,-3,1,-3,-3,-4,-2]
//
//let res = s.singleNumber_2(a)
//
//print("res : ", res)

// var aa: [[Character]] =
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
// []
// [
//    ["X","X","X","X","X","X","X","X","X","X",],
//    ["X","O","X","O","X","O","O","X","X","X",],
// ]
// [
//    ["X","X","X","X"],
//    ["X","O","O","X"],
//    ["X","X","O","X"],
//    ["X","O","X","X"],
// ]
//
// let s = Solution_05()
//
// s.solve_2(&aa)
//
// for a in aa {
//    var p = ""
//    for i in 0 ..< a.count {
//        if i == a.count - 1 {
//            p += "\(a[i])"
//        } else {
//            p += "\(a[i]),"
//        }
//    }
//    print(p)
// }

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
