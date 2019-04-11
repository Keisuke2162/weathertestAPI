//
//  DataBase.swift
//  weathertestAPI
//
//  Created by 植田圭祐 on 2019/04/12.
//  Copyright © 2019 Keisuke Ueda. All rights reserved.
//

import UIKit

class DataBase {
    
    var city: [String]
    var country: String
    
    init(nation: String, cities: [String]) {
        self.country = nation
        self.city = cities
    }
    
    static let cityData = [
        DataBase(nation: "Japan", cities: ["Tokyo","Osaka","Nagoya","Sendai"]),
        DataBase(nation: "England", cities: ["London","Manchester","Liverpool","Bristol"])
    ]
    
}
