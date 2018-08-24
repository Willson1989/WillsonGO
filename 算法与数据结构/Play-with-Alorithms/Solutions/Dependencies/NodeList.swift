//
//  NodeList.swift
//  TempProj
//
//  Created by 朱金倩 on 2018/8/16.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

import Foundation

class ListNode {
    var val : Int;
    var next : ListNode?;
    
    init(_ v : Int) {
        self.val = v;
    }
}

class NodeList {
    var head : ListNode?
    var tail : ListNode?
    
    init() {
        self.head = nil;
        self.tail = nil;
    }
    
    convenience init(values : [Int]) {
        self.init();
        for i in stride(from: 0, to: values.count, by: 1) {
            self.appendToTail(withValue: values[i]);
        }
    }
    
    func printList() {
        NodeList.printList(withHeader: self.head)
    }
    
    class func printList(withHeader header : ListNode?) {
        var p = header;
        while p != nil {
            if p!.next == nil {
                print("\(p!.val)")
            } else {
                print("\(p!.val)", separator: "", terminator: " - ")
            }
            p = p!.next;
        }
    }
    
    func appendToHead(withValue v : Int) {
        let node = ListNode(v)
        if self.head == nil {
            self.head = node;
            self.tail = node;
            node.next = nil;
        } else {
            node.next = self.head;
            self.head = node;
        }
    }
    
    func appendToTail(withValue v : Int) {
        let node = ListNode(v);
        if self.tail == nil {
            self.tail = node;
            self.head = self.tail;
        } else {
            self.tail!.next = node;
            self.tail = node;
        }
    }
    
    func partition(withTarget t : Int) -> ListNode? {
        let prevDummy = ListNode(0), postDummy = ListNode(0);
        var node = self.head
        var prev = prevDummy, post = postDummy
        while node != nil {
            if node!.val < t {
                prev.next = node;
                prev = node!;
            } else {
                post.next = node;
                post = node!
            }
            node = node!.next
        }
        post.next = nil
        prev.next = postDummy.next
        return prevDummy.next;
    }
}
