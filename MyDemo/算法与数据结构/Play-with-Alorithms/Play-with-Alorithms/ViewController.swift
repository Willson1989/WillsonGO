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
        
        let arr = TestHelper.randomArray(len: 10, limit: 50)

        var minH = IndexMinHeap_Map(array: arr)
        
        for i in 0 ... 10 {
            if minH.isEmpty() {
                print("heap is empty")
            }
            let a = minH.extractMin()
            print(minH)
            print("min num : \(a)")
            minH.showHeapInfo()
            print()
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

