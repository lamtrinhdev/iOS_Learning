//
//  WeatherTableViewCell.swift
//  Chapter_02
//
//  Created by Lam Trinh Tran Truc on 10-December-2021.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bind(_ data: WeatherDataDailyModel) {
        self.titleLabel.text = data.date
        self.detailsLabel.text = data.averageTemp
    }
}
