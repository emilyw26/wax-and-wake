//
//  GameScene.swift
//  DiveIntoSpriteKit
//
//  Created by Paul Hudson on 16/10/2017.
//  Copyright © 2017 Paul Hudson. All rights reserved.
//

import GameplayKit
import SpriteKit
import UIKit

protocol AlarmViewer {
    func viewTouchedAlarm(alarmIndex: Int)
}

@objcMembers
class GameScene: SKScene, GameDelegate {
    
    let player = SKSpriteNode(imageNamed: "ball")
    let button = SKSpriteNode(imageNamed: "add")
    let background = SKSpriteNode(imageNamed: "sunMoon")
    var alarms = [SKSpriteNode]()
    
    let timeLabel = SKLabelNode(text: "12:00")
    
    var touchingPlayer = false
    var touchingAlarm = false
    
    var radius = CGFloat(100)
    var scaleFactor = CGFloat(1.3)
    
    var viewDelegate: AlarmViewer?
    
    override func didMove(to view: SKView) {
        // this method is called when your game scene is ready to run
        background.size.width = frame.size.width/3
        background.size.height = background.size.width
        background.zPosition = -1
        addChild(background)
        
        player.position.y = background.size.height/2
        player.size.width = background.size.height/8
        player.size.height = background.size.height/8
        player.zPosition = 1
        addChild(player)
        
        radius = -player.position.y
        
        button.size.width = background.size.height/8
        button.size.height = background.size.height/8
        button.zPosition = 2
        addChild(button)
        
        timeLabel.fontSize = background.size.height/5
        timeLabel.color = SKColor.white
        timeLabel.position = CGPoint(x: frame.midX, y: frame.midY + frame.size.height*0.3)
        timeLabel.zPosition = 3
        addChild(timeLabel)
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            let location = touch.location(in: self)
            let tappedNodes = nodes(at: location)
            
            if tappedNodes.contains(player) {
                touchingPlayer = true
            } else {
                for i in 0 ... alarms.count-1 {
                    if tappedNodes.contains(alarms[i]) {
                        viewDelegate?.viewTouchedAlarm(alarmIndex: i)
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touchingPlayer {
                let location = touch.location(in: self)
                
                let radians = atan2(location.y, location.x) + CGFloat.pi
                let degrees = radians * (180 / CGFloat.pi) + 180
                
                player.position.x = radius * cos(radians)
                player.position.y = radius * sin(radians)
                
                let time: String = convertAngleToTime(angle: degrees)
                timeLabel.text = time
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchingPlayer = false
        touchingAlarm = false
    }
    

    override func update(_ currentTime: TimeInterval) {
        // this method is called before each frame is rendered
    }
    
    func convertAngleToTime(angle: CGFloat) -> String {
        var decimalValue = CGFloat(3) - CGFloat(1.0)/CGFloat(30) * angle.truncatingRemainder(dividingBy: 360)
        
        if decimalValue < 0 {
            decimalValue += CGFloat(12)
        }
        
        let hours: Int = Int(decimalValue) == 0 ? 12 : Int(decimalValue)
        let minutes: Int = Int((decimalValue * 60).truncatingRemainder(dividingBy: 60))
    
        return "\(hours):\(minutes < 10 ? "0\(minutes)" : "\(minutes)")"
    }
    
    func addAlarm() {
        let alarm = SKSpriteNode(imageNamed: "ball")
        alarm.size.width = background.size.height/10
        alarm.size.height = background.size.height/10
        alarm.zPosition = 2
        alarm.position = player.position
        addChild(alarm)
        
        player.position = CGPoint(x: frame.midX, y: background.size.height/2)
        alarms.append(alarm)
    }
    
}

