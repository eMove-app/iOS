//
//  OpenSansSwift.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import UIKit
import CoreText

@objc protocol UIFontOpenSans {
    
    static func openSansFontOfSize(_ size: Float) -> UIFont!
    
    static func openSansBoldFontOfSize(_ size: Float) -> UIFont!
    
    static func openSansBoldItalicFontOfSize(_ size: Float) -> UIFont!
    
    static func openSansExtraBoldFontOfSize(_ size: Float) -> UIFont!
    
    static func openSansExtraBoldItalicFontOfSize(_ size: Float) -> UIFont!
    
    static func openSansItalicFontOfSize(_ size: Float) -> UIFont!
    
    static func openSansLightFontOfSize(_ size: Float) -> UIFont!
    
    static func openSansLightItalicFontOfSize(_ size: Float) -> UIFont!
    
    static func openSansSemiboldFontOfSize(_ size: Float) -> UIFont!
    
    static func openSansSemiboldItalicFontOfSize(_ size: Float) -> UIFont!
    
}

extension UIFont: UIFontOpenSans {
    
    public class func openSansFontOfSize(_ size: Float) -> UIFont! {
        return UIFont(name: "OpenSans", size: makeSize(size))
    }
    
    public class func openSansBoldFontOfSize(_ size: Float) -> UIFont! {
        return UIFont(name: "OpenSans-Bold", size: makeSize(size))
    }
    
    public class func openSansBoldItalicFontOfSize(_ size: Float) -> UIFont! {
        return UIFont(name: "OpenSans-BoldItalic", size: makeSize(size))
    }
    
    public class func openSansExtraBoldFontOfSize(_ size: Float) -> UIFont! {
        return UIFont(name: "OpenSans-Extrabold", size: makeSize(size))
    }
    
    public class func openSansExtraBoldItalicFontOfSize(_ size: Float) -> UIFont! {
        return UIFont(name: "OpenSans-ExtraboldItalic", size: makeSize(size))
    }
    
    public class func openSansItalicFontOfSize(_ size: Float) -> UIFont! {
        return UIFont(name: "OpenSans-Italic", size: makeSize(size))
    }
    
    public class func openSansLightFontOfSize(_ size: Float) -> UIFont! {
        return UIFont(name: "OpenSans-Light", size: makeSize(size))
    }
    
    public class func openSansLightItalicFontOfSize(_ size: Float) -> UIFont! {
        return UIFont(name: "OpenSansLight-Italic", size: makeSize(size))
    }
    
    public class func openSansSemiboldFontOfSize(_ size: Float) -> UIFont! {
        return UIFont(name: "OpenSans-Semibold", size: makeSize(size))
    }
    
    public class func openSansSemiboldItalicFontOfSize(_ size: Float) -> UIFont! {
        return UIFont(name: "OpenSans-SemiboldItalic", size: makeSize(size))
    }
    
    class func makeSize(_ size: Float) -> CGFloat {
        return CGFloat(size)
    }
    
}

open class OpenSans {
    
    /// scale factor for retina devices. Default 2.0
    open static var retinaScaleFactor: Float = 2.0
    
    open class func registerFonts() -> Bool {
        let fontNames = [
            "OpenSans-Regular",
            "OpenSans-Bold",
            "OpenSans-BoldItalic",
            "OpenSans-ExtraBold",
            "OpenSans-ExtraBoldItalic",
            "OpenSans-Italic",
            "OpenSans-Light",
            "OpenSans-LightItalic",
            "OpenSans-Semibold",
            "OpenSans-SemiboldItalic"
        ]
        
        var error: Unmanaged<CFError>? = nil
        
        for font in fontNames {
            let url = Bundle(for: OpenSans.self).url(forResource: font, withExtension: "ttf")
            if url != nil {
                CTFontManagerRegisterFontsForURL(url! as CFURL, CTFontManagerScope.none, &error)
            }
        }
        
        return error == nil
    }
}
