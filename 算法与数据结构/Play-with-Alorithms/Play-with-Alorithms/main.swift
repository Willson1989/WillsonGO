//
//  main.swift
//  Play-with-Alorithms
//
//  Created by WillHelen on 2018/8/17.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

import Foundation

func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    
    var res = [Int]()
    let count = min(nums1.count, nums2.count)
    let arr = nums1.count > nums2.count ? nums2 : nums1
    for i in 0 ..< count {
        let n = arr[i]
        if nums1.contains(n) && nums2.contains(n) && !res.contains(n){
            res.append(n)
        }
    }
    return res
}

func intersection_1(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    return Array(Set<Int>(nums1).intersection(Set<Int>(nums2)))
}

let s = Solution()

let input = [2,1]
print("containsNearbyDuplicate : ",s.containsNearbyAlmostDuplicate(input, 1,1))


let island : [[Character]] =
    [
        []
]
//[
// ["1","1","1","1","0","1","1","1"],
// ["1","1","1","1","0","1","1","1"],
// ["1","1","0","0","0","0","0","0"],
// ["1","1","0","1","1","0","1","1"],
// ["1","1","0","1","1","0","0","1"],
// ["1","1","0","1","1","0","0","1"],
//]

//let ininin = ["10", "6", "9", "3", "+", "-11", "*", "/", "*", "17", "+", "5", "+"]
//let ininin = ["4", "13", "5", "/", "+"]
//let ininin = ["2", "1", "+", "3", "*"]

typealias TNode = TreeNode<Int>

let n1 = TNode(1)
let n2 = TNode(2)
let n3 = TNode(3)
let n4 = TNode(4)
let n5 = TNode(5)
let n6 = TNode(6)
let n7 = TNode(7)
let n8 = TNode(8)

n1.left = n2
n1.right = n3
n2.left = n4
n2.right = n5
n5.left = n8
n3.left = n6
n3.right = n7

print("inorderTraversal   : ",s.inorderTraversal(n1))
print("postorderTraversal : ",s.postorderTraversal(n1))
print("preorderTraversal  : ",s.preorderTraversal(n1))


