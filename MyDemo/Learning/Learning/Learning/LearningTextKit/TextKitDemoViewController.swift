//
//  TextKitDemoViewController.swift
//  Learning
//
//  Created by FN-273 on 2019/5/13.
//  Copyright © 2019 ZhengYi. All rights reserved.
//

import UIKit
import ObjectMapper

class TextKitDemoViewController: UIViewController {
    
    var parser : HSTextParser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray

        
        let dic = [

            ["size" : "16", "type" : "txt",  "content" : "hello", "color" : "blue"],

            ["size" : "16", "type" : "img",  "content" : "8", "height" : "10", "width" : "10"],

            ["size" : "17", "type" : "txt",  "content" : "AAA", "color" : "black"],
            ["size" : "16", "type" : "img",  "content" : "http://pic.yu361.com/avatar/avatar01-1557914815804572.jpg@!style_l", "height" : "10", "width" : "10"],

            ["size" : "16", "type" : "img",  "content" : "8", "height" : "10", "width" : "10"],

            ["size" : "16", "type" : "link", "content" : "BBB"],
            ["size" : "16", "type" : "txt",  "content" : "CCC", "color" : "red"],

            ["size" : "16", "type" : "img",  "content" : "http://pic.yu361.com/avatar/avatar01-1557729228553451.jpg@!style_l", "height" : "10", "width" : "10"],

            ["size" : "18", "type" : "txt",  "content" : "DDD"],
            ["size" : "16", "type" : "txt",  "content" : "EEE", "color" : "black"],
            ["size" : "16", "type" : "txt",  "content" : "FFF", "color" : "black"],
            ["size" : "19", "type" : "img",  "content" : "http://pic.yu361.com/avatar/avatar01-1557461344764040.jpg@!style_l", "height" : "40", "width" : "40"],
            ["size" : "16", "type" : "txt",  "content" : "GGG", "color" : "black"],
            ["size" : "12", "type" : "link", "content" : "HHH"],
            ["size" : "16", "type" : "img",  "content" : "7", "height" : "20", "width" : "20"],

        ]
        
        
        let www = self.view.bounds.size.width - 20
        let parser = HSTextParser(preferdMaxWidth: www)
        parser.parse(from: dic)
        
        let frame = CGRect(x: 10, y: 100, width: www, height: 300)
        //let lb = ZYLabel(frame: CGRect(x: 10, y: 100, width: www, height: 300), textStorage: parser.textStorage)
        let lb = HSChatLabel(parser: parser)
        lb.frame = frame
        //lb.setParser(parser)
        lb.backgroundColor = .yellow
        self.view.addSubview(lb)
        
        lb.attributedText = parser.generateAttributedString()
        
        lb.clickHandler = { model in
            print("zy debug touch began, content : ",model.content)
        }
        
        let tempView = UIView()
        tempView.backgroundColor = UIColor.purple
        tempView.frame = CGRect(x: 50, y: 100, width: 10, height: parser.boundingRect.size.height)
//        self.view.addSubview(tempView)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}

