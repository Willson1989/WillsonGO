//
//  MyPlayerVC.swift
//  LearningAVPlayer
//
//  Created by WillHelen on 2019/3/30.
//  Copyright © 2019年 WillHelen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AVFoundation

class MyPlayerVC: UIViewController {
    
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var progressView: MyProgressView!
    private var playOb : Observable<Void>!
    
    private var player : AVPlayer!
    private var playItem : AVPlayerItem!
    private var playPercentOb : Observable<Float>!
    
    private var _disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPlayer()
        configSubviews()
        bindProgress()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    private func configSubviews() {
        
        self.playButton.rx.tap
        .skipUntil(self.playOb)
        .throttle(1, scheduler: MainScheduler.instance)
        .map({ [weak self](_) -> Bool in
            guard let wself = self else { return false }
            wself.playButton.isSelected = !wself.playButton.isSelected;
            return wself.playButton.isSelected;
        })
        .subscribe(onNext: { [weak self] (shouldPlay) in
            guard let wself = self else { return }
            wself.playOrPause(shouldPlay)
        })
        .disposed(by: _disposeBag)
    }
    
    private func playOrPause(_ shouldPlay : Bool) {
        if shouldPlay {
            self.player.play()
        } else {
            self.player.pause()
        }
    }
    
    private func initPlayer() {
        self.playOb = Observable<Void>.create { [unowned self](ob) -> Disposable in
            let dis = Disposables.create()
            guard let localVideoPath = Bundle.main.path(forResource: "tempVideo", ofType: "mp4") else {
                return dis
            }
            let url = URL(fileURLWithPath: localVideoPath, isDirectory: true)
            let asset = AVAsset(url: url)
            let item = AVPlayerItem(asset: asset)
            let player = AVPlayer(playerItem: item)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.bounds = self.playView.bounds
            playerLayer.position = CGPoint(x: self.playView.bounds.size.width/2,
                                           y: self.playView.bounds.size.height/2)
            self.playView.layer.addSublayer(playerLayer)
            self.player = player
            self.playItem = item
            ob.onNext(())
            return dis
        }
    }
    
    private func bindProgress() {
        self.playPercentOb = Observable<Float>.create {
            [weak self](ob) -> Disposable in
            let dispose = Disposables.create()
            guard let wself = self else { return dispose }
            let cmInterval = CMTime(value: 1, timescale: 2)
            let duration = wself.playItem.asset.duration
            wself.player.addPeriodicTimeObserver(forInterval: cmInterval, queue: nil) { (time) in
                let percent = Float(time.seconds / duration.seconds)
                ob.onNext(percent)
            }
            return dispose
        }
        let bindingProgress = self.progressView.rx.bindingProgress
        self.playPercentOb.bind(to: bindingProgress).disposed(by: _disposeBag)
        bindingProgress.bind { [weak self](progress) in
            guard let wself = self else { return }
            let total = wself.playItem.asset.duration
            let progressFloat64 = Float64(progress)
            let new = CMTimeMultiplyByFloat64(total, multiplier: progressFloat64)
            wself.playItem.seek(to: new, completionHandler: nil)
        }.disposed(by: self._disposeBag)
    }

    deinit {
        print("player vc deinit !!!")
    }
}


class MyProgressView : UIControl {
    
    public var progress : Float {
        set(newValue) {
            let x = (self.frame.size.width - self.btnSize) * CGFloat(newValue) + self.btnSize/2
            self.positionBtn(CGPoint(x: x, y: self.frame.size.height/2))
        }
        
        get {
            return self.barView.progress
        }
    }
    
    lazy var barView : UIProgressView = {
        let pv = UIProgressView(progressViewStyle: UIProgressView.Style.default)
        pv.backgroundColor = .lightGray
        pv.tintColor = .blue
        return pv
    }()

    lazy var btn : UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.borderColor = UIColor.gray.cgColor
        v.layer.borderWidth = 1
        return v
    }()
    
    lazy var pan : UIPanGestureRecognizer = {
        let p = UIPanGestureRecognizer()
        self.btn.addGestureRecognizer(p)
        return p
    }()
    
    lazy var tap : UITapGestureRecognizer = {
        let p = UITapGestureRecognizer()
        self.addGestureRecognizer(p)
        return p
    }()
    
    
    private var disposeBag = DisposeBag()
    private var btnSize : CGFloat {
        return self.frame.size.height/1.5
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    override func awakeFromNib() {
        commonInit()
    }
    
    private var hasInit : Bool = false
    private func commonInit() {
        if hasInit {
            return
        }
        hasInit = true
        addSubview(barView)
        addSubview(btn)
        let panEvent = self.pan.rx.event
        panEvent.bind { [weak self](pan) in
            guard let wself = self else { return }
            wself.positionBtn(pan.location(in: wself))
        }.disposed(by: self.disposeBag)
        
        let tapEvent = self.tap.rx.event
        tapEvent.bind { [weak self](tap) in
            guard let wself = self else { return }
            wself.positionBtn(tap.location(in: wself))
        }.disposed(by: self.disposeBag)
    }
    
    private func positionBtn(_ p : CGPoint) {
        var centerX : CGFloat = 0
        if p.x - btnSize/2 < 0 {
            centerX = btnSize/2
        } else if p.x + btnSize/2 > frame.size.width {
            centerX = frame.size.width - btnSize/2
        } else {
            centerX = p.x
        }
        let progress = (centerX - btnSize/2) / (frame.size.width - btnSize)
        barView.progress = Float(progress)
        btn.center = CGPoint(x: centerX, y: btn.center.y)
        self.sendActions(for: UIControlEvents.valueChanged)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        barView.frame = CGRect(x: 0, y: 0, width: frame.size.width - btnSize, height: frame.size.height / 3)
        barView.center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        btn.frame = CGRect(x: 0, y: 0, width: btnSize, height: btnSize)
        btn.center = CGPoint(x: btnSize, y: frame.size.height/2)
        btn.layer.cornerRadius = btnSize/2
    }
}

extension Reactive where Base : MyProgressView {
    
    var bindingProgress : ControlProperty<Float> {
        return self.base.rx.controlProperty(editingEvents: UIControlEvents.valueChanged, getter: { (control) -> Float in
            return control.progress
        }) { (control, value) in
            control.progress = value
        }
    }
    
}
