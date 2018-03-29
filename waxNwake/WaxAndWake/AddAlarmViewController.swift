//
//  AddAlarmViewController.swift
//  DiveIntoSpriteKit
//
//  Created by Mary Ruth (MR) Ngo on 3/28/18.
//  Copyright © 2018 Paul Hudson. All rights reserved.
//

import UIKit

protocol CanReceive {
    func receiveData(data: [String: Int])
}

class AddAlarmViewController: UIViewController {
    var timeValuePassedOver: String?

    var timeSelection: Int?
    var daySelection: Int?
    
    var delegete: CanReceive?
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var timeOfDay: UISegmentedControl!
    @IBOutlet weak var dayOfWeek: UISegmentedControl!
    @IBOutlet weak var addDeleteButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        time.text = timeValuePassedOver
        time.adjustsFontSizeToFitWidth = true

        if timeSelection != nil && daySelection != nil {
            configureSetAlarmView(selector: timeOfDay, selectionIndex: timeSelection!)
            configureSetAlarmView(selector: dayOfWeek, selectionIndex: daySelection!)
            
            addDeleteButton.setTitle("Delete Alarm", for: .normal)
        } else {
            addDeleteButton.setTitle("Add Alarm", for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    
    func configureSetAlarmView(selector: UISegmentedControl, selectionIndex: Int) {
        for i in 0 ... selector.numberOfSegments-1 {
            selector.setEnabled(false, forSegmentAt: i)
        }
        selector.setEnabled(true, forSegmentAt: selectionIndex)
        selector.selectedSegmentIndex = selectionIndex
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
    
    @IBAction func addAlarmButtonPressed(_ sender: UIButton) {
        if addDeleteButton.title(for: .normal)! == "Add Alarm" {
            delegete?.receiveData(data: ["timeOfDay": timeOfDay.selectedSegmentIndex, "dayOfWeek" : dayOfWeek.selectedSegmentIndex, "delete": 0])
        } else if addDeleteButton.title(for: .normal)! == "Delete Alarm" {
            delegete?.receiveData(data: ["delete": 1])
        }

        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        wipePresets()
        self.dismiss(animated: true, completion: nil)
    }
    
    func wipePresets() {
        timeSelection = nil
        daySelection = nil
    }
    
}
