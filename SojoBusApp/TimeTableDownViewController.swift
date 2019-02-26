//
//  TimeTableDownViewController.swift
//  SojoBusApp
//
//  Created by 飯田拓馬 on 2018/09/14.
//  Copyright © 2018年 CATK. All rights reserved.
//

import UIKit

class TimeTableDownViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var takatsukiTableView_Kudari: UITableView!
    @IBOutlet weak var tondaTableView_Kudari: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            return takatsukiDownList.count
        }
        else if tableView.tag == 1 {
            return tondaDownList.count
        }
        else{
            print("TimeTableTagError")
            return 0
        }
            
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var keysArray:[Int]
        if tableView.tag == 0 {
            keysArray = Array(takatsukiDownList.keys) //引数の時刻表データをindex化
        }else{
            keysArray = Array(tondaDownList.keys) //引数の時刻表データをindex化
        }
        keysArray.sort(by: {$0 < $1})
        
        var cell: UITableViewCell = UITableViewCell()
        print(indexPath.row)
        if tableView.tag == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: "takatsukiKudari", for: indexPath)
            cell.textLabel!.text = self.IntArrayToString(hour: keysArray[indexPath.row] , array: takatsukiDownList[keysArray[indexPath.row]]!)
        }else if tableView.tag == 1{
            cell = tableView.dequeueReusableCell(withIdentifier: "tondaKudari", for: indexPath)
            cell.textLabel!.text = self.IntArrayToString(hour: keysArray[indexPath.row], array: tondaDownList[keysArray[indexPath.row]]!)
        }
        return cell
    }
    func IntArrayToString(hour:Int,array:[Int]) -> String {
        var str:String = String(hour) + "："
        var index:Int = 0
        while( index < array.count ){
            str.append(String(array[index]))
            str.append(" ")
            index = index + 1
        }
        return str
    }


}
