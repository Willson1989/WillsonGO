//
//  IndexMinHeap_Tmp.swift
//  Play-with-Alorithms
//
//  Created by WillHelen on 2017/6/18.
//  Copyright © 2017年 ZhengYi. All rights reserved.
//

import UIKit

fileprivate let NG : Int = 0

class IndexMinHeap_Tmp {

    var index : [Int]  = [NG]
    var map   : [Int]  = [NG]
    var data  : [Int?] = [nil]
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
    
    
    public init(arr : [Int]) {
        
        let cap = arr.count + 1
        index = Array(repeating: NG, count: cap)
        map = Array(repeating: NG, count: cap)
        count = 0
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
    
    func insert(item : Int) {
        data.append(item)
        index.append(NG)
        map.append(NG)
        count += 1
        index[count] = data.count - 1
        map[index[count]] = count
        fixUp(count)
    }
    
    func insert(item : Int, at idx : Int) {
        let i = idx + 1
        assert(i >= 1 && i <= count)
        data[i] = item
        count += 1
        index.append(i)
        map[i] = count
        fixUp(count)
    }
    
    func extractMin() -> Int? {
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
    
    func change(with item : Int, atArrayIndex idx : Int) {
        let i = idx + 1
        assert(i >= 1 && i <= count)
        let hIdx = map[i]
        data[i] = item
        fixDown(hIdx)
        fixUp(hIdx)
    }
    
    func change(with item : Int, atHeapIndex idx : Int) {
        let i = idx + 1
        assert(i >= 1 && i <= count)
        let arrIdx = index[i]
        data[arrIdx] = item
        fixUp(i)
        fixDown(i)
    }
    
    func contain(withArrayIndex idx: Int) -> Bool {
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






