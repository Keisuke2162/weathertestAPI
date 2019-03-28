//
//  GetNowWeather.swift
//  weathertestAPI
//
//  Created by 植田圭祐 on 2019/03/25.
//  Copyright © 2019 Keisuke Ueda. All rights reserved.
//

import UIKit

class GetNowWeather {
    struct coord: Codable {
        let lon: Float
        let lat: Float
    }
    
    struct weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct main: Codable {
        let temp: Float
        let pressure: Int
        let humidity: Int
        let temp_min: Float
        let temp_max: Float
    }
    
    struct wind: Codable {
        let speed: Float
        let deg: Int
    }
    
    struct clouds: Codable {
        let all: Int
    }
    
    struct sys: Codable {
        let type: Int
        let id: Int
        let message: Float
        let country: String
        let sunrise: Int
        let sunset: Int
    }
    
    struct openWeatherMap: Codable {
        let coord: coord
        let weather: [weather]
        let base: String
        let main: main
        let visibility: Int
        let wind: wind
        let clouds: clouds
        let dt: Int
        let sys: sys
        let id: Int
        let name: String
        let cod: Int
    }
    
    var weatherResult = [String]()
    
    let originalUrl = "http://api.openweathermap.org/data/2.5/weather?q="
    let units = "&units=metric"
    let appKey = "&APPID=40a48ba11c0ea30426196bab04221fec"
    
    func createUrl(city: String) -> String{
        let requestUrl = originalUrl + city + units + appKey
        print(requestUrl)
        //request(requestUrl: requestUrl)
        return requestUrl
    }
    
}
