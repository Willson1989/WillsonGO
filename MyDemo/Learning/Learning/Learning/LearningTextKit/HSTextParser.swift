//
//  TextParser.swift
//  Learning
//
//  Created by FN-273 on 2019/5/15.
//  Copyright © 2019 ZhengYi. All rights reserved.
//

import UIKit


enum ContentType {
    case text, link, image
}


protocol ParseModelTransform {
    func parse(from dicArr: [[String : String]]) -> [ParseResultModel]
}


struct ParseResultModel {
    
    var type : ContentType = .text
    
    // 如果是文字类型，则content是文字的内容，如果是图片，则content为本地图片名称或者网络图片url
    var content : String = ""
    
    // 文字颜色
    var color : UIColor = .gray
    
    // 字号大小，如果类型是文字，则用作文字的字体大小，如果是图片，则用来调整图片的基线
    var fontSize : CGFloat = 14
    
    // 当前内容在整个字符串中所处的range
    var range : NSRange = NSMakeRange(0, 0)
    
    // 图片的宽和高
    var imgWidth : CGFloat = 0.0
    var imgHeight : CGFloat = 0.0
    
    // 是否是网络图片
    var isNetImage : Bool = false
    
    // 点击的跳转路由
    var routerUrl : String?
}


class HSTextParser : ParseModelTransform {
    
    private(set) var models : [ParseResultModel] = []
    //private(set) var imageFrameMap : [NSRange : CGRect] = [:]
    private(set) var boundingRect  : CGRect = .zero
    private(set) var preferdMaxWidth : CGFloat = 0
    
    private(set) var layoutManager = NSLayoutManager()
    private(set) var textContainer = NSTextContainer()
    private(set) var textStorage   = NSTextStorage()
    private(set) var maxFontSize : CGFloat = 0
    
    private(set) var attributedString : NSAttributedString?
    
    init(preferdMaxWidth : CGFloat) {
        self.preferdMaxWidth = preferdMaxWidth
        self.textContainer.size = CGSize(width: preferdMaxWidth, height: CGFloat.infinity)
        self.layoutManager.addTextContainer(self.textContainer)
        self.textStorage.addLayoutManager(self.layoutManager)
    }
    
    private init() { }
    
    @discardableResult
    func parse(from dicArr: [[String : String]]) -> [ParseResultModel] {
        
        var offset : Int = 0
        
        for dic in dicArr {
            var m = ParseResultModel()
            m.content = dic["content"] ?? ""
            m.fontSize = CGFloat(Float(dic["size"] ?? "13.0")!)
            // 获取最大字号
            if m.fontSize > self.maxFontSize {
                self.maxFontSize = m.fontSize
            }
            if let type = dic["type"] {
                // 类型
                if type == "txt" {
                    m.type = .text
                    m.range = NSMakeRange(offset, m.content.count)
                    offset += m.content.count
                } else if type == "link" {
                    m.type = .link
                    m.range = NSMakeRange(offset, m.content.count)
                    offset += m.content.count
                    
                } else if type == "img" {
                    m.type = .image
                    m.range = NSMakeRange(offset, 1)
                    offset += 1
                    // 如果是图片，解析出图片宽和高
                    if let imgH = Float(dic["height"] ?? "0"), let imgW = Float(dic["width"] ?? "0") {
                        m.imgWidth = CGFloat(imgH)
                        m.imgHeight = CGFloat(imgW)
                    }
                    // 是否是网络图片
                    m.isNetImage = isNetImageUrl(m.content)
                }
                // 颜色
                if let color = dic["color"] {
                    if color == "red" {
                        m.color = UIColor.red
                    } else if color == "black" {
                        m.color = UIColor.black
                    } else if color == "blue" {
                        m.color = UIColor.blue
                    } else {
                        m.color = UIColor.gray
                    }
                }
                
                // 解析跳转的url
                if let url = dic["url"], !url.isEmpty {
                    m.routerUrl = url
                }
               
                models.append(m)
            }
        }
        
        let astr = self.generateAttributedString()
        self.textStorage.setAttributedString(astr)
        let range = NSMakeRange(0, self.textStorage.length)
        self.boundingRect = self.layoutManager.boundingRect(forGlyphRange: range, in: self.textContainer)
        return self.models
    }
    
    @discardableResult
    func generateAttributedString() -> NSAttributedString {
        let final = NSMutableAttributedString(string: "")
        var offset : Int = 0
        for model in self.models {
            let font = UIFont.systemFont(ofSize: model.fontSize)
            switch model.type {
            case .text, .link:
                let range = NSMakeRange(0, model.content.count)
                let str = NSMutableAttributedString(string: model.content)
                str.addAttributes([.baselineOffset : 0], range: range)
                str.addAttributes([.foregroundColor : model.color], range: range)
                str.addAttributes([.font : font], range: range)
                final.insert(str, at: offset)
                offset += str.length
                
            case .image:
                if model.content.isEmpty == false {
                    let attachment = NSTextAttachment()
                    let h : CGFloat = model.imgHeight
                    let w : CGFloat = model.imgWidth
                    let font = UIFont.systemFont(ofSize: maxFontSize)
                    // 获取行高（font.descender 为负数，所以这里要做减法）
                    let lineHeight = font.ascender - font.descender + font.leading
                    let y = h/2 - (lineHeight / 2 + font.descender)
                    // NSTextAttachment 的坐标系是和coregraphics一样在左下角，y为0的位置是基线, 所以默认是基线对齐的
                    attachment.bounds = CGRect(x: 0, y: -y, width: w, height: h)
                    if model.isNetImage {
                        // 如果是网络图片，则生成一个展位图，之后在label上的指定位置添加一个imageView来加载网络图片
                        attachment.image = UIImage()
                    } else {
                        attachment.image = UIImage(named: model.content)
                    }
//                    attachment.image = img
                    let attachmentStr = NSAttributedString(attachment: attachment)
                    final.insert(attachmentStr, at: offset)
                    offset += attachmentStr.length
                    let frameY = h >= lineHeight ? 0 : y
                    let frame = CGRect(x: 0, y: frameY, width: w, height: h)
                    //self.imageFrameMap[model.range] = frame
                }
            }
        }
        let par = NSMutableParagraphStyle()
        par.lineBreakMode = .byCharWrapping
        final.addAttributes([.paragraphStyle : par], range: NSMakeRange(0, final.length))
        self.attributedString = final
        return final
    }
    
    private func findMaxFontSize(modelArr : [ParseResultModel]) -> CGFloat {
        let sorted = modelArr.sorted { (prevModel, currModel) -> Bool in
            return prevModel.fontSize > currModel.fontSize
        }
        return sorted.first!.fontSize
    }
    
    private func isNetImageUrl(_ url : String?) -> Bool {
        if let url = url, !url.isEmpty {
            return url.hasPrefix("http") || url.hasPrefix("https")
        }
        return false
    }

}



