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



let inputStr = "kk2[ab2[cd3[e]]2[fg]]hij"
print("input str : ",inputStr)
print("decodeString   : ",s.decodeString(inputStr))
print("decodeString_1 : ",s.decodeString_1(inputStr))

let inputImage = [
    [1, 1, 1, 1],
    [1, 1, 1, 0],
    [1, 0, 0, 1],
    [1, 0, 1, 1]
]
print("input image : ")
for i in 0 ..< inputImage.count {
    print(inputImage[i])
}
print("")
let t = [0,0]
let c = 3
let newImage = s.floodFill(inputImage, t[0], t[1], c)
//let newImage = s.updateMatrix(inputImage)

print("new colored image : ")
for i in 0 ..< newImage.count {
    print(newImage[i])
}

let inputRooms = [[1],[2],[3],[]]
//let inputRooms = [[1,3],[3,0,1],[2],[0]]
//let inputRooms = [[2],[],[1]]

print("canVisitAllRooms : ",s.canVisitAllRooms(inputRooms))


func reBoolaa(_ left : Bool, _ right : @autoclosure () -> Bool) -> Bool {
    if left {
        return true
    } else {
        return right()
    }
}


func tempFunc() -> Bool {
    print("tempFunc")
    return false
}


let res = reBoolaa((2==3), tempFunc())
print("res : ", res)


let singleNumberInput = [4,1,2,1,2]
print("singleNumber : ", s.singleNumber(singleNumberInput))

func mergeSort(_ arr : [Int]) -> [Int] {
    
    func _partition(_ left : Int, _ right : Int, res : inout [Int]) {
        if left >= right {
            return
        }
        let mid = (right - left) / 2 + left
        _partition(left, mid, res: &res)
        _partition(mid+1, right, res: &res)
        _merge(left, mid, right, res: &res)
    }
    
    func _merge(_ left : Int, _ mid : Int, _ right : Int, res : inout [Int]) {
        
        var mergedArr = [Int]()
        var i = left
        var j = mid + 1
        while i <= mid && j <= right {
            if res[i] < res[j] {
                mergedArr.append(res[i])
                i += 1
            } else {
                mergedArr.append(res[j])
                j += 1
            }
        }
        
        while i <= mid {
            mergedArr.append(res[i])
            i += 1
        }
        while j <= right {
            mergedArr.append(res[j])
            j += 1
        }
        
        for i in 0 ..< mergedArr.count {
            res[left + i] = mergedArr[i]
        }
    }
    
    var res = arr
    _partition(0, res.count-1, res: &res)
    return res
}

let mergeSortSrcArr = [3,2,5,4,6,8,1,9,12,10]
print("merge sort res : ", mergeSort(mergeSortSrcArr))


let kClosestInputArr = [[68,97],[34,-84],[60,100],[2,31],[-27,-38],[-73,-74],[-55,-39],[62,91],[62,92],[-57,-67]]

let kClosestInputK = 5
print("kClosest : ",s.kClosest(kClosestInputArr, kClosestInputK))

//let majorityElementIn = [2,3,3,3,3,3,2]
let majorityElementIn = [1]

print("majorityElement : ",s.majorityElement(majorityElementIn))

let searchMatrixIn = [
    [1,   4,  7, 11, 15],
    [2,   5,  8, 12, 19],
    [3,   6,  9, 16, 22],
    [10, 13, 14, 17, 24],
    [18, 21, 23, 26, 30]
]
print("searchMatrix : ",s.searchMatrix(searchMatrixIn, 5))

var merge_Input1 = [1,2,0,0,0,0,0], m = 2
let merge_Input2 = [1,1,2,3,6], n = 5
s.merge_3(&merge_Input1, m, merge_Input2, n)
print("merge_1 : ",merge_Input1)

//let isPalindromeIn = "A man, a plan, a canal: Panama"
let isPalindromeIn =
"A man, a plan, a canal: Panama"

print("isPalindrome : ",s.isPalindrome(isPalindromeIn))

let partitionIn = "aabb"
print("partition res : ",s.partition(partitionIn))

