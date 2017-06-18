//
//  IndexMinHeap_Tmp.swift
//  Play-with-Alorithms
//
//  Created by WillHelen on 2017/6/18.
//  Copyright © 2017年 ZhengYi. All rights reserved.
//

import UIKit

fileprivate let NG : Int = -1

class IndexMinHeap_Tmp {

    var index : [Int] = []
    var map : [Int] = []
    var data : [Int?] = []
    var last : Int = 0
    
    public init(capacity : Int) {
        let cap = capacity + 1
        index = Array(repeating: NG, count: cap)
        map = Array(repeating: NG, count: cap)
        data = Array(repeating: nil, count: cap)
        last = 0
    }
    
    
    public init(arr : [Int]) {
        
        let cap = arr.count + 1
        index = Array(repeating: NG, count: cap)
        map = Array(repeating: NG, count: cap)
        last = 0
        data = Array(repeating: nil, count: cap)
        for i in 0 ..< arr.count {
            data[i + 1] = arr[i]
            index[i + 1] = i + 1
            map[index[i + 1]] = i + 1
            last += 1
        }
        //heapify
        for i in stride(from: last/2, through: 1, by: -1) {
            fixDown(i)
        }
    }
    
    func fixDown(_ idx : Int) {
        var i = idx
        if last <= 0 {
            return
        }
        assert(i >= 1 && i <= last)
        
        let tmp = data[index[i]]!
        let tmpIdx = index[i]
        while left(i) <= last {
            var j = left(i)
            if j + 1 <= last && data[index[j+1]]! < data[index[j]]! {
                j = j + 1
            }
            if tmp < data[index[j]]! {
                break
            }
            index[i] = index[j]
            map[index[i]] = i
            map[index[j]] = j
            i = j
        }
        index[i] = tmpIdx
    }
    
    func fixUp(_ idx : Int) {
        var i = idx
        if last <= 0 {
            return
        }
        assert(i >= 1 && i <= last)
        
        let tmp = data[index[i]]!
        let tmpIdx = index[i]
        while i >= 1 && tmp < data[index[parent(i)]]! {
            
            index[i] = index[parent(i)]
            map[index[i]] = i
            map[index[parent(i)]] = parent(i)
            i = parent(i)
        }
        index[i] = tmpIdx
    }
    
    func insert(item : Int) {
        data.append(item)
        index.append(NG)
        map.append(NG)
        last += 1
        index[last] = data.count - 1
        map[index[last]] = last
        fixUp(last)
    }
    
    func insert(item : Int, at idx : Int) {
        let i = idx + 1
        assert(i >= 1 && i <= last)
        data[i] = item
        last += 1
        index.append(i)
        map[i] = last
        fixUp(last)
    }
    
    func extractMin() -> Int {
        
        let ret = data[index[1]]!
        swapElement(&index, 1, last)
        map[index[last]] = NG
        map[index[1]] = 1
        last -= 1
        fixDown(1)
        return ret
    }
    
    func extractMinIndex() -> Int {
        let ret = index[1] - 1
        swapElement(&index, last, 1)
        map[index[last]] = 0
        map[index[1]] = 1
        last -= 1
        fixDown(1)
        return ret
    }
    
    func change(with item : Int, atArrayIndex idx : Int) {
        let i = idx + 1
        assert(i >= 1 && i <= last)
        let hIdx = map[i]
        data[i] = item
        fixDown(hIdx)
        fixUp(hIdx)
    }
    
    func change(with item : Int, atHeapIndex idx : Int) {
        
        let i = idx + 1
        assert(i >= 1 && i <= last)
        let arrIdx = index[i]
        data[arrIdx] = item
        fixUp(i)
        fixDown(i)
    }
    
    func contain(withArrayIndex idx: Int) -> Bool {
        let i = idx + 1
        if i <= 1 && i >= last {
            return map[i] != NG
        }
        return false
    }
    
    func isEmpty() -> Bool {
        return last == 0
    }
}






