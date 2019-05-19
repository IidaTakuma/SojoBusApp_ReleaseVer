//
//  DataFile_TimeTable.swift
//  SojoBusApp
//
//  Created by 飯田拓馬 on 2018/09/13.
//  Copyright © 2018年 CATK. All rights reserved.
//

import Foundation

struct TimeTableAll:Codable {
    let dataList:[DataList]
    
    struct DataList: Codable {
        let destination:String?
        let six:[Int]?
        let seven:[Int]?
        let eight:[Int]?
        let nine:[Int]?
        let ten:[Int]?
        let eleven:[Int]?
        let twelve:[Int]?
        let thirteen:[Int]?
        let fourteen:[Int]?
        let fifteen:[Int]?
        let sixteen:[Int]?
        let seventeen:[Int]?
        let eighteen:[Int]?
        let nineteen:[Int]?
        let twenty:[Int]?
        let twentyone:[Int]?
        let twentytwo:[Int]?
        let twentythree:[Int]?
        
        private enum CodingKeys:String, CodingKey{
            case destination = "destination"
            case six = "06"
            case seven = "07"
            case eight = "08"
            case nine = "09"
            case ten = "10"
            case eleven = "11"
            case twelve = "12"
            case thirteen = "13"
            case fourteen = "14"
            case fifteen = "15"
            case sixteen = "16"
            case seventeen = "17"
            case eighteen = "18"
            case nineteen = "19"
            case twenty = "20"
            case twentyone = "21"
            case twentytwo = "22"
            case twentythree = "23"
        }
    }
}

class GetTimeTableFromAPI{
    
    public func getTimeTableFromAPI(completion:@escaping (_ takatsukiUp:[Int:[Int]],_ takatsukiDown:[Int:[Int]],_ tondaUp:[Int:[Int]],_ tondaDown:[Int:[Int]])->Void){
        let url: URL = URL(string:"https://calm-mountain-57108.herokuapp.com/timeTable")!
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            let decoder: JSONDecoder = JSONDecoder()
            do {
                print(data!)
                let originData:TimeTableAll = try decoder.decode(TimeTableAll.self, from: data!)// 全ての時刻表データが格納されている
                print(originData)
                let formatedDataList = self.formatData(originData: originData)
                print(formatedDataList)
                print("データの取得しました")
                completion(formatedDataList.takatsukiUp,formatedDataList.takatsukiDown,formatedDataList.tondaUp,formatedDataList.tondaDown)
                
            } catch {
                print("error:", error.localizedDescription)
                //completion("")
            }
        })
        task.resume()//実行する
        
    }
    
    func formatData(originData:TimeTableAll) -> (takatsukiUp:[Int:[Int]],takatsukiDown:[Int:[Int]],tondaUp:[Int:[Int]],tondaDown:[Int:[Int]]) {
        
        let usableData = originData.dataList
        var takatsukiUp:[Int:[Int]] = [:]
        var takatsukiDown:[Int:[Int]] = [:]
        var tondaUp:[Int:[Int]] = [:]
        var tondaDown:[Int:[Int]] = [:]
        
        for data in usableData{
            var baffa:[Int:[Int]] = [:]
            baffa[6] = data.six
            baffa[7] = data.seven
            baffa[8] = data.eight
            baffa[9] = data.nine
            baffa[10] = data.ten
            baffa[11] = data.eleven
            baffa[12] = data.twelve
            baffa[13] = data.thirteen
            baffa[14] = data.fourteen
            baffa[15] = data.fifteen
            baffa[16] = data.sixteen
            baffa[17] = data.seventeen
            baffa[18] = data.eighteen
            baffa[19] = data.nineteen
            baffa[20] = data.twenty
            baffa[21] = data.twentyone
            baffa[22] = data.twentytwo
            baffa[23] = data.twentythree
            
            switch (data.destination) {
            case "takatsukiUp":
                takatsukiUp = baffa
            case "takatsukiDown":
                takatsukiDown = baffa
            case "tondaUp":
                tondaUp = baffa
            case "tondaDown":
                tondaDown = baffa
            default:
                print("受け取った時刻表はどれにも当てはまりませんでした")
                
            }
        }
        return (takatsukiUp,takatsukiDown,tondaUp,tondaDown)
    }
}

