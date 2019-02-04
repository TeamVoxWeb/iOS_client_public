//
//  Extentions.swift
//  CarsDemo
//
//  Created by Abhishek Chaudhari on 07/08/18.
//  Copyright © 2018 Abhishek Chaudhari. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addBorder(cornerRadius: CGFloat, borderColor: UIColor, borderWidth: CGFloat){
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
}

extension UIViewController {
    func addMenuButtom(withSelector: Selector){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style:.plain, target: self, action: withSelector)
    }
}

extension Date {
    static func getTimeString(fromTimeStamp: Int32) -> String{
        let dateString : String = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: Locale.current)!

        let is12Hr = dateString.contains("a") ? true:false

        let date = Date(timeIntervalSince1970: TimeInterval(fromTimeStamp))

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let currentYear = dateFormatter.string(from: Date())
        
        dateFormatter.dateFormat = "yyyy"
        let articleYear = dateFormatter.string(from: date)
        
        var dateFormat = (currentYear == articleYear) ? "dd MMMM," : "dd MMMM yyyy,"
        if is12Hr {
            dateFormat.append(" hh:mm a")
        }else{
            dateFormat.append(" HH:mm")
        }
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.string(from: date)
    }
}

extension UIScrollView {
    func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
        contentSize.height = contentSize.height + 11 //add bottom space
    }
}


