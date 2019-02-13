//
//  main.swift
//  Play-with-Alorithms
//
//  Created by 朱金倩 on 2018/8/17.
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

let input = [[1,1],[3,2],[5,3],[4,1],[2,3],[1,4]]
let p1 = [1,1]
let p2 = [3,2]
let p3 = [5,3]
let p4 = [5,3]
let p5 = [4,1]
let p6 = [1,4]

let keys = [p1,p2,p3,p4,p5,p6]

var map = [[Int] : String]()
for p in keys {
    map[p] = "[\(p[0]), \(p[1])]"
}
var pkey = [5,3]
pkey[0] = 1
pkey[1] = 1
print("maxPoints : ",s.maxPoints(input))


