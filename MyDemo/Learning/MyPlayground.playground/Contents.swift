//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

//let s = "http://www.bai#d%[u].co@m?name:=1&i*d=(999)";
let s = "http://www.baid@u.com?[]name=1&id=999";

//let comp = URLComponents(string: s)!
//let res = comp.percentEncodedQuery.map { $0 + "+" }
//let dic : [String : String] = ["c" : "3", "b" : "2", "a" : "1", "d" : "4"]
//let dic1 = dic.sorted { (item1, item2) -> Bool in
//    return item1.key < item2.key
//}
//dic
//dic1

//let generalDelimitersToEncode = ":#[]@"
//let subDelimitersToEncode = "!$&'()*+,;="
//var set = CharacterSet.urlQueryAllowed
//set.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
//let news = s.addingPercentEncoding(withAllowedCharacters: set)
//news

let queue = DispatchQueue.global()

