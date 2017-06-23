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
//        
////        let h1 = SimpleHeap(arr: arr, type: .max)
//        let h1 = SimpleHeap<Int>(capacity: arr.count, type: HeapType.min)
//        h1.showHeap()
//        
//        for i in 0 ..< arr.count {
//            //h1.insert(item: arr[i], at: i)
//            h1.insert(item: arr[i])
//            h1.showHeap()
//        }
//        
//        print("about to extract")
//        for _ in 0 ..< 18 {
//            if let ret = h1.extract() {
//                print("result : \(ret)")
//            }
//            h1.showHeap()
//        }
//        return
//
//
        
//        print("DenseGraphW_Matrix : ====  ")
//        let g1 = testWeightedGraph_DenseGraphW_Matrix()
//        let lpMST1 = DenseGraphW_Matrix.KruskalMST(graph: g1)
//        lpMST1.showMST()
//        
//        print()
//        print("SparseGraphW : ====  ")
//        let g2 = testWeightedGraph_SparseGraphW()
//        let lpMST2 = SparseGraphW.KruskalMST(graph: g2)
//        lpMST2.showMST()
//        
//        print()
//        print("SparseGraphW_AdjList : ====  ")
//        let g3 = testWeightedGraph_SparseGraphW_AdjList()
//        let lpMST3 = SparseGraphW_AdjList.KruskalMST(graph: g3)
//        lpMST3.showMST()
        
        let from = 4
        let to = 0
        
        print("SparseGraphW Dijkstra Shortest Path: ====  ")
        let g11 = testDijkstra_SparseGraphW()
        let sp11 = SparseGraphW.DijkstraPath(source: from, graph: g11)
        sp11.showPath(to: to)
        
        print()
        print("DenseGraphW_Matrix Dijkstra Shortest Path: ====  ")
        let g12 = testDijkstra_DenseGraphW_Matrix()
        let sp12 = DenseGraphW_Matrix.DijkstraPath(source: from, graph: g12)
        sp12.showPath(to: to)
        print()
        print("SparseGraphW_AdjList Dijkstra Shortest Path: ====  ")
        let g13 = testDijkstra_SparseGraphW_AdjList()
        let sp13 = SparseGraphW_AdjList.DijkstraPath(source: from, graph: g13)
        sp13.showPath(to: to)
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


func testDijkstra_DenseGraphW_Matrix() -> DenseGraphW_Matrix {
    let g = DenseGraphW_Matrix(capacity: 5, directed: false)
    
    g.addEdge(0, 2, weight: 2)
    g.addEdge(0, 1, weight: 5)
    g.addEdge(0, 3, weight: 6)
    
    g.addEdge(2, 1, weight: 1)
    g.addEdge(2, 3, weight: 3)
    g.addEdge(2, 4, weight: 5)
    
    g.addEdge(1, 4, weight: 1)
    g.addEdge(3, 4, weight: 2)

    return g
}


func testDijkstra_SparseGraphW_AdjList() -> SparseGraphW_AdjList {
    let g = SparseGraphW_AdjList(capacity: 5, directed: false)
    
    g.addEdge(0, 2, weight: 2)
    g.addEdge(0, 1, weight: 5)
    g.addEdge(0, 3, weight: 6)
    
    g.addEdge(2, 1, weight: 1)
    g.addEdge(2, 3, weight: 3)
    g.addEdge(2, 4, weight: 5)
    
    g.addEdge(1, 4, weight: 1)
    g.addEdge(3, 4, weight: 2)
    
    return g
}

func testDijkstra_SparseGraphW() -> SparseGraphW {
    let g = SparseGraphW(capacity: 6, directed: false)
    
    g.addEdge(0, 2, weight: 2)
    g.addEdge(0, 1, weight: 5)
    g.addEdge(0, 3, weight: 6)
    
    g.addEdge(2, 1, weight: 1)
    g.addEdge(2, 3, weight: 3)
    g.addEdge(2, 4, weight: 5)
    
    g.addEdge(1, 4, weight: 1)
    g.addEdge(3, 4, weight: 2)
    
    
    return g
}

