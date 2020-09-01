//
//  ViewController.swift
//  day06
//
//  Created by Julia SEMYZHENKO on 10/8/19.
//  Copyright © 2019 Julia SEMYZHENKO. All rights reserved.
//

import UIKit
import CoreMotion

let elasticity: CGFloat = 0.5;

class ViewController: UIViewController {
	var motionManager = CMMotionManager();
	var animator: UIDynamicAnimator?;
	var gravity: UIGravityBehavior?;
	var collisions: UICollisionBehavior?;
	var itemBehavior: UIDynamicItemBehavior?;
	
	@IBAction func detectTapGesture(_ sender: UITapGestureRecognizer) {
		let shapeView = ShapeView(origin: sender.location(in: self.view));
		self.view.addSubview(shapeView);
		self.gravity?.addItem(shapeView);
		self.collisions?.addItem(shapeView);
		self.itemBehavior?.addItem(shapeView);
		
		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panning));
		shapeView.addGestureRecognizer(panGesture);
		
		let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinching));
		shapeView.addGestureRecognizer(pinchGesture);
		
		let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotating));
		shapeView.addGestureRecognizer(rotationGesture);
	}
	
	@objc func rotating(rotationGesture: UIRotationGestureRecognizer) {
		switch rotationGesture.state {
		case .began:
			self.gravity?.removeItem(rotationGesture.view!);
		case .changed:
			self.collisions?.removeItem(rotationGesture.view!);
			self.itemBehavior?.removeItem(rotationGesture.view!);
			rotationGesture.view!.transform = rotationGesture.view!.transform.rotated(by: rotationGesture.rotation);
			rotationGesture.rotation = 0;
			self.collisions?.addItem(rotationGesture.view!);
			self.itemBehavior?.addItem(rotationGesture.view!);
			self.animator?.updateItem(usingCurrentState: rotationGesture.view!);
		case .ended:
			self.gravity?.addItem(rotationGesture.view!);
		default:
			break ;
		}
	}
	
	@objc func pinching(pinchGesture: UIPinchGestureRecognizer) {
		let view = pinchGesture.view as! ShapeView;
		
		switch pinchGesture.state {
		case .began:
			self.gravity?.removeItem(view);
		case .changed:
			self.collisions?.removeItem(view);
			self.itemBehavior?.removeItem(view);
			view.bounds.size.width = view.originalBounds.width * pinchGesture.scale;
			view.bounds.size.height = view.originalBounds.height * pinchGesture.scale;
			self.collisions?.addItem(view);
			self.itemBehavior?.addItem(view);
			self.animator?.updateItem(usingCurrentState: view);
		case .ended:
			view.originalBounds = view.bounds;
			self.gravity?.addItem(view);
		default:
			break ;
		}
	}

	@objc func panning(panGesture: UIPanGestureRecognizer) {
		switch panGesture.state {
		case .began:
			self.gravity?.removeItem(panGesture.view!);
		case .changed:
			panGesture.view?.center = panGesture.location(in: self.view);
			self.animator?.updateItem(usingCurrentState: panGesture.view!);
		case .ended:
			self.gravity?.addItem(panGesture.view!);
		default:
			break ;
		}
	}
	
	func handleAccelerometerUpdate(data: CMAccelerometerData?, error: Error?) -> Void {
		if let d = data {
			self.gravity!.gravityDirection = CGVector(dx: d.acceleration.x, dy: -d.acceleration.y);
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		animatorInit();
		motionManagerInit();
	}
	
	func motionManagerInit() {
		if (motionManager.isAccelerometerAvailable) {
			motionManager.accelerometerUpdateInterval = 1;
			motionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: handleAccelerometerUpdate);
		}
	}

	func animatorInit() {
		animator = UIDynamicAnimator(referenceView: self.view);
		addGravity();
		addCollisions();
		addItemBehavior();
	}
	
	func addGravity() {
		self.gravity = UIGravityBehavior(items: []);
		self.gravity!.gravityDirection = CGVector(dx: 0.0, dy: 1.0);
		self.animator?.addBehavior(self.gravity!);
	}
	
	func addCollisions() {
		self.collisions = UICollisionBehavior(items: []);
		self.collisions!.translatesReferenceBoundsIntoBoundary = true;
		self.animator?.addBehavior(self.collisions!);
	}
	
	func addItemBehavior() {
		self.itemBehavior = UIDynamicItemBehavior(items: []);
		self.itemBehavior?.elasticity = elasticity;
		animator?.addBehavior(self.itemBehavior!);
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

