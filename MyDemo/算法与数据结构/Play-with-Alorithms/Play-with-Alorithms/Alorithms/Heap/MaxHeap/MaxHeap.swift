import Foundation

//索引从0开始的最大堆
//定义一个泛型之后，如果想让两个泛型的变量可以比较，需要将该泛型约束为Comparable
public struct MaxHeap<MyType : Comparable> {
    
    public var data = [MyType]()
    
    public init() {
        
    }
    
    //Heapify
    public init(array : [MyType]) {
        self.data = array
        let len = self.data.count - 1
        /*
         对于一个二叉堆来说，其所有的叶子节点都可以看做是一个只有一个节点的二叉堆
         那么基于索引从后往前看的话(堆的大小，即节点总数为len)：
         1.如果堆的索引从0开始，那么第一个非叶子节点的索引为 len / 2 - 1
         2.如果堆的索引从1开始，那么第一个非叶子节点的索引为 len / 2
         （上面的除法都是整型除法，即11/2 = 5）
         这样的话就可以忽略所有的叶子节点（因为叶子节点已经是二叉堆或者最大堆了），
         从这个 “第一个” 非叶子节点开始向前遍历每一个节点，执行shiftDown操作，
         这样的话，每一个节点（除叶子节点）为根的树都满足了堆的性质，
         一次类推，当根节点执行完shiftdown操作之后，整个数组就heapify（堆化）了
         */
        for k  in stride(from: len / 2 - 1, through: 0, by: -1) {
            self.shiftDown(k)
        }
    }
    
    public mutating func size() -> Int {
        return self.data.count
    }
    
    public mutating func isEmpty() -> Bool {
        return self.data.isEmpty
    }
    
    public mutating func insert(item : MyType) {
        //插入一个元素之后，随之将整个数组调整为最大堆
        self.data.append(item)
        let count = self.data.count
        self.shiftUp(idx: count - 1)
    }
    
    fileprivate mutating func shiftUp(idx : Int) {
        var index = idx
        let tmp = data[index]
        while index > 0 && data[(index - 1) / 2] < tmp {
            data[index] = data[(index - 1) / 2]
            index = (index - 1) / 2
        }
        data[index] = tmp
    }
    
    public mutating func fetchMaxElement() -> MyType? {
        if self.data.isEmpty {
            return nil
        }
        let maxElement = data[0]
        data[0] = data[data.count - 1]
        data.removeLast()
        if data.isEmpty != true {
            self.shiftDown(0)
        }
        return maxElement
    }

    fileprivate mutating func shiftDown(_ index : Int) {
        
        var i = index
        let tmp = data[i]
        let len = data.count
        while  (2 * i + 1) < len  {
            var j = 2 * i + 1
            if (j + 1) < len && data[j + 1] > data[j] {
                j = j + 1
            }
            if tmp >= data[j] {
                break
            }
            data[i] = data[j]
            i = j
        }
        print("过程： \(self.data)")
        data[i] = tmp
    }

    //直接对数组中指定位置的元素进行shiftDown操作
    public static func shiftDown(arr : inout [MyType], index : Int, len : Int) {
        var i = index
        let tmp = arr[i]
        while  (2 * i + 1) < len  {
            var j = 2 * i + 1
            if (j + 1) < len && arr[j + 1] > arr[j] {
                j = j + 1
            }
            if tmp >= arr[j] {
                break
            }
            arr[i] = arr[j]
            i = j
        }
        arr[i] = tmp
    }
}
