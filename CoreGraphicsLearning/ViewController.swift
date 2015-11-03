//
//  ViewController.swift
//  CoreGraphicsLearning
//
//  Created by Stuart Robinson on 02/11/2015.
//  Copyright © 2015 Stuart Robinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var isGraphViewShowing = false
    
   
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var graphView: GraphView!
    //Counter outlets
    @IBOutlet var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    
    //Label outlets
    @IBOutlet weak var averageWaterDrunk: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    @IBOutlet weak var medalView: MedalView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        counterLabel.text = String(counterView.counter)
        
        checkTotal()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func checkTotal() {
        if counterView.counter >= 8 {
            medalView.showMedal(true)
        } else {
            medalView.showMedal(false)
        }
    }
    
    @IBAction func btnPushButton(button: PushButtonView) {
        if (button.isAddButton) {
            counterView.counter++
        } else {
            if counterView.counter > 0 {
                counterView.counter--
            }
        }
        counterLabel.text = String(counterView.counter)
        
        if isGraphViewShowing {
            counterViewTap(nil)
        }
        
        checkTotal()
    }
    
    @IBAction func counterViewTap(gesture:UITapGestureRecognizer?) {
        if (isGraphViewShowing) {
            
            //hide Graph
            UIView.transitionFromView(graphView,
                toView: counterView,
                duration: 1.0,
                options: [UIViewAnimationOptions.TransitionFlipFromLeft, UIViewAnimationOptions.ShowHideTransitionViews],
                completion:nil)
            
            isGraphViewShowing = false;
        } else {
            
            //show Graph
            UIView.transitionFromView(counterView,
                toView: graphView,
                duration: 1.0,
                options: [UIViewAnimationOptions.TransitionFlipFromRight, UIViewAnimationOptions.ShowHideTransitionViews],
                completion: nil)
            
            isGraphViewShowing = true;
            
            setupGraphDisplay()
        }
    }
    
    func setupGraphDisplay() {
        
        //Use 7 days for graph - can use any number,
        //but labels and sample data are set up for 7 days
        let noOfDays:Int = 7
        
        //1 - replace last day with today's actual data
        graphView.graphPoints[graphView.graphPoints.count-1] = counterView.counter
        
        //2 - indicate that the graph needs to be redrawn
        graphView.setNeedsDisplay()

        
        maxLabel.text = "\(graphView.graphPoints.maxElement()!)"
        
        //3 - calculate average from graphPoints
        let average = graphView.graphPoints.reduce(0, combine: +)
            / graphView.graphPoints.count
        averageWaterDrunk.text = "\(average)"
        
        //set up labels
        //day of week labels are set up in storyboard with tags
        //today is last day of the array need to go backwards
        
        //4 - get today's day number
        let dateFormatter = NSDateFormatter()
        let calendar = NSCalendar.currentCalendar()
        var component = calendar.component(.Weekday, fromDate:NSDate())

        
        let days = ["S", "S", "M", "T", "W", "T", "F"]
        
        
        //5 - set up the day name labels with correct day
        
        for i in (1...days.count) {
            if let labelView = graphView.viewWithTag(days.count-i+1) as? UILabel {
                
                if component == 7 {
                    component = 0
                }
                labelView.text = days[component--]
                if component < 0 {
                    component = days.count - 1
                }

            }
    
        }
    }
}

