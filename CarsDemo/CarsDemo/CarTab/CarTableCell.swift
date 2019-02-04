//
//  CarTableCell.swift
//  CarsDemo
//
//  Created by Abhishek Chaudhari on 07/08/18.
//  Copyright © 2018 Abhishek Chaudhari. All rights reserved.
//

import UIKit
import SDWebImage

class CarTableCell: UITableViewCell {

    @IBOutlet weak var gradientView: UIView!
    let gradientLayer = CAGradientLayer()
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let color1 = UIColor.clear.cgColor as CGColor
        let color2 = UIColor.clear.cgColor as CGColor
        let color3 = UIColor.black82.cgColor as CGColor
        let color4 = UIColor(white: 0.0, alpha: 1.0).cgColor as CGColor
        gradientLayer.colors = [color1, color2,color3, color4]
        gradientLayer.locations = [0.0, 0.5, 0.6, 1.0]
        gradientView.layer.addSublayer(gradientLayer)

        titleLabel.font = UIFont.listTitle
        descriptionLabel.font = UIFont.listIngress
        timeLabel.font = UIFont.dateTime
        
        titleLabel.textColor=UIColor.white
        descriptionLabel.textColor=UIColor.white
        timeLabel.textColor=UIColor.greyish

        // Initialization code
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()

        // update gradient
        gradientLayer.frame = contentView.bounds
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    ● If within current year: “[day] [month], [time]”. For example: “16 March, 12:34”
//    ● If within different year: “[day] [month] [year], [time]”. For example: “20 December 2017, 21:43”
//    Time should follow system settings for 12h / 24h format, for example “09:43 PM” vs “21:43”.
    func updateCellWith(carObj: Car) {
        titleLabel.text = carObj.title
        descriptionLabel.text = carObj.ingress

        timeLabel.text = Date.getTimeString(fromTimeStamp: carObj.created)
        
        if (carObj.image != nil) {
            carImageView.sd_setImage(with: URL(string: carObj.image!), placeholderImage: nil, options: .progressiveDownload, completed: nil)
        }else{
            carImageView.image = nil
        }
    }
}
