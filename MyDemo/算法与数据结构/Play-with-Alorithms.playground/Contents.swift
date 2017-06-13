//: Playground - noun: a place where people can play

import UIKit



let arr = [60, 10, 17, 71, 25, 78, 7, 57, 19, 30]

//var minH = IndexMinHeap_Map(array: arr)
//
//print()
//print("============")
//minH.showHeapInfo()
//let a1 = minH.extractMin()
//minH.showHeapInfo()
//print()
//
////let a2 = minH.extractMin()
////minH.showHeapInfo()
////print()
////
////let a3 = minH.extractMin()
////minH.showHeapInfo()
////print()
////
////let a4 = minH.extractMin()
////minH.showHeapInfo()
////print()
//
//minH.insertItem(100)
//
//minH.showHeapInfo()

var maxH = IndexMinHeap_Map(array: arr)
print("begin heap info : ")
maxH.showHeapInfo()

print("========")
//for _ in 0 ..< 4 {
//    let a = maxH.extractMax()
//    print("最大元素 ：\(a)", separator: "", terminator: " -- ")
//    maxH.printHeapInfo()
//}


print("111111111")

for _ in 0 ..< 4 {
    let r = Int(arc4random() % (UInt32(200 - 50 + 1)) + UInt32(50))
    maxH.insertItem(r)
    print("插入的元素 ：\(r)", separator: "", terminator: " -- ")
    maxH.showHeapInfo()
}

maxH.insertItem(0)
maxH.showHeapInfo()

//let N = 11
//let M = 50
//
//let from = 5
//let to = 8
//
//let aa = Array<Any?>(repeating: nil, count: 5)
//print(aa)
//
//print("///// ===== SparseGraph_AdjList =====  ")
//let tmpG = SparseGraph_AdjList(capacity: N, directed: false)
//
//tmpG.addEdge(0, 1)
//tmpG.addEdge(2, 3)
//tmpG.addEdge(2, 4)
//tmpG.addEdge(3, 4)
//tmpG.addEdge(5, 6)
//tmpG.addEdge(6, 7)
//tmpG.addEdge(5, 7)
//tmpG.addEdge(0, 9)
//tmpG.addEdge(5, 8)
//tmpG.addEdge(2, 10)
//tmpG.addEdge(0, 8)
//tmpG.addEdge(6, 8)
//tmpG.addEdge(10, 4)
//tmpG.show()
//
//
//let path8 = SparseGraph_AdjList.Path(graph: tmpG, v: from)
//let path = path8.path(with: to)
//path8.showPath(with: to)
//print("SparseGraph_AdjList 最短路")
//let sPath8 = SparseGraph_AdjList.ShortestPath(graph: tmpG, v: from)
//let sPath = sPath8.path(with: to)
//sPath8.showPath(with: to)
//sPath8.length(from: to)
//
//tmpG.E()
//tmpG.hasEdge(5, 8)
//tmpG.deleteEdge(5, 8)
//tmpG.deleteEdge(5, 6)
//tmpG.show()
//tmpG.E()
//
//let p11 = SparseGraph_AdjList.Path(graph: tmpG, v: from)
//p11.showPath(with: to)
//
//
//print("///// ===== SparseGraph =====  ")
//let tmpG1 = SparseGraph(capacity: N, directed: false)
//
//tmpG1.addEdge(0, 1)
//tmpG1.addEdge(2, 3)
//tmpG1.addEdge(2, 4)
//tmpG1.addEdge(3, 4)
//tmpG1.addEdge(5, 6)
//tmpG1.addEdge(6, 7)
//tmpG1.addEdge(5, 7)
//tmpG1.addEdge(0, 9)
//tmpG1.addEdge(5, 8)
//tmpG1.addEdge(2, 10)
//tmpG1.addEdge(0, 8)
//tmpG1.addEdge(6, 8)
//tmpG1.addEdge(10, 4)
//tmpG1.show()
//
//let path81 = SparseGraph.Path(graph: tmpG1, v: from)
//let path1 = path81.path(with: to)
//path81.showPath(with: to)
//print("SparseGraph 最短路")
//let sPath81 = SparseGraph.ShortestPath(graph: tmpG1, v: from)
//let sPath1 = sPath81.path(with: to)
//sPath81.showPath(with: to)
//sPath81.length(from: to)
//
//tmpG1.E()
//tmpG1.hasEdge(5, 8)
//tmpG1.deleteEdge(5, 8)
//tmpG1.hasEdge(5, 8)
//tmpG1.E()
//tmpG1.show()
//
//
//print("///// ===== DenseGraph_Matrix =====  ")
//let tmpG2 = DenseGraph_Matrix(capacity: N, directed: false)
//
//tmpG2.addEdge(0, 1)
//tmpG2.addEdge(2, 3)
//tmpG2.addEdge(2, 4)
//tmpG2.addEdge(3, 4)
//tmpG2.addEdge(5, 6)
//tmpG2.addEdge(6, 7)
//tmpG2.addEdge(5, 7)
//tmpG2.addEdge(0, 9)
//tmpG2.addEdge(5, 8)
//tmpG2.addEdge(2, 10)
//tmpG2.addEdge(0, 8)
//tmpG2.addEdge(6, 8)
//tmpG2.addEdge(10, 4)
//tmpG2.show()
//
//let path82 = DenseGraph_Matrix.Path(graph: tmpG2, v: from)
//let path2 = path82.path(with: to)
//path82.showPath(with: to)
//
//print("DenseGraph_Matrix 最短路")
//let sPath82 = DenseGraph_Matrix.ShortestPath(graph: tmpG2, v: from)
//let sPath2 = sPath82.path(with: to)
//sPath82.showPath(with: to)
//sPath82.length(from: to)

