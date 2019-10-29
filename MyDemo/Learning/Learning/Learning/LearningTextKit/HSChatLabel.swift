//
//  HSChatLabel.swift
//  Learning
//
//  Created by FN-273 on 2019/5/13.
//  Copyright © 2019 ZhengYi. All rights reserved.
//

import UIKit
import SDWebImage

class HSChatLabel: UILabel {
    
    typealias ClickHandlerType = (_ model : ParseResultModel) -> Void
    
    var clickHandler : ClickHandlerType?
    
    private(set) var textStorage : NSTextStorage!
    private(set) var textContainer : NSTextContainer?
    private(set) var layoutManager : NSLayoutManager?
    private(set) var parser : HSTextParser?
    private(set) var imageViewMap : [NSRange : UIImageView] = [:]
    
    
    convenience init(frame : CGRect = .zero, parser : HSTextParser) {
        self.init(frame: .zero)
        self.setParser(parser)
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
    }
    
    func setParser(_ parser : HSTextParser, autoDraw : Bool = true) {
        self.parser = parser
        self.textStorage = parser.textStorage
        self.layoutManager = textStorage.layoutManagers.first
        self.textContainer = self.layoutManager?.textContainers.first
        self.setupImageViews()
        if autoDraw {
            self.setNeedsDisplay()            
        }
    }

    func setupImageViews() {
        guard let parser = self.parser,
            let layoutManager = self.layoutManager,
            let container = self.textContainer else {
            return
        }
        
        for model in parser.models {
            if model.type == .image && model.isNetImage {
                let range = model.range
                let imgView = UIImageView()
                let boundingRect = layoutManager.boundingRect(forGlyphRange: range, in: container)
                var y : CGFloat = boundingRect.origin.y
                if model.imgHeight < boundingRect.size.height {
                    y = boundingRect.origin.y + (boundingRect.size.height - model.imgHeight) / 2
                }
                imgView.frame = CGRect(x: boundingRect.origin.x, y: y, width: model.imgWidth, height: model.imgHeight)
                imgView.backgroundColor = UIColor.white
                self.addSubview(imgView)
                self.imageViewMap[range] = imgView
                if let url = URL(string: model.content) {
                    imgView.sd_setImage(with: url) { (_, _, _, _) in
                        
                    }
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func drawText(in rect: CGRect) {
        if let layoutManager = layoutManager {
            let range = NSMakeRange(0, textStorage.length)
            layoutManager.drawGlyphs(forGlyphRange: range, at: .zero)
            layoutManager.drawBackground(forGlyphRange: range, at: .zero)
        }
    }
    
    override var attributedText: NSAttributedString? {
        didSet {
            if let t = attributedText {
                self.textStorage.setAttributedString(t)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first,
            let layoutManager = self.layoutManager,
            let textContainer = self.textContainer,
            let parser = self.parser else { return }
        let point = touch.location(in: self)
        let index = layoutManager.glyphIndex(for: point, in: textContainer)
        //let rect  = layoutManager.boundingRect(forGlyphRange: NSMakeRange(index, 1), in: textContainer)
        let charIndex = layoutManager.characterIndexForGlyph(at: index)
        let modelsOnTouch = parser.models.filter { (model) -> Bool in
            return NSLocationInRange(charIndex, model.range)
        }
        if !modelsOnTouch.isEmpty {
            let model = modelsOnTouch.first!
            clickHandler?(model)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
