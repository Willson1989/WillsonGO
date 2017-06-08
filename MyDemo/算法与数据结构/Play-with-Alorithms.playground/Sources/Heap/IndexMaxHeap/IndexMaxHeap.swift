import Foundation

public func parent(_ i : Int) -> Int {
    return i / 2
}

public func left(_ i : Int) -> Int {
    return 2 * i
}

public func right(_ i : Int) -> Int {
    return 2 * i + 1
}


public struct IndexMaxHeap{
    
    //存储数据元素（索引从1开始）
    public var data : [Int] = []
    
    //存储数据元素在其数组中的位置，该数组的索引代表data中元素在堆中的位置（索引从1开始）
    public var indexes : [Int] = []
    
    //数组中有效元素的个数，同时也代表最后一个有效元素的
    public var count : Int = 0
    
    public init(array : [Int]) {
        
        //初始值全为 -1
        self.count = 0
        let capacity = array.count + 1
        self.data = Array(repeating: -1, count: capacity)
        self.indexes = Array(repeating: -1, count: capacity)
        for i in 0 ..< array.count {
            self.data[i + 1] = array[i]
            self.count += 1
            //堆的索引从 1 还是
            self.indexes[i + 1] = self.count
        }
        //赋值之后只有data[0] 的位置是-1，堆的数据是从索引 1 的位置开始的
        //heapify
        for i in stride(from: self.count / 2, through: 1, by: -1) {
            self.fixDown(i)
        }
    }

    
    public init(capacity : Int) {
        self.count = capacity
        self.data = Array(repeating: -1, count: capacity + 1)
        self.indexes = Array(repeating: -1, count: capacity + 1)
    }
    
    //指定堆的索引，取出数组中相应的元素
    //对用户来说，index是从0开始的
    public func getItem(index : Int) -> Int {
        assert(index + 1 <= self.count, "取元素，索引位置无效")
        return self.data[indexes[index + 1]]
    }
    
    //指定堆的索引，更改索引对应的元素的值
    public mutating func changeItem(with item : Int, heapIndex index : Int) {
        assert(index + 1 <= self.count, "更改元素，索引位置无效")
        let idx = index + 1
        data[indexes[idx]] = item
        self.fixUp(idx)
        self.fixDown(idx)
    }
    
    //指定原始数据的数组索引，更改索引对应的元素的值
    public mutating func changeItem(with item : Int, originArrayIndex index : Int) {
        assert(index + 1 <= self.count, "更改元素，索引位置无效")
        let arrIdx = index + 1
        //data的可用数据是从索引位置1开始存储的
        data[arrIdx] = item
        
        for heapIndex in 1 ..< self.count {
            if indexes[heapIndex] == arrIdx {
                self.fixUp(heapIndex)
                self.fixDown(heapIndex)
                break
            }
        }
    }

    public mutating func insertItem(_ item : Int) {
        //追加到data数组的末尾
        self.data.append(item)
        self.count += 1
        self.indexes.append(self.count)
        self.fixUp(self.count)
    }
    
    public mutating func fetchMaxItem() -> Int {
        
        let maxItem = self.data[indexes[1]]
        
        swapElement(&indexes, self.count, 1)
        
//        let rmIdx = indexes[self.count]
//        self.data.remove(at: rmIdx)
//        self.indexes.remove(at: self.count)
        
        self.count -= 1
        
        self.fixDown(1)
        
        return maxItem
    }
    
    public mutating func fixDown(_ index : Int) {
        
        var i = index
        let len = self.count
        let tmpIdx = self.indexes[i]
        let tmp = self.data[tmpIdx]
        while left(i) <= len {
            var j = left(i)
            if j + 1 <= len && self.data[indexes[j + 1]] > self.data[indexes[j]] {
                j += 1
            }
            if tmp >= self.data[indexes[j]] {
                break
            }
            self.indexes[i] = self.indexes[j]
            i = j
        }
        self.indexes[i] = tmpIdx
    }

    
    public mutating func fixUp(_ index : Int) {
        var i = index
        let tmp = self.data[indexes[i]]
        let tmpIdx = self.indexes[i]
        while i > 1 && self.data[indexes[parent(i)]] < tmp {
            self.indexes[i] = self.indexes[parent(i)]
            i = parent(i)
        }
        self.indexes[i] = tmpIdx
    }

    
    public func size() -> Int {
        return self.count
    }
    
    
    public func printOriginData() {
        if self.count <= 1 {
            print("printOriginData 数据为空")
            return
        }
        var tmp = self.data
        tmp.remove(at: 0)
        print("原始数据 : ", separator: "", terminator: " ")
        print(tmp)
    }
    
    public func printHeapData() {
        if self.count <= 1 {
            print("printHeapData 数据为空")
            return
        }
        print("堆数据 : ", separator: "", terminator: " ")
        for i in 1 ... self.count {
            print(self.data[self.indexes[i]], separator: "", terminator: " ")
        }
        print()
    }
    
    public func fixDown(arr : inout [Int], index : Int, len : Int) {
        var i = index
        let tmp = arr[i]
        while left(i) < len {
            var j = left(i)
            if j + 1 < len && arr[j + 1] > arr[j] {
                j += 1
            }
            if tmp > arr[j] {
                break
            }
            arr[i] = arr[j]
            i = j
        }
        arr[i] = tmp
    }
}




