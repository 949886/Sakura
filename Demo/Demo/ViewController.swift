//
//  ViewController.swift
//  Demo
//
//  Created by LunarEclipse on 2016/11/25.
//  Copyright © 2016 Sakura. All rights reserved.
//

import UIKit
import Sakura

extension Progress
{
    var parent: Progress? {
        
        return (self as NSObject).value(forKey: "_parent") as? Progress
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var separator: UISeparator!
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("氷菓".pinyin)
        textField.placeholderColor = UIColor.red
        separator.patternString = "20,20"
        separator.pattern = [10, 10, 123]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(3000)) {
            self.label.text = "ddd"
            self.greenLabel.text = "xxx"
            self.greenLabel.setNeedsDisplay()
            self.view.setNeedsDisplay()
        }
        
        print("STRING \("abc".subString(from: 1, to: 2))")
        
        button.textLayout = .bottom
        button.textLayoutSpacing = 20

//        UIApplication.shared.launchImage(forOrientation: .landscape)
        
        let color = UIColor(hexString: "#FE960E")
        self.view.backgroundColor = color
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        let controller = UIWebViewController(url: "http://cs.bukamanhua.com:8000/event/movie_ticket.php")
//        controller.redirector = ["" : self.handler]
//        self.present(controller, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func handler(url: URL, parameters:[String:String]?) {
        let redirectURL = URLComponents(string: url.absoluteString)?.queryItems?.filter{ $0.name == "redirect_url" }.first?.value
        debugPrint("HHHH: \(String(describing: redirectURL))")
    }
    
}

