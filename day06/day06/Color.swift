//
//  Color.swift
//  day06
//
//  Created by Julia SEMYZHENKO on 10/8/19.
//  Copyright © 2019 Julia SEMYZHENKO. All rights reserved.
//

import Foundation
import UIKit

enum Color: Int {
	case Red = 0
	case Orange
	case Yellow
	case Green
	case Cyan
	case Blue
	case Purple
	case Pink
	static let allColors: [Color] = [Red, Orange, Yellow, Green, Cyan, Blue, Purple, Pink];
	static let myColors: [UIColor] = [UIColor.myRed, UIColor.myOrange, UIColor.myYellow, UIColor.myGreen, UIColor.myCyan, UIColor.myBlue, UIColor.myPurple, UIColor.myPink];
}

extension UIColor {
	static var myRed: UIColor { return UIColor(red:1.00, green:0.23, blue:0.19, alpha:1.0) }
	static var myOrange: UIColor { return UIColor(red:1.00, green:0.58, blue:0.00, alpha:1.0) }
	static var myYellow: UIColor { return UIColor(red:1.00, green:0.80, blue:0.00, alpha:1.0) }
	static var myGreen: UIColor { return UIColor(red:0.30, green:0.85, blue:0.39, alpha:1.0) }
	static var myCyan: UIColor { return UIColor(red:0.35, green:0.78, blue:0.98, alpha:1.0) }
	static var myBlue: UIColor { return UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0) }
	static var myPurple: UIColor { return UIColor(red:0.35, green:0.34, blue:0.84, alpha:1.0) }
	static var myPink: UIColor { return UIColor(red:1.00, green:0.18, blue:0.33, alpha:1.0) }

	var redValue: CGFloat { return CIColor(color: self).red }
	var greenValue: CGFloat { return CIColor(color: self).green }
	var blueValue: CGFloat { return CIColor(color: self).blue }
	var alphaValue: CGFloat { return CIColor(color: self).alpha }

	convenience init(id: Int) {
		self.init(
			red: Color.myColors[id].redValue,
			green: Color.myColors[id].greenValue,
			blue: Color.myColors[id].blueValue,
			alpha: Color.myColors[id].alphaValue
		);
	}
}
