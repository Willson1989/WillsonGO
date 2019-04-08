//
//  RXSearchListVC.swift
//  Learning
//
//  Created by WillHelen on 2019/3/22.
//  Copyright © 2019年 ZhengYi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RXSearchListVC: UIViewController {
    
    typealias Section = SectionModel<String, String>
    typealias ConfigCells = RxTableViewSectionedReloadDataSource<Section>.ConfigureCell
    typealias DataSource = RxTableViewSectionedReloadDataSource<Section>
    typealias SectionObservable = Observable<[Section]>
    
    typealias ChannelSection = SectionModel<String, ChannelInfo>
    typealias ChannelDataSource = RxTableViewSectionedReloadDataSource<ChannelSection>
    typealias ChannelCells = ChannelDataSource.ConfigureCell
    typealias ChannelSectionObservable = Observable<[ChannelSection]>

    
    let bag = DisposeBag()
    lazy var tableView : UITableView = {
        let tb = UITableView(frame: .zero, style: UITableView.Style.plain)
        tb.separatorStyle = .none
        tb.backgroundColor = UIColor.white
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
        self.view.addSubview(tb)
        return tb
    }()
    
    lazy var textField : UITextField = {
        let tf = UITextField()
        tf.borderStyle = UITextField.BorderStyle.bezel
        self.view.addSubview(tf)
        tf.backgroundColor = .lightGray
        return tf
    }()
    
    lazy var refreshButton : UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .blue
        btn.setTitle("刷新", for: UIControl.State.normal)
        btn.setTitle("刷新", for: UIControl.State.selected)
        self.view.addSubview(btn)
        return btn
    }()
    
    lazy var cancelButton : UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .orange
        btn.setTitle("取消", for: UIControl.State.normal)
        btn.setTitle("取消", for: UIControl.State.selected)
        self.view.addSubview(btn)
        return btn
    }()
    
    var dataSource : DataSource!
    var channelDataSource : ChannelDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.placeViews()
        self.requestData()
    }
    
    private func requestData() {
        let urlString = "https://www.douban.com/j/app/radio/channels"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        
        let session = URLSession.shared.rx.json(request: request).flatMapLatest { (json) -> ChannelSectionObservable in
            if let resDic = json as? [String : Any],
                let channels = resDic["channels"] as? [[String : Any]] {
                let items = channels.map({ (dic) -> ChannelInfo in
                    return ChannelInfo(name: (dic["name"] as? String) ?? "",
                                       name_en: (dic["name_en"] as? String) ?? "")
                })
                return ChannelSectionObservable.just([ChannelSection(model: "0", items: items)])
            }
            return ChannelSectionObservable.just([])
        }
        
        let configCell : ChannelCells = {
            (ds, tb, ip, item) in
            let cell = tb.dequeueReusableCell(withIdentifier: "cellid")!
            cell.textLabel?.text = item.name
            return cell
        }
        self.channelDataSource = ChannelDataSource(configureCell: configCell)
        session.bind(to: self.tableView.rx.items(dataSource: self.channelDataSource)).disposed(by: self.bag)
    }
    
    func config_1() {
        let configCell : ConfigCells = {
            (ds, tb, ip, item) in
            let cell = tb.dequeueReusableCell(withIdentifier: "cellid", for: ip)
            cell.textLabel?.text = item
            return cell
        }
        self.dataSource = DataSource(configureCell:configCell)
        
        let tap = self.refreshButton.rx.tap
        tap
            .throttle(1, scheduler: MainScheduler.instance)
            .startWith(())
            .flatMapLatest(mapTapToSectionModels)
            .flatMapLatest(mapToInputAndFilter)
            .bind(to: self.tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.bag)
    }
    
    func mapTapToSectionModels() -> SectionObservable {
        var items = [String]()
        for _ in 0 ..< 9 {
            items.append("No. " + String(Int(arc4random())))
        }
        let sections = [Section(model: "0", items: items)]
        return SectionObservable.just(sections).delay(0, scheduler: MainScheduler.instance).takeUntil(self.cancelButton.rx.tap)
    }
    
    func mapToInputAndFilter(_ sections : [Section]) -> SectionObservable {
        let txt = self.textField.rx.text.orEmpty
        return
            txt
            .throttle(0.3, scheduler: MainScheduler.instance)
            .flatMapLatest({ (query) -> SectionObservable in
                if query.isEmpty {
                    return SectionObservable.just(sections)
                }
                var newSections = [Section]()
                for s in sections {
                    let newItems = s.items.filter({$0.contains(query)})
                    let newSection = Section(model: s.model, items: newItems)
                    newSections.append(newSection)
                }
            return SectionObservable.just(newSections)
        })
    }
    
    func placeViews() {
        self.textField.frame = CGRect(x: 0, y: 100, width: self.view.bounds.size.width-120, height: 40)
        self.refreshButton.frame = CGRect(x: self.textField.frame.maxX, y: self.textField.frame.minY, width: 60, height: 40)
        self.cancelButton.frame = CGRect(x: self.refreshButton.frame.maxX, y: self.textField.frame.minY, width: 60, height: 40)
        self.tableView.frame = CGRect(x: 0, y: self.textField.frame.maxY, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 40)
    }
}

extension RXSearchListVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

struct ChannelInfo {
    var name : String = ""
    var name_en : String = ""
}
