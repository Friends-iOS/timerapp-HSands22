//
//  ViewController.swift
//  Timer
//
//  Created by Adam Jackrel on 4/2/20.
//  Copyright © 2020 Adam Jackrel. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //dictionary; "key" : "value"
    let waterTimes = ["Hot": 2, "Medium": 5, "Cold": 10]
    
    //initializer for Timer instance that is stored in timer
       var timer = Timer()
    
    let temperatureSelector: String = "Hot"
    
    //number of total seconds
      var totalTime: Float = 0
      //number of elapsed seconds
      var secondsPassed: Float = 0
      
      var player: AVAudioPlayer!
      
      var temperature: String = ""

   
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func temperatureSelected(_ sender: UIButton) {
        
        //this will change from "done" when the timer elapses
        //this is the default String value
        self.titleLabel.text = "How long do you want your water to be cooled for?"
        //resets the timer
        timer.invalidate()
        //elapsed seconds
        secondsPassed = 0
        //total amount of seconds
        totalTime = 0
        
        //stores the currentTitle of the button pressed (so we know which button was pressed) in a constant
              temperature = sender.currentTitle!
              print(temperature)
              //uses the currentTitle as a key in the dict
              //cast it as a Float
              totalTime = Float(waterTimes[temperature]!)
              //waterTimes - dict
              //temperature - String (title label of the button)
              //dict[String/key]

              //Timer() was initialized and stored in timer.
              //selector is the function we'll be passing to
              //timeInterval is the number of seconds between calling it again
              //repeats is a boolean. True it repeats, false it doesn't repeat (one and done)
              timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
    }
    
    // must be internal or public.
    @objc func timerAction() {
        
     //if the totalTime is greater than zero (if the timer is still counting down) then display time elapsed and decrement totalTime
     if (totalTime > 0){
         
         //since totalTime is a FLOAT and the UILabel requires a String, we must CAST the totalTime variable to a String.
         self.titleLabel.text = String(totalTime)
         //decrementing totalTime by 1 every time this function runs (the Timer initializer above activates this function every 1 sec
         totalTime = totalTime - 1
     }
     
     //if timer reaches zero, then display a message on screen, play the alarm sound, and reset the timer
     else{
         //change the UILabel to "DONE"
         self.titleLabel.text = "DONE!"
         //play sound
         playSound(label: "alarm_sound")
         //reset (ie invalidate) the timer to default starting values
         timer.invalidate()
         
     }
     }
    
    func playSound(label : String) {
        let url = Bundle.main.url(forResource: label, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    

}

