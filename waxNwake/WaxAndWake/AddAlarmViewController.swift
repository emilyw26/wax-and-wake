//
//  AddAlarmViewController.swift
//  DiveIntoSpriteKit
//
//  Created by Mary Ruth (MR) Ngo on 3/28/18.
//  Copyright © 2018 Paul Hudson. All rights reserved.
//

import UIKit

class AddAlarmViewController: UIViewController {
    var timeValuePassedOver: String?
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var amPm: UISegmentedControl!
    @IBOutlet weak var label: UITextField!
    @IBOutlet weak var daysOfWeek: UISegmentedControl!
    @IBOutlet weak var vibes: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        time.text = timeValuePassedOver
        time.adjustsFontSizeToFitWidth = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
