//
//  ViewController.swift
//  SojoBusApp
//
//  Created by 飯田拓馬 on 2018/06/23.
//  Copyright © 2018年 CATK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var ttNextLabel: UILabel!
    @IBOutlet weak var ttRemainLabel: UILabel!
    @IBOutlet weak var ttLabel: UILabel!
    
    @IBOutlet weak var tdNextLabel: UILabel!
    @IBOutlet weak var tdRemainLabel: UILabel!
    
    
    @IBOutlet weak var tdLabel: UILabel!
    @IBOutlet weak var ttBeforeLabel: UIButton!
    @IBOutlet weak var tdBeforeLabel: UIButton!
    @IBOutlet weak var ttAfterLabel: UIButton!
    @IBOutlet weak var tdAfterLabel: UIButton!
    
    
    @IBOutlet weak var ttBusCountLabel: UILabel!
    @IBOutlet weak var tdBusCountLabel: UILabel!
    
    
    
    
    
    var timer:Timer!
    var nowTimeSec:Int=0
    var ttNext:Int=0
    var tdNext:Int=0
    var mode:Int=0  //0の時上り、1の時下り

    var n:Int = 0
    var m:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nowTimeSec = nowTimeGet()
        ttNext = ttNextGet()
        labelChangeFanction()
        ttBeforeLabel.isHidden = true
        tdBeforeLabel.isHidden = true
        
        timer=Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {(t)
            in self.main()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func main(){
        nowTimeSec = nowTimeGet()
        ttNext = ttNextGet()
        tdNext = tdNextGet()
        if ttNext == 9999 {
            ttNextLabel.text = "--:--"
            ttRemainLabel.text = "運行終了"
        }else{
        ttNextLabel.text = nextBusFormat(ttNext)
        ttRemainLabel.text = countDownFormat(ttNext)
        ttBusCounter()
        }
        
        if tdNext == 9999 {
            tdNextLabel.text = "--:--"
            tdRemainLabel.text = "運行終了"
        }else{
        tdNextLabel.text = nextBusFormat(tdNext)
        tdRemainLabel.text = countDownFormat(tdNext)
        tdBusCounter()
        }
    }
    
    func nowTimeGet() -> Int{    //現在時間の取得
        var nowSec:Int!
        var nowMin:Int!
        var nowHour:Int!
        let format_sec = DateFormatter()
        format_sec.dateFormat = "ss"
        let conecter_sec = format_sec.string(from: Date())
        nowSec = Int(conecter_sec)!
        
        let format_min = DateFormatter()
        format_min.dateFormat = "mm"
        let conecter_min = format_min.string(from: Date())
        nowMin = Int(conecter_min)!
        
        let format_hour = DateFormatter()
        format_hour.dateFormat = "HH"
        let conecter_hour = format_hour.string(from: Date())
        nowHour = Int(conecter_hour)!
        
        return nowHour*3600 + nowMin*60 + nowSec
    }

    func ttNextGet() -> Int{    //高槻の次のバスの時刻を計算
        let nowMin:Int = nowTimeSec/60
        var i:Int = 0
        if mode == 0 {
            if nowMin < ttUpListMin.last! {
                while (i < ttUpListMin.count && nowMin >= ttUpListMin[i]) {
                    i = i+1
                }
                //上限規制のコードn
                if ttUpListMin.count - i > 1{
                    if n<2 {
                        ttAfterLabel.isHidden = false
                    }else{
                        ttAfterLabel.isHidden = true
                    }
                }else if ttUpListMin.count - i == 0{
                    if n<1 {
                        ttAfterLabel.isHidden = false
                    }else{
                        ttAfterLabel.isHidden = true
                    }
                }else{
                    ttAfterLabel.isHidden = true
                }
                return ttUpListMin[i+n]
            }else{
                return 9999
            }
        }else if mode == 1 {
            if nowMin < ttDownListMin.last! {
                while (i < ttDownListMin.count && nowMin >= ttDownListMin[i]) {
                    i = i+1
                }
                //上限規制のコードn
                if ttDownListMin.count - i > 1{
                    if n<2 {
                        ttAfterLabel.isHidden = false
                    }else{
                        ttAfterLabel.isHidden = true
                    }
                }else if ttDownListMin.count - i == 0{
                    if n<1 {
                        ttAfterLabel.isHidden = false
                    }else{
                        ttAfterLabel.isHidden = true
                    }
                }else{
                    ttAfterLabel.isHidden = true
                }
                return ttDownListMin[i+n]
            }else{
                return 9999
            }
        }
        return 0
    }
    
    func tdNextGet() -> Int{    //富田の次のバスの時刻を計算
        let nowMin:Int = nowTimeSec/60
        var j:Int = 0
        if mode == 0 {
            if nowMin < tdUpListMin.last! {
                while (j < tdUpListMin.count && nowMin >= tdUpListMin[j]) {
                    j = j+1
                }
                //上限規制のコード
                if tdUpListMin.count - j > 1{
                    if m<2 {
                        tdAfterLabel.isHidden = false
                    }else{
                        tdAfterLabel.isHidden = true
                    }
                }else if tdUpListMin.count - j == 0{
                    if m<1 {
                        tdAfterLabel.isHidden = false
                    }else{
                        tdAfterLabel.isHidden = true
                    }
                }else{
                    tdAfterLabel.isHidden = true
                }
                return tdUpListMin[j+m]
            }else{
                return 9999
            }
        }else if mode == 1 {
            if nowMin < tdDownListMin.last! {
                while (j < tdDownListMin.count && nowMin >= tdDownListMin[j]) {
                    j = j+1
                }
                //上限規制のコード
                if tdDownListMin.count - j > 1{
                    if m<2 {
                        tdAfterLabel.isHidden = false
                    }else{
                        tdAfterLabel.isHidden = true
                    }
                }else if tdDownListMin.count - j == 0{
                    if m<1 {
                        tdAfterLabel.isHidden = false
                    }else{
                        tdAfterLabel.isHidden = true
                    }
                }else{
                    tdAfterLabel.isHidden = true
                }
                return tdDownListMin[j+m]
            }else{
                return 9999
            }
        }
        return 0
    }
    
    func nextBusFormat(_ nextMin:Int) -> String{
        var HH:Int = 0
        var mm:Int = 0
        
        HH = nextMin/60
        mm = nextMin%60
        if HH < 10 && mm < 10 {
            return "0\(HH):0\(mm)"
        }else if HH<10 {
            return "0\(HH):\(mm)"
        }else if mm < 10 {
            return "\(HH):0\(mm)"
        }else{
        return "\(HH):\(mm)"
        }
    }
    
    func countDownFormat(_ nextMin:Int) -> String{
        let remainSec = nextMin * 60 - nowTimeSec
        let HH:Int = remainSec/3600
        let mm:Int = (remainSec-(HH * 3600))/60
        let ss:Int = remainSec%60
        var HHtext:String = "\(HH)"
        var mmtext:String = "\(mm)"
        var sstext:String = "\(ss)"
        if HH<10 {
            HHtext = "0\(HHtext)"
        }
        if mm<10 {
            mmtext = "0\(mmtext)"
        }
        if ss<10 {
            sstext = "0\(sstext)"
        }
        return "\(HHtext):\(mmtext):\(sstext)"
    }
    
    func labelChangeFanction() {
        if mode == 0 {
            ttLabel.text = "JR高槻駅→関西大学"
            tdLabel.text = "JR摂津富田駅→関西大学"
        }else{
            ttLabel.text = "関西大学→JR高槻駅"
            tdLabel.text = "関西大学→JR摂津富田駅"
        }
    }
    
    func ttBusCounter() {
        if n==0 {
            ttBusCountLabel.text = "次のバス"
            ttBeforeLabel.isHidden = true
        }else{
            ttBusCountLabel.text = "\(n+1)本後のバス"
            ttBeforeLabel.isHidden = false
        }
    }
    
    func tdBusCounter() {
        if m==0 {
            tdBusCountLabel.text = "次のバス"
            tdBeforeLabel.isHidden = true
        }else{
            tdBusCountLabel.text = "\(m+1)本後のバス"
            tdBeforeLabel.isHidden = false
        }
    }
    
    @IBAction func modeButton(_ sender: Any) {
        n=0
        m=0
        mode = mode+1
        mode = mode%2
        main()
        labelChangeFanction()
    }
    
    @IBAction func ttAfterButton(_ sender: Any) {
        n=n+1
        main()
    }
    
    @IBAction func ttBeforeButton(_ sender: Any) {
        n=n-1
        main()
    }
    
    @IBAction func ttNowButton(_ sender: Any) {
        n=0
        main()
    }
    
    @IBAction func tdAfterButton(_ sender: Any) {
        m=m+1
        main()
    }
    @IBAction func tdBeforeButton(_ sender: Any) {
        m=m-1
        main()
    }
    
    @IBAction func tdNowButton(_ sender: Any) {
        m=0
        main()
    }
    
}