//tmpG.depthFirstSearch { (v) in
//    print(v, separator: "", terminator: " ")
//}

//for _ in 0 ..< 20 {
//    let a = Int(arc4random() % UInt32(N))
//    let b = Int(arc4random() % UInt32(N))
//    let ic = tmpG.isConnected(v: a, w: b)
//    print("a : \(a), b : \(b), isConnected : \(ic)")
//}

//tmpG.C()

//let g01 = SparseGraph_AdjList(capacity: N, directed: true)
//for _ in 0 ..< M {
//    let a = Int(arc4random() % UInt32(N))
//    let b = Int(arc4random() % UInt32(N))
//    g01.addEdge(a, b)
//}
////
//g01.show()
//g01.depthFirstSearch { (v) in
//    print(v, separator: "", terminator: " ")
//}
//
//
//let g02 = DenseGraph_Matrix(capacity: N, directed: false)
//for _ in 0 ..< M {
//    let a = Int(arc4random() % UInt32(N))
//    let b = Int(arc4random() % UInt32(N))
//    g02.addEdge(a, b)
//}
//
//g02.show()
//g02.depthFirstSearch { (v) in
//    print(v, separator: "", terminator: " ")
//}

//print()


//let g1 = SparseGraph(capacity: N, directed: false)
//for _ in 0 ..< M {
//    let a = Int(arc4random() % UInt32(N))
//    let b = Int(arc4random() % UInt32(N))
//    g1.addEdge(a, b)
//}

//print("Sparse graph ")
//for i in 0 ..< N {
//    print("Vertex \(i) : ", separator: "", terminator: " ")
//    let ite = SparseGraph.adjIterator(graph: g1, v: i)
//    var v = ite.begin()
//    while !ite.isEnd() {
//        print("\(v)", separator: "", terminator: " ")
//        v = ite.next()
//    }
//    print()
//}

//print()
//let g2 = DenseGraph_Matrix(capacity: N, directed: false)
//for _ in 0 ..< M {
//    let a = Int(arc4random() % UInt32(N))
//    let b = Int(arc4random() % UInt32(N))
//    g2.addEdge(a, b)
//}
//g1.show()
//g2.show()

