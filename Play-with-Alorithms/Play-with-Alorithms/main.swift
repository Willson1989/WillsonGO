//
//  main.swift
//  Play-with-Alorithms
//
//  Created by WillHelen on 2018/8/17.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

import Foundation

let s = Solution_04()

// var aaa  = [1,3,6,5,4,2]
// var aaa  = [1,4,6,3,2,5]
// var aaa  = [1,6,3,2,5,4]
// var aaa = [6, 5, 4, 3, 2, 1]
// var aaa = [1,2,3,4,5,6]
// var aaa = [1,1,1,1,1,1,2,2,2,2,3]
// var aaa : [Int] = [1,1,2,2]
// var aaa : [Int] = [2,1,3]

var aaa = [1,2,3,1,1,1,1,1]
//var aaa = [4,6,7,7]
//var aaa = [1,2,3,4,5]

print("origin arr : \(aaa)")
let res = s.findSubsequences(aaa)
let res1 = s.findSubsequences_1(aaa)
print("result  : \(res)")
print(" ")
print("result1 : \(res1)")

// let n1 = ListNode(1)
// let n2 = ListNode(2)
// let n3 = ListNode(3)
// let n4 = ListNode(4)
// let n5 = ListNode(5)
// let n6 = ListNode(6)
// n1.next = n2
// n2.next = n3
// n3.next = n4
// n4.next = n5
// n5.next = n6
// var n: ListNode? = n1
// print("origin list : ")
// while n != nil {
//    print("\(n!.val)", separator: "", terminator: " -> ")
//    n = n?.next
// }
// print(" ")
//
// let head = s.removeNthFromEnd(n1, 0)
// print("res list : ")
// n = head
//
// while n != nil {
//    print("\(n!.val)", separator: "", terminator: " -> ")
//    n = n?.next
// }
//
// print(" ")

////let aa = [1, 10, 6, 2, 5, 4, 10, 3, 7]
// let aa = [1, 10, 6, 31, 5, 31, 10, 3, 7]
//
// let res = s.maxArea(aa)
//
// print("maxArea : \(res)")

// let aa : [Int] = [197, 130, 1]
// let aa : [Int] = [235, 140, 4]
// let aa : [Int] = [0b11100000, 0b10111101,0b10101001, 0b01110101, 0b01000101]
//// let aa: [Int] = [0b01110101, 0b01000101]
// let aa: [Int] = [255]
// print("input arr : ")
// for i in 0 ..< aa.count {
//    print(String(aa[i], radix: 2), separator: " ", terminator: " ")
// }
//
// print("")
// let validRes = s.validUtf8(aa)
// let validRes_state = s.validUtf8_state(aa)
//
// print("valid result1 : \(validRes)")nn
// print("valid result2 : \(validRes_state)")

////let ss = "- 123  456- 78"
////let ss = "-91283472332"
////let ss = "  0000000000012345678"
////let ss = "   +010123"
////let ss = "20000000000000000000"
////let ss = "4193 with words"
////let ss = "200"
////let ss = "  -0012a42"
////let ss = "   +0 123"
// let ss = "2147483648"
////let ss = "-   234"
//
//
// let res = s.myAtoi(ss)
// print("origin : \"\(ss)\"")
// print("res :\(res)")

// let ss = "abcabdceabcd"
// let lengthOfLongestSubstring = s.lengthOfLongestSubstring(ss)
// print("lengthOfLongestSubstring : ", lengthOfLongestSubstring)

// let c = 6
////let a = [[1,0], [0,5], [1,5], [5,4], [4,3], [4,2], [1,2]]
// let a = [[1,0],[0,1]]
//
// let canFinish = s.canFinish(c, a)
// let canFinish_1 = s.canFinish_dfs(c, a)
//
// print("canFinish : ", canFinish)
// print("canFinish_1 : ", canFinish)

// let g = TopoLogicalSorting.Graph(capacity: 6)
// g.addEdge(from: 0, to: 5)
// g.addEdge(from: 0, to: 1)
// g.addEdge(from: 1, to: 5)
// g.addEdge(from: 5, to: 2)
// g.addEdge(from: 5, to: 4)
// g.addEdge(from: 4, to: 3)
// g.addEdge(from: 4, to: 2)
// g.addEdge(from: 3, to: 5)
//
// let toposortres = g.topologicalSort()
//
// print("toposortres : ", toposortres)

// let s = Solution_05()
//
// let a = [-2,-2,1,1,-3,1,-3,-3,-4,-2]
//
// let res = s.singleNumber_2(a)
//
// print("res : ", res)

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
