//
//  TimerCalculation.swift
//  SojoBusApp
//
//  Created by 飯田拓馬 on 2018/09/13.
//  Copyright © 2018年 CATK. All rights reserved.
//

import Foundation

extension TimerViewController{
    func timerCalculate(timeTable:[Int:[Int]],several:BusSeveral) -> (indicateTime:String,nextBusTimeText:String,several:BusSeveral) {
        let currentTime_sec = self.getCurrentTime_sec() //現在時刻の取得
        var secondIndex:Int = 0
        var keysArrayIndex:Int = 0
        var usedCalculate:Int = 0
        var usedCalculate_sec:Int = 0
        var RemainingTime:Int = 0
        var indicateText:String = ""
        var tmpSeveral = several
        
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
                    return ( "運行終了","--:--", .none )
                }
                keysArrayIndex = keysArrayIndex + 1
                secondIndex = 0
            }else{
                secondIndex = secondIndex + 1
            }
        }
        switch several {
        case .zero:
            if (timeTableValueArray.count == secondIndex - 1 && keysArray.count == keysArrayIndex - 1){
                tmpSeveral = .first
            }
        case .first:
            if (timeTableValueArray.count == secondIndex + 1){
                if(keysArrayIndex + 1 == keysArray.count){
                    return ( "運行終了","--:--", .first )
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
        case .none:
            break
        }
        
        indicateText = String(format: "%02d:%02d:%02d", RemainingTime / 3600, (RemainingTime % 3600) / 60, RemainingTime % 60)
        let nextBusTimeText = String(format: "%02d:%02d", keysArray[keysArrayIndex], usedCalculate)
        
        return (indicateText,nextBusTimeText,tmpSeveral)
    }
    
    
    func getCurrentTime_sec() -> Int{ //現在時刻を取得(単位は0時0分からの経過秒数)
        let calendar = Calendar.current
        let date = Date()
        let nowSec = calendar.component(.second, from: date)
        let nowMin = calendar.component(.minute, from: date)
        let nowHour = calendar.component(.hour, from: date)
        return (nowHour * 3600) + (nowMin * 60) + nowSec
    }
    
    func indicateAdjustment(origin : Int ) -> String {
        return String(format: "%02d", origin)
    }
    
}
