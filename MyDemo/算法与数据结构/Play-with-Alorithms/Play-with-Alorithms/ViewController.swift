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
        
        let g1 = testWeightedGraph()
        
        let lpMST = SparseGraphW.KruskalMST(graph: g1)
        lpMST.showMST()
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