//print("Dense graph ")
//for i in 0 ..< N {
//    print("Vertex \(i) : ", separator: "", terminator: " ")
//    let ite = DenseGraph_Matrix.adjIterator(graph: g2, v: i)
//
//    var v = ite.begin()
//    while !ite.isEnd() {
//        print("\(v)", separator: "", terminator: " ")
//        v = ite.next()
//    }
//    print()
//}

//for i in 0 ..< N {
//    print("\(i) : ", separator: "", terminator: "")
//
//    g1.iterateGraph(forNode: i, { (node) in
//        print("\(node)", separator: "", terminator: " ")
//    })
//
//    print()
//}
//print()
//
//let g2 = DenseGraph_Matrix(capacity: N, directed: false)
//for _ in 0 ..< M {
//    let a = Int(arc4random() % UInt32(N))
//    let b = Int(arc4random() % UInt32(N))
//    g2.addEdge(a, b)
//}

//for i in 0 ..< N {
//    print("\(i) : ", separator: "", terminator: "")
//
//    g2.iterateGraph(forNode: i, { (node) in
//        print("\(node)", separator: "", terminator: " ")
//    })
//
//    print()
//}

//public func enumBst(_ bst : BinarySearchTree<Int>) {
//    bst.perOrderTree { (key, value) in
//        print(key!, separator: "", terminator: ", ")
//    }
//    print()
//}
//
////var tmpArray = [56, 51, 69, 12, 9, 60, 100, 63, 53, 39]
//var tmpArray = [60, 25, 79, 56, 42, 80, 12, 22, 6, 17, 94, 81, 76, 49, 88, 3, 99, 54, 93, 18]
//
//var willBst = BinarySearchTree<Int>()
//for i in 0 ..< tmpArray.count {
//    willBst.insert(key: tmpArray[i], value: tmpArray[i])
//}
//
//willBst.floor(key: 4)
//willBst.ceil(key : -2)
//
//willBst.inOrderTree { (key, value) in
//    print(key!, separator: "", terminator: ", ")
//}
//print()
//
//willBst.size(nodeKey: 51)
//willBst.rank(withKey: 3)
//
//let k1 = willBst.select(rank : 1)
//
//for i in 0 ..< 30 {
//    let ri = Int(arc4random() % (UInt32(tmpArray.count)))
//    let element = tmpArray[ri]
//    print("元素 \(element) 在树中的排名为 ： \(willBst.rank(withKey: element))")
//    print()
//}

//print(tmpArray)
//for i in 0 ..< 30 {
//    let ri = Int(arc4random() % (UInt32(tmpArray.count)))
//    let element = tmpArray[ri]
////    let element = 51
//    print("====== 即将删除\(element) ====")
////    enumBst(willBst)
//    willBst.deleteNode(key: element)
////    enumBst(willBst)
//    print("====== 删除结束 Size \(willBst.treeSize()) ====\n")
//}
//let sizenew2 = willBst.treeSize()
//
//print()

