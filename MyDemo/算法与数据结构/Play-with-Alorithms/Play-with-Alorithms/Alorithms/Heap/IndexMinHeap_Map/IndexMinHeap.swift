//
//  IndexMinHeap.swift
//  Play-with-Alorithms
//
//  Created by WillHelen on 2017/6/18.
//  Copyright © 2017年 ZhengYi. All rights reserved.
//

import UIKit

fileprivate let NG : Int = 0

class IndexMinHeap<T : Comparable & Equatable> {

    var index : [Int]  = [NG]
    var map   : [Int]  = [NG]
    var data  : [T?] = [nil]
    var count : Int = 0
    var capacity : Int = 0
    
    public init(capacity : Int) {
        //let cap = capacity + 1
        //map = Array(repeating: NG, count: cap)
        //index = Array(repeating: NG, count: cap)
        //data = Array(repeating: nil, count: cap)
        count = 0
        self.capacity = capacity
    }
    
    
    public init(arr : [T]) {
        
        let cap = arr.count + 1
        index = Array(repeating: NG, count: cap)
        map = Array(repeating: NG, count: cap)
        count = 0
        capacity = cap
        data = Array(repeating: nil, count: cap)
        for i in 0 ..< arr.count {
            data[i + 1] = arr[i]
            index[i + 1] = i + 1
            map[index[i + 1]] = i + 1
            count += 1
        }
        //heapify
        for i in stride(from: count/2, through: 1, by: -1) {
            fixDown(i)
        }
    }
    
    func fixDown(_ idx : Int) {
        var i = idx
        if count <= 0 {
            return
        }
        if data[index[i]] == nil {
            return
        }
        let tmp = data[index[i]]!
        let tmpIdx = index[i]
        while left(i) <= count {
            var j = left(i)
            if j + 1 <= count && data[index[j+1]]! < data[index[j]]! {
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
        if count <= 0 {
            return
        }
        if data[index[i]] == nil {
            return
        }
        let tmp = data[index[i]]!
        let tmpIdx = index[i]
        while parent(i) >= 1 && tmp < data[index[parent(i)]]! {
            
            index[i] = index[parent(i)]
            map[index[i]] = i
            map[index[parent(i)]] = parent(i)
            i = parent(i)
        }
        index[i] = tmpIdx
    }
    
    func insert(item : T) {
        data.append(item)
        index.append(NG)
        map.append(NG)
        count += 1
        index[count] = data.count - 1
        map[index[count]] = count
        fixUp(count)
    }
    
    //不能和insert(item : Int)共同使用，
    //只能使用其中一个insert方法来向堆中添加元素
    //不能重复在同一个位置insert元素
    func insert(item : T, at idx : Int) {
        let i = idx + 1
        //不重复添加元素
        if contain(idx) {
            return
        }
        //个数不能超过原有的大小
        if count + 1 > capacity {
            return
        }
        if i < 1 || i > count {
            return
        }
        data[i] = item
        count += 1
        index[count] = i
        map[i] = count
        fixUp(count)
    }
    
    func extractMin() -> T? {
        if self.isEmpty() {
            print("heap is empty")
            return nil
        }
        let ret = data[index[1]]!
        swapElement(&index, 1, count)
        map[index[count]] = NG
        map[index[1]] = 1
        count -= 1
        fixDown(1)
        return ret
    }
    
    func extractMinIndex() -> Int {
        if self.isEmpty() {
            print("heap is empty")
            return NG
        }
        let ret = index[1] - 1
        swapElement(&index, count, 1)
        map[index[count]] = 0
        map[index[1]] = 1
        count -= 1
        fixDown(1)
        return ret
    }
    
    func change(with item : T, atArrayIndex idx : Int) {
        if !contain(idx) {
            return
        }
        let i = idx + 1
        let hIdx = map[i]
        data[i] = item
        fixDown(hIdx)
        fixUp(hIdx)
    }
    
    func change(with item : T, atHeapIndex idx : Int) {
        let i = idx + 1
        if i >= 1 && i <= count {
            let arrIdx = index[i]
            data[arrIdx] = item
            fixUp(i)
            fixDown(i)
        }
    }
    
    func contain(_ idx : Int) -> Bool {
        if self.isEmpty() {
            return false
        }
        let i = idx + 1
        if i <= 1 && i >= count {
            return map[i] != NG
        }
        return false
    }
    
    func isEmpty() -> Bool {
        return count == 0
    }
    
    func showHeap() {
        print("index min heap info : ")
        for i in 1 ... count {
            print(data[index[i]]!, separator: "", terminator: " ")
        }
        print()
    }
    
    func showOriginData() {
        print("index min heap origin data : ")
        for i in 1 ... data.count - 1 {
            let item = data[i]!
            print(item, separator: "", terminator: " ")
        }
        print()
    }
}






