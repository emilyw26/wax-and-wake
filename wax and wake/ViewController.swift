//
//  ViewController.swift
//  wax and wake
//
//  Created by Mary Ruth (MR) Ngo on 3/27/18.
//  Copyright © 2018 MR Ngo. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    @IBOutlet weak var sunMoon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = SKView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var skView: SKView {
        return view as! SKView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let scene = SKScene(size: CGSize(width: 1024, height: 768))
    override func viewWillAppear(_ animated: Bool) {
        skView.presentScene(scene)
    }
    

//    var movableNode : SKNode?
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            let location = touch.locationInNode(self)
//            if ball.containsPoint(location) {
//                movableNode = ball
//                movableNode!.position = location
//            }
//        }
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first where movableNode != nil {
//            movableNode!.position = touch.locationInNode(self)
//        }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first where movableNode != nil {
//            movableNode!.position = touch.locationInNode(self)
//            movableNode = nil
//        }
//    }
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            movableNode = nil
//        }
//    }


}

