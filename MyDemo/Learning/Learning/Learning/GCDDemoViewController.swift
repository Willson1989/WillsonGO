//
//  GCDDemoViewController.swift
//  Learning
//
//  Created by WillHelen on 2019/3/13.
//  Copyright © 2019年 ZhengYi. All rights reserved.
//

import UIKit

class GCDDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let userAdd : DispatchSourceUserDataAdd = DispatchSource.makeUserDataAddSource(queue: DispatchQueue.main)
        
        userAdd.setEventHandler {
            let curr = userAdd.data
            print("curr user data : ", curr)
        }
        
        
        let arr = [1,2,3,4,5]
//        DispatchQueue.global().async {
//            DispatchQueue.main.sync {
//                // concurrentPerform 会由系统决定是否在主线程中执行任务
//                // 即使把 concurrentPerform 放在 DispatchQueue.main.sync 里面，block也不一定是在主线程中执行的。
//                DispatchQueue.concurrentPerform(iterations: arr.count) { (index) in
//                    print("isMainThread : ",Thread.isMainThread)
//                    userAdd.add(data: UInt(arr[index]))
//                }
//            }
//        }
//        let queue = DispatchQueue(label: "temp")
        
        
//        let queue = DispatchQueue.global()
//        for i in 0 ..< arr.count {
//            queue.async {
//                let n = UInt(arr[i])
//                print("add n : ", n)
//                userAdd.add(data: n)
//            }
//        }
//        userAdd.resume()
        
        /*
         并发队列 + 同步执行 ： 不创建新线程，当前线程执行
         并发队列 + 异步执行 ： 创建多个新线程
         串行队列 + 同步执行 ： 不创建线程，当前线程执行
         串行队列 + 异步执行 ： 创建一个线程
         */
        
        
        let item = DispatchWorkItem {
            print("outSide : ", Thread.current)
            
            // let queue = DispatchQueue(label: "customConcQueue", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit, target: nil)
            let queue = DispatchQueue.global()
    
            queue.async {
                print("1111 , thread ", Thread.current)
            }
            print("aaaa")
            queue.async {
                print("2222 , thread ", Thread.current)
            }
            print("bbbb")
            queue.async {
                print("3333 , thread ", Thread.current)
            }
            print("cccc")
            queue.async {
                print("4444 , thread ", Thread.current)
            }
            print("dddd")

        }
        DispatchQueue.global().async(execute: item)
    }
}


extension Array where Element : FixedWidthInteger & SignedInteger {

    
    func addFirstTwoElements() -> Element {
        return self[0] + self[1]
    }
}

