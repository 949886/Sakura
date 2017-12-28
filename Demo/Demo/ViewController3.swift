//
//  ViewController3.swift
//  Demo
//
//  Created by YaeSakura on 2017/6/21.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import UIKit
import Sakura

class ViewController3: UIViewController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
    }
    
    @IBAction func onButtonClick(_ sender: Any) {
//        self.navigationController?.popViewController(animated: false, completion: {
//            print("test")
//        })
//        self.navigationController?.push(ViewController3(), animation: .default)
        let controller = ViewController2()
        controller.view.backgroundColor = .clear
        controller.modalPresentationStyle = .overCurrentContext
        self.navigationController?.push(controller, animation: .fade(duration: 0.5), completion: {
            print("test")
            self.navigationController?.delegate = self
        })
    }
    
    @IBAction func onPresentButtonClick(_ sender: UIButton) {
        let controller = ViewController2()
        controller.view.backgroundColor = .orange
        controller.transitionAnimation = .fade(duration: 0.5)
        self.present(controller, animated: true, completion: nil)
//        self.present(controller, animation: .fade(duration: 0.5))
//        self.navigationController?.push(controller, animation: .fade(duration: 0.5), completion: {
//            print("test")
//        })
    }
    
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        print("willshow")
    }
}
