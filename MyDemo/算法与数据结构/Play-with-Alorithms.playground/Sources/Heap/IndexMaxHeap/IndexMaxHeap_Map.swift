import Foundation

//索引从1开始的堆
public struct IndexMaxHeap_Map{
    
    
    fileprivate var data : [Int] = []
    
    //堆的索引  --(查找到)--> 元素在数组中的索引
    fileprivate var indexes : [Int] = []
    
    //元素在数组中的索引  --(查找到)--> 这个元素在堆中的索引位置
    fileprivate var map : [Int] = []
    
    
    fileprivate var last : Int = 0
    
    
    public init(capacity : Int) {
        
        let cap = capacity + 1
        data = Array(repeating: -1, count: cap)
        indexes = Array(repeating: -1, count: cap)
        map = Array(repeating: 0, count: cap)
        last = 0
    }
    
    public init(arr : [Int]) {
        
        let cap = arr.count + 1
        last = 0
        data = Array(repeating: -1, count: cap)
        indexes = Array(repeating: -1, count: cap)
        map = Array(repeating: 0, count: cap)
        
        for i in 0 ..< arr.count {
            data[i + 1] = arr[i]
            last += 1
            indexes[last] = i + 1
            map[indexes[last]] = i + 1
        }
        
        for j in stride(from: last / 2, through: 1, by: -1) {
            fixDown(j)
        }
    }
    
    public func getItem(arrIndex idx : Int) -> Int {
        assert(containItem(idx))
        let i = idx + 1
        return data[i]
    }
    
    public func getItem(heapIndex i : Int) -> Int {
        assert(i >= 1 && i <= last)
        return data[indexes[i + 1]]
    }
    
    public mutating func changeItem(with item: Int,  heapIndex idx : Int) {
        
        let i = idx + 1
        assert(i >= 1 && i <= last)
        let arrIdx = indexes[i]
        data[arrIdx] = item
        fixDown(i)
        fixUp(i)
    }
    
    public mutating func changeItem(with item: Int,  arrIndex idx : Int) {
        
        assert(containItem(idx))
        let i = idx + 1
        let heapIndex = map[i]
        data[i] = item
        fixDown(heapIndex)
        fixUp(heapIndex)
    }
    
    public mutating func insertItem(_ item : Int) {
        
        data.append(item)
        last += 1
        //扩充容量
        map.append(0)
        indexes.append(-1)
        indexes[last] = data.count - 1
        map[indexes[last]] = last
        fixUp(last)
    }
    
    public mutating func extractMax() -> Int {
    
        let max = data[indexes[1]]
        swapElement(&indexes, last, 1)
        map[indexes[last]] = 0
        map[indexes[1]] = 1
        last -= 1
        fixDown(1)
        
        return max
    }
    
    fileprivate func containItem(_ idx : Int) -> Bool{
        
        let i = idx + 1
        assert(i >= 1 && i <= last)
        return map[i] != 0
    }
    
    fileprivate mutating func fixUp(_ idx : Int) {
        
        var i = idx
        assert(i >= 1 && i <= last)
        
        let tmpIdx = indexes[i]
        let tmp = data[tmpIdx]
        
        while parent(i) >= 1 && tmp > data[indexes[parent(i)]] {
            indexes[i] = indexes[parent(i)]
            map[indexes[i]] = i
            map[indexes[parent(i)]] = parent(i)
            i = parent(i)
        }
        indexes[i] = tmpIdx
    }
    
    
    fileprivate mutating func fixDown(_ idx : Int) {
        
        var i = idx
        assert(i >= 1 && i <= last)
        
        let tmpIdx = indexes[i]
        let tmp = data[tmpIdx]

        while left(i) <= last {
            var j = left(i)
            if j + 1 <= last && data[indexes[j + 1]] > data[indexes[j]] {
                j += 1
            }
            
            if tmp > data[indexes[j]] {
                break
            }
            indexes[i] = indexes[j]
            map[indexes[i]] = i
            map[indexes[j]] = j
            i = j
        }
        indexes[i] = tmpIdx
    }
    
    public func printHeapInfo() {
        print("Heap Data : ")
        
        for i in 1 ... last {
            print(data[indexes[i]], separator: "", terminator: " ")
        }
        print()
    }
    
    public func printOriginData() {
        print("Origin Data : ")
        
        for i in 1 ... last {
            print(data[i], separator: "", terminator: " ")
        }
        print()
    }
    
    public func printIndexesInfo() {
        print("Indexes Data : ")
        
        for i in 1 ... last {
            print(indexes[i], separator: "", terminator: " ")
        }
        print()
    }
}
