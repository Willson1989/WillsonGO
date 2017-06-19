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
        
        let arr = [38, 34, 50, 52, 14, 15, 18, 36, 55, 2]
        print("array : \(arr)")
        let h = IndexMinHeap_Tmp(arr: arr)
//        let h = IndexMinHeap_Tmp(capacity: 10)

//        for i in 0 ..< arr.count {
//            h.insert(item: arr[i])
//        }
        
        h.showHeap()
//        for _ in 0 ..< 5 {
//            let min = h.extractMin()
//            print("min : \(min)")
//        }
//        h.showHeap()
        h.insert(item: 90)
        h.insert(item: 0)
        print(h.extractMin())
        print(h.extractMin())
        h.showHeap()
        h.change(with: 0, atArrayIndex: 4)
        
        h.showHeap()
        
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
//        h.insert(item: 11)
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
        
        return
        
        let g1 = testWeightedGraph()
        let lpMST = SparseGraphW.KruskalMST(graph: g1)
        lpMST.showMST()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

func testWeightedGraph() -> SparseGraphW {
    
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







