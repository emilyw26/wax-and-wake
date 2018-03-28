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

protocol GameDelegate {
    func addAlarm()
}

class Alarm {
    var time: String
    var timeIndex: Int
    var dayIndex: Int
    
    init(time: String, timeIndex: Int, dayIndex: Int) {
        self.time = time
        self.timeIndex = timeIndex
        self.dayIndex = dayIndex
    }
}

class GameViewController: UIViewController, CanReceive {
    var timeNode: SKNode?
    var gameDelegate: GameDelegate?
    var alarms = [Alarm]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // set up delegate
                gameDelegate = scene as? GameDelegate
                
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
                destinationVC.delegete = self
            } else {
                destinationVC.timeValuePassedOver = "Unsuccessful"
            }
        }
    }
    
    func addAlarm(timeStamp: String, timeOfDayIndex: Int, dayOfWeekIndex: Int) {
        alarms.append(Alarm(time: timeStamp, timeIndex: timeOfDayIndex, dayIndex: dayOfWeekIndex))
        gameDelegate?.addAlarm()
        print(String(describing: alarms))
    }
    
    func receiveData(data: [String: Int]) {
        var time = "12:00"
        var timeOfDay = 0
        var dayOfWeek = 0
        
        if let timeLabelNode = timeNode as? SKLabelNode {
        time = timeLabelNode.text!
        }
        if let timeIndex = data["timOfDay"] {
        timeOfDay = timeIndex
        }
        if let dayIndex = data["dayOfWeek"] {
        dayOfWeek = dayIndex
        }
        addAlarm(timeStamp: time, timeOfDayIndex: timeOfDay, dayOfWeekIndex: dayOfWeek)
        
    }
}
