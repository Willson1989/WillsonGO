//
//  ViewController.swift
//  Play-with-Alorithms
//
//  Created by ZhengYi on 2017/6/14.
//  Copyright © 2017年 ZhengYi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        let w3 = GraphWeight.addWeight(w1, w2)
//        
//        print("w1 : \(w1.wID), w2 : \(w2.wID), w3 : \(w3.wID)")

        let arr = TestHelper.randomArray(len: 10, limit: 50)

//        var minH = IndexMinHeap_Map(array: arr)
//        
//        for i in 0 ... 10 {
//            if minH.isEmpty() {
//                print("heap is empty")
//            }
//            let a = minH.extractMin()
//            print(minH)
//            print("min num : \(a)")
//            minH.showHeapInfo()
//            print()
//        }
//        let a1 : WInfo = WInfo(cId: 111, cName: "1")
//        let a2 : WInfo = WInfo(cId: 222, cName: "2")
//        let a3 = a1 + a2
//        print("cid1 \(a1.cId), cid2 \(a2.cId), cid3 : \(a3.cId)")
////        
//        let N : Int = 11
//        let M : Int = 50
//        
//        let from : Int = 5
//        let to : Int = 8
//        
//        var wArr : [WInfo] = []
//        for _ in 0 ..< 50 {
//            let id = Int(arc4random() % UInt32(50))
//            let w = WInfo(cId: id, cName: "willson" + String(id))
//            wArr.append(w)
//        }
//        //SparseGraphW
//        let g01 = SparseGraphW<WInfo>(capacity: N, directed: false)
//        
//        g01.addEdge(0, 1, weight: randomInfo(from: wArr))
//        g01.addEdge(2, 3, weight: randomInfo(from: wArr))
//        g01.addEdge(2, 4, weight: randomInfo(from: wArr))
//        g01.addEdge(3, 4, weight: randomInfo(from: wArr))
//        g01.addEdge(5, 6, weight: randomInfo(from: wArr))
//        g01.addEdge(6, 7, weight: randomInfo(from: wArr))
//        g01.addEdge(5, 7, weight: randomInfo(from: wArr))
//        g01.addEdge(0, 9, weight: randomInfo(from: wArr))
//        g01.addEdge(5, 8, weight: randomInfo(from: wArr))
//        g01.addEdge(2,10, weight: randomInfo(from: wArr))
//        g01.addEdge(0, 8, weight: randomInfo(from: wArr))
//        g01.addEdge(6, 8, weight: randomInfo(from: wArr))
//        g01.addEdge(10,4, weight: randomInfo(from: wArr))
//        
//        g01.show()
//        
//        
//        print("dfs : ", separator: "" , terminator: "")
//        g01.depthFirstSearch { (v) in
//            print(v, separator: "", terminator: " ")
//        }
//        print()
//        print("v : \(g01.V()), e : \(g01.E())")
//
//        let sp01 = SparseGraphW.ShortestPath(graph: g01, v: from)
//        sp01.showPath(with: to)
//        
//        let p01 = SparseGraphW.Path(graph: g01, v: from)
//        p01.showPath(with: to)
//        
//        g01.deleteEdge(from, to)
//        let p011 = SparseGraphW.Path(graph: g01, v: from)
//        p011.showPath(with: 6)
//        
//
//        let hh56 = g01.hasEdge(5, 6)

    }
    
//    func randomInfo(from arr : [WInfo]) -> WInfo {
//        assert(arr.count > 0)
//        let r = Int(arc4random() % UInt32(arr.count))
//        return arr[r]
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}




//class WInfo : GraphWeight{
//
//    public var cId : Int = 0
//    public var cName : String = ""
//    
//    init(cId : Int , cName : String) {
//        self.cId = cId
//        self.cName = cName
//    }
//    
//    public static func <(lhs: WInfo, rhs : WInfo) -> Bool {
//        return lhs.cId < rhs.cId
//    }
//    
//    public static func <=(lhs: WInfo, rhs : WInfo) -> Bool {
//        return lhs.cId <= rhs.cId
//    }
//    
//    public static func >(lhs: WInfo, rhs : WInfo) -> Bool {
//        return lhs.cId > rhs.cId
//    }
//    
//    public static func >=(lhs: WInfo, rhs : WInfo) -> Bool {
//        return lhs.cId >= rhs.cId
//    }
//    
//    public static func ==(lhs: WInfo, rhs : WInfo) -> Bool {
//        return lhs.cId == rhs.cId
//    }
//    
//    static func + (l : WInfo , r : WInfo) -> Self {
//        
//    }
//    public static func + (lhs: WInfo, rhs : WInfo) -> WInfo {
//        let newCId = lhs.cId + rhs.cId
//        let w = WInfo(cId: newCId, cName: lhs.cName)
//        return w
//    }
//}
