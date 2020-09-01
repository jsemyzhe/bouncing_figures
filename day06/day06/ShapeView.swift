//
//  ShapeView.swift
//  day06
//
//  Created by Julia SEMYZHENKO on 10/8/19.
//  Copyright © 2019 Julia SEMYZHENKO. All rights reserved.
//

import Foundation
import UIKit

let squareCornerRadius: CGFloat = 5.0;

class ShapeView: UIView {
	var shape: Shape?;
	var color: Color?;
	var bezierPath: UIBezierPath?;
	var originalBounds: CGRect!;

	override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
		return (.path);
	}

	override var collisionBoundingPath: UIBezierPath {
		switch self.shape! {
		case .Circle:
			return (getCircleCollisionPath());
		case .Square:
			return (getSquareCollisionPath());
		}
	}

	func getSquareCollisionPath() -> UIBezierPath {
		return UIBezierPath(roundedRect: CGRect(
			x: -self.bounds.width / 2.0,
			y: -self.bounds.height / 2.0,
			width: self.bounds.width,
			height: self.bounds.height
		), cornerRadius: squareCornerRadius);
	}
	
	func getCircleCollisionPath() -> UIBezierPath {
		let radius = min(self.bounds.size.width, self.bounds.size.height) / 2.0;

		return UIBezierPath(arcCenter: CGPoint.zero, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true);
	}
	
	func createSquare(rect: CGRect) {
		self.bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: squareCornerRadius);
	}
	
	func createCircle(rect: CGRect) {
		self.bezierPath = UIBezierPath(ovalIn: rect);
	}
	
	override func draw(_ rect: CGRect) {
		switch self.shape! {
		case .Circle:
			self.createCircle(rect: rect);
		case .Square:
			self.createSquare(rect: rect);
		}
		UIColor(id: self.color!.rawValue).setFill();
		self.bezierPath!.fill();
	}
	
	init(origin: CGPoint) {
		self.shape = Shape.allShapes[Int(arc4random_uniform(UInt32(Shape.allShapes.count)))];
		self.color = Color.allColors[Int(arc4random_uniform(UInt32(Color.allColors.count)))];
		super.init(frame: CGRect(x: origin.x - 50, y: origin.y - 50, width: 100, height: 100));
		self.originalBounds = self.bounds;
		self.backgroundColor = UIColor.clear;
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame);
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder);
	}
}
