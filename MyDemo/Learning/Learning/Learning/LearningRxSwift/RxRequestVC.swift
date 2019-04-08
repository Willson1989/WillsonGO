//
//  RxRequestVC.swift
//  Learning
//
//  Created by WillHelen on 2019/3/22.
//  Copyright © 2019年 ZhengYi. All rights reserved.
//

import UIKit

class RxRequestVC: UIViewController {

    lazy var tableView : UITableView = {
        let tb = UITableView(frame: .zero, style: UITableView.Style.plain)
        tb.separatorStyle = .none
        tb.backgroundColor = UIColor.white
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
        self.view.addSubview(tb)
        return tb
    }()
    
    func placeViews() {
        self.tableView.frame = CGRect(x: 0, y: 100, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 40)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeViews()
        // Do any additional setup after loading the view.
    }
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
