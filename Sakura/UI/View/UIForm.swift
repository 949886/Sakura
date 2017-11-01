//
//  UIForm.swift
//  Sakura
//
//  Created by YaeSakura on 2017/1/17.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation

//MARK: - UIForm

open class UIForm: UIView
{
    
    open func onCreate(form: inout UIForm) {
        
    }
    
    open class Section: NSObject {
        public var form: UIForm!
    }
    
    open class Row: NSObject {
        public var form: UIForm!
        
        public override init() {
            super.init()
        }
        
        public init(type: Types) {
            
        }
        
        public static func `default`(text: String) -> Row {
            return Row()
        }
        
        public static func custom(text: String) -> Row {
            return Row()
        }
        
        public func register(class: AnyClass, id: String) -> Row {
            return self
        }
        
        public func register(nib: String, id: String) -> Row {
            return self
        }
        
        public func count(_ num: UInt) -> UIForm {
            return form
        }
        
        public enum Types {
            case `default`(text: String, subtitle: String?, view: UIView?)
            case `switch`()
            case text
            case table(cell: UITableViewCell, delegate: Any?)
            case grid(cell: UICollectionViewCell, delegate: Any?)
            case custom(cell: Cell, id: String)
        }
    }
    
    open class Cell: UIView {
        
    }
    
    open class Header: NSObject {
        public var form: UIForm!
    }
    
    open class Footer: NSObject {
        public var form: UIForm!
    }
    
    fileprivate class Spacing: NSObject {
        
    }
    
    
    public typealias SimpleFuntion = (() -> Void)?
}


//MARK: - Operators


infix operator -- : UIFormPrecedence
infix operator ---- : UIFormPrecedence
infix operator ~ : UIFormPrecedence

precedencegroup UIFormPrecedence {
    associativity: left
    higherThan: AdditionPrecedence
}

@discardableResult
public func -- (section: UIForm.Section, row: UIForm.Row) -> UIForm {
    return section.form
}

public extension UIForm {
    
    @discardableResult
    public static func -- (form1: UIForm, form2: UIForm) -> UIForm {
        return form1
    }
    
    @discardableResult
    public static func -- (form: UIForm, section: Section) -> UIForm {
        return form
    }
    
    @discardableResult
    public static func -- (form: UIForm, row: Row) -> UIForm {
        return form
    }
    
    @discardableResult
    public static func -- (form: UIForm, header: Header) -> UIForm {
        return form
    }
    
    @discardableResult
    public static func -- (form: UIForm, footer: Footer) -> UIForm {
        return form
    }
    
    @discardableResult
    public static func -- (form: UIForm, height: Double) -> UIForm {
        return form
    }
    
    @discardableResult
    public static func ~ (form: UIForm, count: Int) -> UIForm {
        return form
    }
    
}

//MARK: - Delegate

public protocol UIFormDelegate
{
    
}
