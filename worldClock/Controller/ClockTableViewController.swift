//
//  ClockTableViewController.swift
//  worldClock
//
//  Created by Min Hu on 2023/12/15.
//

import UIKit

class ClockTableViewController: UITableViewController {

    let citys = [
        TimeZoneInfo(timeZone: seperateCity(TimeZone: citysInput[0]), time: getCurrentTime(city:citysInput[0]), isToday: isWhichDay(city: citysInput[0]), jetLag: getDaysDiff(city: citysInput[0])),
        TimeZoneInfo(timeZone: seperateCity(TimeZone: citysInput[1]), time: getCurrentTime(city:citysInput[1]), isToday: isWhichDay(city: citysInput[1]), jetLag: getDaysDiff(city: citysInput[1])),
        TimeZoneInfo(timeZone: seperateCity(TimeZone: citysInput[2]), time: getCurrentTime(city:citysInput[2]), isToday: isWhichDay(city: citysInput[2]), jetLag: getDaysDiff(city: citysInput[2])),
        TimeZoneInfo(timeZone: seperateCity(TimeZone: citysInput[3]), time: getCurrentTime(city:citysInput[3]), isToday: isWhichDay(city: citysInput[3]), jetLag: getDaysDiff(city: citysInput[3])),
        TimeZoneInfo(timeZone: seperateCity(TimeZone: citysInput[4]), time: getCurrentTime(city:citysInput[4]), isToday: isWhichDay(city: citysInput[4]), jetLag: getDaysDiff(city: citysInput[4])),
        TimeZoneInfo(timeZone: seperateCity(TimeZone: citysInput[5]), time: getCurrentTime(city:citysInput[5]), isToday: isWhichDay(city: citysInput[5]), jetLag: getDaysDiff(city: citysInput[5])),
        TimeZoneInfo(timeZone: seperateCity(TimeZone: citysInput[6]), time: getCurrentTime(city:citysInput[6]), isToday: isWhichDay(city: citysInput[6]), jetLag: getDaysDiff(city: citysInput[6])),
        TimeZoneInfo(timeZone: seperateCity(TimeZone: citysInput[7]), time: getCurrentTime(city:citysInput[7]), isToday: isWhichDay(city: citysInput[7]), jetLag: getDaysDiff(city: citysInput[7]))
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }


   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return citys.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 從表格視圖隊列中重用一個 cell，使用 RegionTableViewCell 的標識符。
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(RegionTableViewCell.self)", for: indexPath) as? RegionTableViewCell else { fatalError("dequeueReusableCell RegionTableViewCell failed") }
        

        // 根據當前行的索引從 citys 的 array 中獲取一個城市實例
        let city = citys[indexPath.row]

        // 將時區放入 cityLabel
        cell.cityLabel.text = city.timeZone

        // 設定 timeLabel 的自定義字體格式，因為從 customLabelFount 函數返回一個 NSAttributedString 型別的文字
        cell.timeLabel.attributedText = customLabelFount(text: city.time)

        // 設置 cell 中表示是否為今天的 isTodayLabel.text
        cell.isTodayLabel.text = city.isToday

        // 將時差放到 isTodayLabel.text 之後
        cell.isTodayLabel.text?.append(city.jetLag)

        // 返回配置好的 cell
        return cell
    }

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
