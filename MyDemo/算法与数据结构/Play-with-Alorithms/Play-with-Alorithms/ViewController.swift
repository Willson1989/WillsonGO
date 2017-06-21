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
        
//        let arr = [38, 34, 50, 52, 14, 15, 18, 36, 55, 2]
//        print("array : \(arr)")
//        let h = IndexMinHeap(arr: arr)
////        let h = IndexMinHeap_Tmp(capacity: 10)
//
////        for i in 0 ..< arr.count {
////            h.insert(item: arr[i])
////        }
//        
//        h.showHeap()
////        for _ in 0 ..< 5 {
////            let min = h.extractMin()
////            print("min : \(min)")
////        }
////        h.showHeap()
//        h.insert(item: 90)
//        h.insert(item: 0)
//        print(h.extractMin())
//        print(h.extractMin())
//        h.showHeap()
//        //h.change(with: 1, atArrayIndex: 9)
//        h.insert(item: 1, at: 0)
//        h.showHeap()
        
//        h.insert(item: 50)
//        h.insert(item: 5)
//        h.showHeap()
//        
//        let m1 = h.extractMin()!
//        print("m1 : \(m1)")
//        h.showHeap()
//        h.insert(item: 20)
//        h.showHeap()
//        let m2 = h.extractMin()!
//        h.showHeap()
//        print("m2 : \(m2)")
//        h.showHeap()
//        h.insert(item: 80)
//        h.showHeap()
//        
//        h.insert(item: 12)
//        h.insert(item: 40)
//        h.insert(item: 11)#0	0x000000010c4eabcb in ViewController.viewDidLoad() -> () at /Users/ZhengYi/WillsonGO/MyDemo/算法与数据结构/Play-with-Alorithms/Play-with-Alorithms/ViewController.swift:73

//        h.insert(item: 65)
//        
//        print()
//        h.showHeap()
//        h.showOriginData()
//        print()
//        print("insert 40 at array index 1")
//        //h.insert(item: 40, at: 1)
//        h.insert(item: 65)
//        h.showHeap()
//        h.showOriginData()
        
//        return
        
        print("DenseGraphW_Matrix : ====  ")
        let g1 = testWeightedGraph_DenseGraphW_Matrix()
        let lpMST1 = DenseGraphW_Matrix.PrimMST(graph: g1)
        lpMST1.showMST()
        
        print()
        print("SparseGraphW : ====  ")
        let g2 = testWeightedGraph_SparseGraphW()
        let lpMST2 = SparseGraphW.PrimMST(graph: g2)
        lpMST2.showMST()
//
        print()
        print("SparseGraphW_AdjList : ====  ")
        let g3 = testWeightedGraph_SparseGraphW_AdjList()
        let lpMST3 = SparseGraphW_AdjList.PrimMST(graph: g3)
        lpMST3.showMST()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

func testWeightedGraph_DenseGraphW_Matrix() -> DenseGraphW_Matrix {
    
    let g = DenseGraphW_Matrix(capacity: 8, directed: false)
    g.addEdge(0, 2, weight: 0.26)
    g.addEdge(0, 7, weight: 0.16)
    g.addEdge(0, 4, weight: 0.38)
    g.addEdge(0, 6, weight: 0.58)
    
    g.addEdge(1, 5, weight: 0.32)
    g.addEdge(1, 7, weight: 0.19)
    g.addEdge(1, 2, weight: 0.36)
    g.addEdge(1, 3, weight: 0.29)
    
    g.addEdge(2, 3, weight: 0.17)
    g.addEdge(2, 6, weight: 0.40)
    g.addEdge(2, 7, weight: 0.34)
    
    g.addEdge(3, 6, weight: 0.52)
    
    g.addEdge(4, 5, weight: 0.35)
    g.addEdge(4, 6, weight: 0.93)
    g.addEdge(4, 7, weight: 0.37)
    
    g.addEdge(5, 7, weight: 0.28)

    return g
}

func testWeightedGraph_SparseGraphW() -> SparseGraphW {
    
    let g = SparseGraphW(capacity: 8, directed: false)
    
    g.addEdge(0, 2, weight: 0.26)
    g.addEdge(0, 7, weight: 0.16)
    g.addEdge(0, 4, weight: 0.38)
    g.addEdge(0, 6, weight: 0.58)
    
    g.addEdge(1, 5, weight: 0.32)
    g.addEdge(1, 7, weight: 0.19)
    g.addEdge(1, 2, weight: 0.36)
    g.addEdge(1, 3, weight: 0.29)
    
    g.addEdge(2, 3, weight: 0.17)
    g.addEdge(2, 6, weight: 0.40)
    g.addEdge(2, 7, weight: 0.34)
    
    g.addEdge(3, 6, weight: 0.52)
    
    g.addEdge(4, 5, weight: 0.35)
    g.addEdge(4, 6, weight: 0.93)
    g.addEdge(4, 7, weight: 0.37)
    
    g.addEdge(5, 7, weight: 0.28)
    
    return g
}

func testWeightedGraph_SparseGraphW_AdjList() -> SparseGraphW_AdjList {
    
    let g = SparseGraphW_AdjList(capacity: 8, directed: false)
    
    g.addEdge(0, 2, weight: 0.26)
    g.addEdge(0, 7, weight: 0.16)
    g.addEdge(0, 4, weight: 0.38)
    g.addEdge(0, 6, weight: 0.58)
    
    g.addEdge(1, 5, weight: 0.32)
    g.addEdge(1, 7, weight: 0.19)
    g.addEdge(1, 2, weight: 0.36)
    g.addEdge(1, 3, weight: 0.29)
    
    g.addEdge(2, 3, weight: 0.17)
    g.addEdge(2, 6, weight: 0.40)
    g.addEdge(2, 7, weight: 0.34)
    
    g.addEdge(3, 6, weight: 0.52)
    
    g.addEdge(4, 5, weight: 0.35)
    g.addEdge(4, 6, weight: 0.93)
    g.addEdge(4, 7, weight: 0.37)
    
    g.addEdge(5, 7, weight: 0.28)
    
    return g
}





