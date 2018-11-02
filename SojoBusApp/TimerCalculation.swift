//
//  TimerCalculation.swift
//  SojoBusApp
//
//  Created by 飯田拓馬 on 2018/09/13.
//  Copyright © 2018年 CATK. All rights reserved.
//

import Foundation

extension TimerViewController{
    func timerCalculate(timeTable:[Int:[Int]],flag:Int) -> (indicateTime:String,indicateHour:String,indicateMinute:String,buttonFlag:Int) {
        let currentTime_sec = self.getCurrentTime_sec() //現在時刻の取得
        var secondIndex:Int = 0
        var keysArrayIndex:Int = 0
        var usedCalculate:Int = 0
        var usedCalculate_sec:Int = 0
        var RemainingTime:Int = 0
        var indicateText:String = ""
        var buttonFlag:Int = 0
        
        var timeTableValueArray:[Int]!
        
        var keysArray = Array(timeTable.keys) //引数の時刻表データをindex化
        keysArray.sort(by: {$0 < $1})
        
        /*----------以下 表示時間を確定するプログラム----------*/
        //secondIndex = secondIndex + flag

        while(true){
            timeTableValueArray = timeTable[keysArray[keysArrayIndex]]
            usedCalculate = timeTableValueArray[secondIndex]
            usedCalculate_sec = keysArray[keysArrayIndex] * 3600 + usedCalculate * 60
            RemainingTime = usedCalculate_sec - currentTime_sec
            if (RemainingTime >= 0){
                break
            }
            if (timeTableValueArray.count == secondIndex + 1){
                if(keysArrayIndex + 1 == keysArray.count){
                    return ( "運行終了","--","--", 2 )
                }
                keysArrayIndex = keysArrayIndex + 1
                secondIndex = 0
            }else{
                secondIndex = secondIndex + 1
            }
        }
        if(flag == 0){
            if (timeTableValueArray.count == secondIndex - 1 && keysArray.count == keysArrayIndex - 1){
                buttonFlag = 1
            }
        }
        if(flag == 1){
            if (timeTableValueArray.count == secondIndex + 1){
                if(keysArrayIndex + 1 == keysArray.count){
                    return ( "運行終了","--","--", 1 )
                }
                keysArrayIndex = keysArrayIndex + 1
                secondIndex = 0
            }else{
                secondIndex = secondIndex + 1
            }
            timeTableValueArray = timeTable[keysArray[keysArrayIndex]]
            usedCalculate = timeTableValueArray[secondIndex]
            usedCalculate_sec = keysArray[keysArrayIndex] * 3600 + usedCalculate * 60
            RemainingTime = usedCalculate_sec - currentTime_sec
            
        }
        let hour_int:Int = RemainingTime/3600
        let hour = indicateAdjustment(origin: hour_int)
        
        let minute_int:Int = (RemainingTime%3600)/60
        let minute = indicateAdjustment(origin: minute_int)
        
        let second_int:Int = RemainingTime%60
        let second = indicateAdjustment(origin: second_int)
        
        indicateText = hour + " : " + minute + " : " + second
        
        let indicateHour = indicateAdjustment(origin: keysArray[keysArrayIndex])
        let indicateMinute = indicateAdjustment(origin:usedCalculate)
        
        return (indicateText,indicateHour,indicateMinute,buttonFlag)
    }
    
    
    func getCurrentTime_sec() -> Int{ //現在時刻を取得(単位は0時0分からの経過秒数)
        var currentTime:Int!
        var Sec:Int!
        var Min:Int!
        var Hour:Int!
        let format_sec = DateFormatter()
        format_sec.dateFormat = "ss"
        let conecter_sec = format_sec.string(from: Date())
        Sec = Int(conecter_sec)!
        
        let format_min = DateFormatter()
        format_min.dateFormat = "mm"
        let conecter_min = format_min.string(from: Date())
        Min = Int(conecter_min)!
        
        let format_hour = DateFormatter()
        format_hour.dateFormat = "HH"
        let conecter_hour = format_hour.string(from: Date())
        Hour = Int(conecter_hour)!
        
        currentTime = Hour*3600 + Min*60 + Sec
        return currentTime
        
        
    }
    func indicateAdjustment(origin : Int ) -> String {
        if origin < 10 {
            return "0" + String(origin)
        }
        return String(origin)
    }
    
}
