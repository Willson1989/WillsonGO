//
//  NodeList.swift
//  TempProj
//
//  Created by WillHelen on 2018/8/16.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

import Foundation

class ListNode {
    var val: Int
    var next: ListNode?

    init(_ v: Int) {
        val = v
        next = nil
    }
}

class List {
    var head: ListNode?
    var tail: ListNode?

    init() {
        head = nil
        tail = nil
    }

    convenience init(values: [Int]) {
        self.init()
        for i in stride(from: 0, to: values.count, by: 1) {
            appendToTail(withValue: values[i])
        }
    }

    init?(listNode: ListNode?) {
        guard let listNode = listNode else { return nil }
        head = listNode
        var p: ListNode? = listNode
        while p?.next != nil {
            p = p?.next
        }
        tail = p
    }

    func printList() {
        List.printList(withHeader: head)
    }

    class func printList(withHeader header: ListNode?) {
        var p = header
        while p != nil {
            if p!.next == nil {
                print("\(p!.val)")
            } else {
                print("\(p!.val)", separator: "", terminator: " - ")
            }
            p = p!.next
        }
    }

    // 插入节点 头插
    func appendToHead(withValue v: Int) {
        let node = ListNode(v)
        if head == nil {
            head = node
            tail = node
            node.next = nil
        } else {
            node.next = head
            head = node
        }
    }

    // 插入节点 尾插
    func appendToTail(withValue v: Int) {
        let node = ListNode(v)
        if tail == nil {
            tail = node
            head = tail
        } else {
            tail!.next = node
            tail = node
        }
    }

    // 按照t的值将链表分割开，大于t的在前边，小于t的在后边
    func partition(withTarget t: Int) -> ListNode? {
        let prevDummy = ListNode(0), postDummy = ListNode(0)
        var node = head
        var prev = prevDummy, post = postDummy
        while node != nil {
            if node!.val < t {
                prev.next = node
                prev = node!
            } else {
                post.next = node
                post = node!
            }
            node = node!.next
        }
        post.next = nil
        prev.next = postDummy.next
        return prevDummy.next
    }
}
