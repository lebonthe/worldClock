//
//  RegionTableViewCell.swift
//  worldClock
//
//  Created by Min Hu on 2023/12/15.
//

import UIKit

class RegionTableViewCell: UITableViewCell {

    // 顯示時間
    @IBOutlet weak var timeLabel: UILabel!
    // 顯示城市
    @IBOutlet weak var cityLabel: UILabel!
    // 顯示與當地時間是否同日
    @IBOutlet weak var isTodayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
