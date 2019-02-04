//
//  Constants.swift
//  CarsDemo
//
//  Created by Abhishek Chaudhari on 07/08/18.
//  Copyright © 2018 Abhishek Chaudhari. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct GENERAL {
        static let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate
        static let SCREEN_SIZE: CGRect = UIScreen.main.bounds
    }
    
    struct API {
        static let GET_JSON_DATA_API = "https://www.apphusetreach.no/application/119267/article/get_articles_list"
    }
}