//struct PersonInfo : Hashable, Equatable , Comparable{
//
//    var age  : Int
//    var pId  : Int
//    var name : String
//
//    //遵守 Hashable 协议，使该类型的实例可以作为字典的key
//    var hashValue: Int {
//        get {
//            return self.pId.hashValue
//        }
//    }
//
//    //遵守 Hashable 还必须要同时遵守 Equatable，并重载 == 运算符
//    //似之具备可以判断相等的性质
//    static func == (lhs : PersonInfo, rhs : PersonInfo) -> Bool {
//        return lhs.pId.hashValue == rhs.pId.hashValue
//    }
//
//    //遵守 Comparable 并重载比较相关的运算符，
//    //使该类型的实例具备可以比较大小的性质
//    static func > (lhs : PersonInfo, rhs : PersonInfo) -> Bool {
//        return lhs.age > rhs.age
//    }
//
//    static func >= (lhs : PersonInfo, rhs : PersonInfo) -> Bool {
//        return lhs.age >= rhs.age
//    }
//
//    static func < (lhs : PersonInfo, rhs : PersonInfo) -> Bool {
//        return lhs.age < rhs.age
//    }
//
//    static func <= (lhs : PersonInfo, rhs : PersonInfo) -> Bool {
//        return lhs.age <= rhs.age
//    }
//
//
//    init(pid : Int, age : Int, name : String) {
//        self.pId = pid
//        self.age = age
//        self.name = name
//    }
//}
//
//func randomInt() -> Int {
//    //[1000 ... 2000]之间的随机数
//    return Int(arc4random() % (2000 - 1000 + 1) + 1000)
//}
//
//
//struct  pInfo : Comparable, Equatable {
//    var age : Int = 0
//    var name : String?
//    var pId : Int = 0
//
//    public init(pid : Int, age : Int, name : String) {
//        self.pId = pid
//        self.age = age
//        self.name = name
//    }
//
//    public static func == (lhs : pInfo, rhs : pInfo) -> Bool {
//        return lhs.pId.hashValue == rhs.pId.hashValue
//    }
//
//    public static func > (lhs : pInfo, rhs : pInfo) -> Bool {
//        return lhs.pId > rhs.pId
//    }
//
//    public static func >= (lhs : pInfo, rhs : pInfo) -> Bool {
//        return lhs.pId >= rhs.pId
//    }
//
//    public static func < (lhs : pInfo, rhs : pInfo) -> Bool {
//        return lhs.pId < rhs.pId
//    }
//
//    public static func <= (lhs : pInfo, rhs : pInfo) -> Bool {
//        return lhs.pId <= rhs.pId
//    }
//}
//
//var bst = BinarySearchTree<Int>()
//
//
//let arr = [8,39,44,25,22,42,3,37,24,34,35,10,5,12,18,31,26]
//
//for i in 0 ..< arr.count {
//
//    let p = pInfo(pid: arr[i], age: 20+i, name: "willson-0" + String(i))
//    bst.insert(key: p.pId, value: p)
//}
//
//print("执行删除操作之前的数据：")
//bst.inOrderTree { (key, value) in
//    print(key!, separator: "", terminator: ", ")
//}
//print()
//print()
//
//func deletNode(key : Int) {
//    let delKey = key
//    bst.deleteNode(key: delKey)
//    print("删除了key值为 ： \(delKey)的节点之后的数据：")
//    bst.levelOrder { (key, value) in
//        print(key!, separator: "", terminator: ", ")
//    }
//    print()
//}
//
//deletNode(key: 34)
//
//let bstFloor44 = bst.floor(key: 36)
//
//
//enum SomeType {
//
//    case type_A            //普通的枚举值
//    case type_B(Int, Int)  //带参数的枚举值
//    case type_C(String)
//    indirect case  type_D(SomeType, SomeType) //枚举类型自身作为枚举参数的递归枚举值
//
//    static func evaluate(type : SomeType) {
//        switch type {
//        case .type_A:
//            print("This is type_A")
//            print()
//
//        case let .type_B(num1, num2) :  //这里使用let是为了声明num1和num2两个变量
//            print("This is type_B, nums : \(num1), \(num2)")
//            print()
//
//        case let .type_C(str) :
//            print("This is type_C, string : \(str)")
//            print()
//        case let .type_D(aType, bType) :
//            //递归调用
//            SomeType.evaluate(type: aType)
//            SomeType.evaluate(type: bType)
//            //也可以不写类型名来调用方法
//            //evaluate(type: aType)
//            //evaluate(type: bType)
//        }
//    }
//}
//
//
//let t = SomeType.type_D(SomeType.type_B(1, 2), SomeType.type_C("willson"))
//
//SomeType.evaluate(type: t)
