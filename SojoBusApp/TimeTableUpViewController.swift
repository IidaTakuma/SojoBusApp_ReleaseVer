//
//  TimeTableUpViewController.swift
//  SojoBusApp
//
//  Created by 飯田拓馬 on 2018/09/10.
//  Copyright © 2018年 CATK. All rights reserved.
//

import UIKit

class TimeTableUpViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var takatsukiTableView_Nobori: UITableView!
    @IBOutlet weak var tondaTableView_Nobori: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            return takatsukiUpList.count
        }
        else if tableView.tag == 1 {
            return tondaUpList.count
        }
        else{
            print("TimeTableTagError")
            return 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var addNum = 6
        if tableView.tag == 0 {
            if indexPath.row == 16 {
                addNum = 7
            }
        }
        var cell: UITableViewCell = UITableViewCell()
        print(indexPath.row)
        if tableView.tag == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: "takatsukiNobori", for: indexPath)
            cell.textLabel!.text = self.IntArrayToString(hour: indexPath.row + addNum, array: takatsukiUpList[indexPath.row + addNum]!)
        }else if tableView.tag == 1{
            cell = tableView.dequeueReusableCell(withIdentifier: "tondaNobori", for: indexPath)
            cell.textLabel!.text = self.IntArrayToString(hour: indexPath.row + addNum, array: tondaUpList[indexPath.row + addNum]!)
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
