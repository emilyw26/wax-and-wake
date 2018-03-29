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
    func deleteAlarm()
}

class Alarm {
    var time: String
    var timeIndex: Int
    var dayIndex: Int
    var rowIndex: Int
    
    init(time: String, timeIndex: Int, dayIndex: Int, rowIndex: Int) {
        self.time = time
        self.timeIndex = timeIndex
        self.dayIndex = dayIndex
        self.rowIndex = rowIndex
    }
}

class GameViewController: UIViewController, CanReceive {
    
    var timeNode: SKNode?
    var alarmNodes: SKNode?
    var gameDelegate: GameDelegate?
    var alarms = [Alarm]()
    
    var presetAlarmIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = GameScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // set up delegate
                gameDelegate = scene as? GameDelegate
                scene.viewController = self
                
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
        presetAlarmIndex = nil
        performSegue(withIdentifier: "goToAddAlarmVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAddAlarmVC" {
            let destinationVC = segue.destination as! AddAlarmViewController
            if let timeLabelNode = timeNode as? SKLabelNode {
                destinationVC.timeValuePassedOver = timeLabelNode.text!
                if presetAlarmIndex != nil {
                    destinationVC.daySelection = alarms[presetAlarmIndex!].dayIndex
                    destinationVC.timeSelection = alarms[presetAlarmIndex!].timeIndex
                    destinationVC.rowSelection = alarms[presetAlarmIndex!].rowIndex
                }
                destinationVC.delegete = self
            } else {
                destinationVC.timeValuePassedOver = "Unsuccessful"
            }
        }
    }
    
    func addAlarm(timeStamp: String, timeOfDayIndex: Int, dayOfWeekIndex: Int, rowSelection: Int) {
        alarms.append(Alarm(time: timeStamp, timeIndex: timeOfDayIndex, dayIndex: dayOfWeekIndex, rowIndex: rowSelection))
        gameDelegate?.addAlarm()
    }
    
    func viewTouchedAlarm(alarmIndex: Int) {
        presetAlarmIndex = alarmIndex
        performSegue(withIdentifier: "goToAddAlarmVC", sender: self)
    }
    
    func receiveData(data: [String: Int]) {
        if data["delete"]! == 1 {
            gameDelegate?.deleteAlarm()
            return
        }
        
        var time = "12:00"
        var timeOfDay = 0
        var dayOfWeek = 0
        var row = 3
        
        if let timeLabelNode = timeNode as? SKLabelNode {
            time = timeLabelNode.text!
        }
        if let timeIndex = data["timOfDay"] {
            timeOfDay = timeIndex
        }
        if let dayIndex = data["dayOfWeek"] {
            dayOfWeek = dayIndex
        }
        
        if let rowIndex = data["row"] {
            row = rowIndex
        }
        
        addAlarm(timeStamp: time, timeOfDayIndex: timeOfDay, dayOfWeekIndex: dayOfWeek, rowSelection: row)
        

    }
}
