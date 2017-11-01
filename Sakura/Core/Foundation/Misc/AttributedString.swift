//
//  AttributedString.swift
//  Sakura
//
//  Created by YaeSakura on 2017/7/14.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

open class AttributedString: NSMutableAttributedString
{

}

#if swift(>=4)
#else

public struct NSAttributedStringKey
{
    /************************ Attributes ************************/
    @available(iOS 6.0, *) public static let font = NSFontAttributeName
    @available(iOS 6.0, *) public static let paragraphStyle = NSParagraphStyleAttributeName
    @available(iOS 6.0, *) public static let foregroundColor = NSForegroundColorAttributeName
    @available(iOS 6.0, *) public static let backgroundColor = NSBackgroundColorAttributeName
    @available(iOS 6.0, *) public static let ligature = NSBackgroundColorAttributeName
    @available(iOS 6.0, *) public static let kern = NSKernAttributeName
    @available(iOS 6.0, *) public static let strikethroughStyle = NSStrikethroughStyleAttributeName
    @available(iOS 6.0, *) public static let underlineStyle = NSUnderlineStyleAttributeName
    @available(iOS 6.0, *) public static let strokeColor = NSStrokeColorAttributeName
    @available(iOS 6.0, *) public static let strokeWidth = NSStrokeWidthAttributeName
    @available(iOS 6.0, *) public static let shadow = NSShadowAttributeName
    @available(iOS 7.0, *) public static let textEffect = NSTextEffectAttributeName
    @available(iOS 7.0, *) public static let attachment = NSAttachmentAttributeName
    @available(iOS 7.0, *) public static let link = NSLinkAttributeName
    @available(iOS 7.0, *) public static let baselineOffset = NSBaselineOffsetAttributeName
    @available(iOS 7.0, *) public static let underlineColor = NSUnderlineColorAttributeName
    @available(iOS 7.0, *) public static let strikethroughColor = NSStrikethroughColorAttributeName
    @available(iOS 7.0, *) public static let obliqueness = NSObliquenessAttributeName
    @available(iOS 7.0, *) public static let expansion = NSExpansionAttributeName
    @available(iOS 7.0, *) public static let writingDirection = NSWritingDirectionAttributeName
    @available(iOS 6.0, *) public static let verticalGlyphForm = NSVerticalGlyphFormAttributeName
}

#endif
