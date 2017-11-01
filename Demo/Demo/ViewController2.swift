//
//  ViewController2.swift
//  Demo
//
//  Created by YaeSakura on 2017/5/16.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import UIKit
import Sakura

class ViewController2: UIViewController
{

    @IBOutlet weak var button: UIButtonEx!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        UIApplication.shared.jump(to: .safari("http://www.baidu.com"))
//        UIApplication.shared.jump(to: .setting(.twitter))
        UIApplication.shared.jump(to: .call(10086))
        
//        let image = UIImage(named: "huaji")
//        let color = image?.getColor(atPixel: CGPoint(x: 29, y: 29))
        
//        button.layer.cornerRadius = 15
//        button.layer.shadowOffset = .zero
        
//        button.setTitleColor(UIColor.lightGray, for: .normal)
//        button.setTitleColor(UIColor.gray, for: .highlighted)
//        button.setTitleColor(UIColor.gray, for: .selected)
//        button.setBackgroundColor(UIColor.white, for: .normal)
//        button.setBackgroundColor(UIColor.lightGray, for: .highlighted)
//        button.setBackgroundColor(UIColor.lightGray, for: .selected)
//        button.setBorderColor(UIColor.gray, for: .normal)
//        button.setBorderColor(UIColor.lightGray, for: .highlighted)
//        button.setBorderColor(UIColor.lightGray, for: .selected)
//        button.setShadowColor(UIColor.gray, for: .normal)
//        button.setShadowColor(UIColor.orange, for: .highlighted)
//        button.setShadowColor(UIColor.orange, for: .selected)
        
//        button.cornerRadius = (15, 0, 0, 15)
//        button.backgroundColor = .orange
//        button.extraHitInsets = UIEdgeInsetsMake(999, 999, 999, 999)
        
//        if #available(iOS 10.0, *) {
//            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
//                timer in
//                self.button.setTitle(String.init(repeating: "C", count: Int(timer.timeElapsed)), for: .normal)
//            }
//        } else {
//            // Fallback on earlier versions
//        }
        
//        let bundle = Bundle(for: type(of: self))
//        guard let url = bundle.url(forResource: "test.txt", withExtension: "gz") else { return }
//        let data = try! Data(contentsOf: url)
//        if let uncompressed = data.ungzip() {
//            let string = String(data: uncompressed, encoding: .utf8)
//            print(string)
//        }
        
//        let compressed = "TEST".data(using: .utf8)?.gzip()
//        if let uncompressed = compressed?.ungzip() {
//            let string = String(data: uncompressed, encoding: .utf8)
//            print(string)
//        }
        
//        let dict1 = ["a":"a"]
//        let dict2 = ["b":dict1]
//        let str = dict2.value(forKeyPath: "b")
//        print("\(str)")
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        button.setTitle("Dismiss", for: .normal)
        button.addTarget(self, action: #selector(onClickButton(_:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @IBAction func onClickButton(_ sender: UIToggle) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
