//
//  TimerViewController.swift
//  SojoBusApp
//
//  Created by 飯田拓馬 on 2018/09/10.
//  Copyright © 2018年 CATK. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    var timer:Timer!
    var destination:Int = 0 //0の時上り、1の時下り
    var currentTime_sec:Int = 0 //現在時刻(秒)
    var takatsuki_ButtonCounter:Int = 0
    var tonda_ButtonCounter:Int = 0
    
    @IBOutlet weak var takatsuki_NextBusLabel: UILabel!
    @IBOutlet weak var takatsuki_NextBusTimeLabel: UILabel!
    @IBOutlet weak var takatsuki_CountDownLabel: UILabel!
    @IBOutlet weak var takatsuki_NextButtonLabel: UIButton!
    @IBOutlet weak var takatsuki_BeforeButtonLabel: UIButton!
    
    @IBOutlet weak var tonda_NextBusLabel: UILabel!
    @IBOutlet weak var tonda_NextBusTimeLabel: UILabel!
    @IBOutlet weak var tonda_CountDownLabel: UILabel!
    @IBOutlet weak var tonda_NextButtonLabel: UIButton!
    @IBOutlet weak var tonda_BeforeButtonLabel: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        takatsuki_BeforeButtonLabel.isHidden = true
        takatsuki_NextButtonLabel.isHidden = false
        tonda_BeforeButtonLabel.isHidden = true
        tonda_NextButtonLabel.isHidden = false

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {(t) in self.timerMainFunction()}) //一秒ごとに更新
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func timerMainFunction(){ //処理のフロー
        
        if destination == 0{
            let takatsuki_IndicateList = timerCalculate(timeTable:takatsukiUpList,flag:takatsuki_ButtonCounter)
            takatsuki_CountDownLabel.text = takatsuki_IndicateList.indicateTime  //高槻駅の文字盤を表示
            takatsuki_NextBusTimeLabel.text = takatsuki_IndicateList.indicateHour + ":" + takatsuki_IndicateList.indicateMinute
            if(takatsuki_IndicateList.buttonFlag == 0){
                if(takatsuki_ButtonCounter == 1){
                    takatsuki_BeforeButtonLabel.isHidden = false
                    takatsuki_NextButtonLabel.isHidden = true
                }else if (takatsuki_ButtonCounter == 0){
                    takatsuki_BeforeButtonLabel.isHidden = true
                    takatsuki_NextButtonLabel.isHidden = false
                }
            }else if(takatsuki_IndicateList.buttonFlag == 1){
                takatsuki_BeforeButtonLabel.isHidden = false
                takatsuki_NextButtonLabel.isHidden = true
            }else if (takatsuki_IndicateList.buttonFlag == 2){
                takatsuki_BeforeButtonLabel.isHidden = true
                takatsuki_NextButtonLabel.isHidden = true
            }
            
            let tonda_IndicateList = timerCalculate(timeTable:tondaUpList,flag:tonda_ButtonCounter)
            tonda_CountDownLabel.text = tonda_IndicateList.indicateTime  //富田駅の文字盤を表示
            tonda_NextBusTimeLabel.text = tonda_IndicateList.indicateHour + ":" + tonda_IndicateList.indicateMinute
            if(tonda_IndicateList.buttonFlag == 0){
                if(tonda_ButtonCounter == 1){
                    tonda_BeforeButtonLabel.isHidden = false
                    tonda_NextButtonLabel.isHidden = true
                }else if (tonda_ButtonCounter == 0){
                    tonda_BeforeButtonLabel.isHidden = true
                    tonda_NextButtonLabel.isHidden = false
                }
            }else if(tonda_IndicateList.buttonFlag == 1){
                tonda_BeforeButtonLabel.isHidden = false
                tonda_NextButtonLabel.isHidden = true
            }else if (tonda_IndicateList.buttonFlag == 2){
                tonda_BeforeButtonLabel.isHidden = true
                tonda_NextButtonLabel.isHidden = true
            }
        }
        else{
            let takatsuki_IndicateList = timerCalculate(timeTable:takatsukiDownList,flag:takatsuki_ButtonCounter)
            takatsuki_CountDownLabel.text = takatsuki_IndicateList.indicateTime//高槻駅の文字盤を表示
            takatsuki_NextBusTimeLabel.text = takatsuki_IndicateList.indicateHour + ":" + takatsuki_IndicateList.indicateMinute
            if(takatsuki_IndicateList.buttonFlag == 0){
                if(takatsuki_ButtonCounter == 1){
                    takatsuki_BeforeButtonLabel.isHidden = false
                    takatsuki_NextButtonLabel.isHidden = true
                }else if (takatsuki_ButtonCounter == 0){
                    takatsuki_BeforeButtonLabel.isHidden = true
                    takatsuki_NextButtonLabel.isHidden = false
                }
            }else if(takatsuki_IndicateList.buttonFlag == 1){
                takatsuki_BeforeButtonLabel.isHidden = false
                takatsuki_NextButtonLabel.isHidden = true
            }else if (takatsuki_IndicateList.buttonFlag == 2){
                takatsuki_BeforeButtonLabel.isHidden = true
                takatsuki_NextButtonLabel.isHidden = true
            }
            
            let tonda_IndicateList = timerCalculate(timeTable:tondaDownList,flag:tonda_ButtonCounter)
            tonda_CountDownLabel.text = tonda_IndicateList.indicateTime  //富田駅の文字盤を表示
            tonda_NextBusTimeLabel.text = tonda_IndicateList.indicateHour + ":" + tonda_IndicateList.indicateMinute
            if(tonda_IndicateList.buttonFlag == 0){
                if(tonda_ButtonCounter == 1){
                    tonda_BeforeButtonLabel.isHidden = false
                    tonda_NextButtonLabel.isHidden = true
                }else if (tonda_ButtonCounter == 0){
                    tonda_BeforeButtonLabel.isHidden = true
                    tonda_NextButtonLabel.isHidden = false
                }
            }else if(tonda_IndicateList.buttonFlag == 1){
                tonda_BeforeButtonLabel.isHidden = false
                tonda_NextButtonLabel.isHidden = true
            }
        }
    }    
    
    @IBAction func destinationSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            destination = 0
        case 1:
            destination = 1
        default:
            print("destination Error")
        }
    }
    
    @IBAction func takatsuki_AfterButton(_ sender: UIButton) {
        takatsuki_ButtonCounter = 1
        takatsuki_BeforeButtonLabel.isHidden = false
        takatsuki_NextButtonLabel.isHidden = true
        takatsuki_NextBusLabel.text = "２本後のバス"
        timerMainFunction()
    }
    
    @IBAction func takatsuki_BeforeButton(_ sender: UIButton) {
        takatsuki_ButtonCounter = 0
        takatsuki_BeforeButtonLabel.isHidden = true
        takatsuki_NextButtonLabel.isHidden = false
        takatsuki_NextBusLabel.text = "次のバス"
        timerMainFunction()
    }
    
    
    @IBAction func tonda_AfterButton(_ sender: UIButton) {
        tonda_ButtonCounter = 1
        tonda_BeforeButtonLabel.isHidden = false
        tonda_NextButtonLabel.isHidden = true
        tonda_NextBusLabel.text = "２本後のバス"
        timerMainFunction()
    }
    
    @IBAction func tonda_BeforeButton(_ sender: UIButton) {
        tonda_ButtonCounter = 0
        tonda_BeforeButtonLabel.isHidden = true
        tonda_NextButtonLabel.isHidden = false
        tonda_NextBusLabel.text = "次のバス"
        timerMainFunction()
    }
    
    
    
}














