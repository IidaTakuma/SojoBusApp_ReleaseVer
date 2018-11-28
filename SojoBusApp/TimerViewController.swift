//
//  TimerViewController.swift
//  SojoBusApp
//
//  Created by 飯田拓馬 on 2018/09/10.
//  Copyright © 2018年 CATK. All rights reserved.
//

import UIKit

// バスの方向（上り、下り）
enum BusDestination: Int {
    case up
    case down
}
// バスの状態（初期、次のバス表示時、運行終了）
enum BusSeveral: Int {
    case zero
    case first
    case none
}

class TimerViewController: UIViewController {
    
    var timer:Timer!
    var busDestination: BusDestination = .up
    var currentTime_sec:Int = 0 //現在時刻(秒)
    var takatsukiBusSeveral: BusSeveral = .zero
    var tondaBusSeveral: BusSeveral = .zero
    
    
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
        var takatsukiIndicateList: (indicateTime:String,nextBusTimeText:String,several:BusSeveral)
        var tondaIndicateList: (indicateTime:String,nextBusTimeText:String,several:BusSeveral)
        switch busDestination {
        case .up:
            takatsukiIndicateList = timerCalculate(timeTable:takatsukiUpList,several:takatsukiBusSeveral)
            tondaIndicateList = timerCalculate(timeTable:tondaUpList,several: tondaBusSeveral)
        case .down:
            takatsukiIndicateList = timerCalculate(timeTable:takatsukiDownList,several:takatsukiBusSeveral)
            tondaIndicateList = timerCalculate(timeTable:tondaDownList,several: tondaBusSeveral)
        }
        takatsuki_CountDownLabel.text = takatsukiIndicateList.indicateTime  //高槻駅の文字盤を表示
        takatsuki_NextBusTimeLabel.text = takatsukiIndicateList.nextBusTimeText
        switch takatsukiIndicateList.several {
        case .zero:
            takatsuki_BeforeButtonLabel.isHidden = true
            takatsuki_NextButtonLabel.isHidden = false
        case .first:
            takatsuki_BeforeButtonLabel.isHidden = false
            takatsuki_NextButtonLabel.isHidden = true
        case .none:
            takatsuki_BeforeButtonLabel.isHidden = true
            takatsuki_NextButtonLabel.isHidden = true
        }
        
        tonda_CountDownLabel.text = tondaIndicateList.indicateTime  //富田駅の文字盤を表示
        tonda_NextBusTimeLabel.text = tondaIndicateList.nextBusTimeText
        switch tondaIndicateList.several {
        case .zero:
            tonda_BeforeButtonLabel.isHidden = true
            tonda_NextButtonLabel.isHidden = false
        case .first:
            tonda_BeforeButtonLabel.isHidden = false
            tonda_NextButtonLabel.isHidden = true
        case .none:
            tonda_BeforeButtonLabel.isHidden = true
            tonda_NextButtonLabel.isHidden = true
        }
        
    }    
    
    @IBAction func destinationSegmentedControl(_ sender: UISegmentedControl) {
        busDestination = BusDestination(rawValue: sender.selectedSegmentIndex) ?? .up
    }
    
    @IBAction func takatsuki_AfterButton(_ sender: UIButton) {
        takatsukiBusSeveral = .first
        takatsuki_BeforeButtonLabel.isHidden = false
        takatsuki_NextButtonLabel.isHidden = true
        takatsuki_NextBusLabel.text = "２本後のバス"
        timerMainFunction()
    }
    
    @IBAction func takatsuki_BeforeButton(_ sender: UIButton) {
        takatsukiBusSeveral = .zero
        takatsuki_BeforeButtonLabel.isHidden = true
        takatsuki_NextButtonLabel.isHidden = false
        takatsuki_NextBusLabel.text = "次のバス"
        timerMainFunction()
    }
    
    @IBAction func tonda_AfterButton(_ sender: UIButton) {
        tondaBusSeveral = .first
        tonda_BeforeButtonLabel.isHidden = false
        tonda_NextButtonLabel.isHidden = true
        tonda_NextBusLabel.text = "２本後のバス"
        timerMainFunction()
    }
    
    @IBAction func tonda_BeforeButton(_ sender: UIButton) {
        tondaBusSeveral = .zero
        tonda_BeforeButtonLabel.isHidden = true
        tonda_NextButtonLabel.isHidden = false
        tonda_NextBusLabel.text = "次のバス"
        timerMainFunction()
    }
}
