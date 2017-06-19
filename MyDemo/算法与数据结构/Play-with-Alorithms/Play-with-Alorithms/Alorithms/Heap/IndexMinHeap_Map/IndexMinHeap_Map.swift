import Foundation


fileprivate let NG : Int = 65535

public protocol HeapDataType : Comparable, Equatable {
    
}

public let NODATA : Int = -1

//最小堆
public class IndexMinHeap_Map<T : Comparable & Equatable> {
    
    fileprivate var index : [Int] = []
    fileprivate var map : [Int] = []
    fileprivate var data : [T?] = []
    fileprivate var last : Int = 0
    
    //索引从1开始
    public init(array : [T]) {
        
        last = 0
        let cap = array.count + 1
        index = Array(repeating: NG, count: cap)
        map = Array(repeating: NG, count: cap)
        data = Array(repeating: nil, count: cap)
        
        for i in 0 ..< array.count {
            data[i + 1] = array[i]
            last += 1
            index[last] = i + 1
            map[index[last]] = last
        }
    
        for i in stride(from: last / 2, to: 0, by: -1) {
            fixDown(i)
        }
    }
    
    public init(capacity : Int) {
        last = 0
        let cap = capacity + 1
        index = Array(repeating: NG, count: cap)
        map = Array(repeating: NG, count: cap)
    }
    
    fileprivate func fixDown(_ idx : Int) {
        
        var i = idx
        if last <= 0 {
            return
        }
        assert(i >= 1 && i <= last)
        
        let tmpIdx = index[i]
        let tmpData = data[tmpIdx]!
        while left(i) <= last {
            
            var j = left(i)
            if j + 1 <= last && data[index[j + 1]]! < data[index[j]]! {
                j = j+1
            }
            if tmpData < data[index[j]]! {
                break
            }
            index[i] = index[j]
            map[index[i]] = i
            map[index[j]] = j
            i = j
        }
        index[i] = tmpIdx
    }
    
    fileprivate func fixUp(_ idx : Int) {
        
        var i = idx
        if last <= 0 {
            return
        }
        assert(i >= 1 && i <= last)
        
        let tmpIdx = index[i]
        let tmpData = data[tmpIdx]!
        while parent(i) >= 1 && tmpData < data[index[parent(i)]]! {
            index[i] = index[parent(i)]
            map[index[i]] = i
            map[index[parent(i)]] = parent(i)
            i = parent(i)
        }
        index[i] = tmpIdx
    }
    
    public func extractMin() -> T? {
        
        let min = data[index[1]]
        swapElement(&index, last, 1)
        map[index[last]] = 0
        map[index[1]] = 1
        last -= 1
        fixDown(1)
        return min
    }
    
    public func extractMinIndex() -> Int {
        let ret = index[1] - 1
        swapElement(&index, last, 1)
        map[index[last]] = 0
        map[index[1]] = 1
        last -= 1
        fixDown(1)
        return ret
    }
    
    public func changeItem(with item : T , arrayIndex idx : Int) {
        
        let i = idx + 1
        assert(i >= 1 && i <= last)
        let heapIndex = map[i]
        data[i] = item
        fixUp(heapIndex)
        fixDown(heapIndex)
    }
    
    public func changeItem(with item : T, heapIndex idx : Int) {
        let i = idx + 1
        assert(i >= 1 && i <= last)
        
        let arrayIndex = index[i]
        data[arrayIndex] = item
        fixUp(i)
        fixDown(i)
    }
    
    public func insertItem(_ item : T) {
        data.append(item)
        last += 1
        //扩充容量
        map.append(NG)
        index.append(NG)
        index[last] = data.count - 1
        map[index[last]] = last
        fixUp(last)
    }
    
    //对使用者来说，索引时从0开始的
    public func insertItem(_ item : T , at idx : Int) {
        let i = idx + 1
        assert(i <= last && i >= 1)
        data[i] = item
        index.append(i)
        map[i] = last + 1
        last += 1
        fixUp(last)
    }
    
    public func isEmpty() -> Bool{
        return last == 0
    }
    
    //指定数据中的元素索引，看这个索引是否存在于堆中
    public func containItem(dataIndex i : Int) -> Bool {
        
        return map[i] != NG
    }
    
    public func showOriginData() {
        
        print("Min heap origin data :")
        for i in 1 ... last {
            print(data[index[i]]!, separator: "", terminator: " ")
        }
        print()
    }
    
    public func showIndexData() {
        print("Min heap index data : ")
        for i in 1 ... last {
            print(index[i], separator: "", terminator: " ")
        }
        print()
    }
    
    public func showHeapInfo() {
        print("Min heap info : ")
        for i in 1 ... last {
            print(data[index[i]]!, separator: "", terminator: " ")
        }
        print()
    }
}

