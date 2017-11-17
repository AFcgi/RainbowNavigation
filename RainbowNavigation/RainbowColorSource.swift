//
//  LLRainbowColorSource.swift
//  Pods
//
//  Created by Danis on 15/11/25.
//
//

@objc public protocol RainbowColorSource {
    @objc optional func navigationBarInColor() -> UIColor
    @objc optional func navigationBarOutColor() -> UIColor
	
	// added by cgi
	@objc optional func statusBarInMaskColor() -> UIColor
	@objc optional func statusBarOutMaskColor() -> UIColor
	@objc optional func tintInColor() -> UIColor
	@objc optional func tintOutColor() -> UIColor
}

@objc public protocol RainbowNavigationMutable {
    @objc optional func currentNavigationBarColor() -> UIColor
}
