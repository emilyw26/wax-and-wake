//
//  GameViewController.swift
//  DiveIntoSpriteKit
//
//  Created by Paul Hudson on 16/10/2017.
//  Copyright © 2017 Paul Hudson. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var timeNode: SKNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }

            view.preferredFramesPerSecond = 120
            timeNode = view.scene!.children[3]
        }
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func addAlarm(_ sender: Any) {
        performSegue(withIdentifier: "goToAddAlarmVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAddAlarmVC" {
            let destinationVC = segue.destination as! AddAlarmViewController
            if let timeLabelNode = timeNode as? SKLabelNode {
                destinationVC.timeValuePassedOver = timeLabelNode.text!
            } else {
                destinationVC.timeValuePassedOver = "Unsuccessful"
            }
        }
    }
}
