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
        let deg: Int?
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
    var now: Double = 0.00
    var max: Double = 0.00
    var min: Double = 0.00
    var flag: Bool = false
    
    func createUrl(city: String) -> String{
        let requestUrl = originalUrl + city + units + appKey
        print(requestUrl)
        //request(requestUrl: requestUrl)
        return requestUrl
    }
    
    func request(requestUrl: String) ->  (now: Double, max: Double, min: Double){

        
        guard let url = URL(string: requestUrl) else {
            self.now = 99.999
            self.max = 99.999
            self.min = 99.999
            return (now, max, min)
        }
        
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data: Data?,
            response: URLResponse?, error: Error?) in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            let resultData = try! JSONDecoder().decode(openWeatherMap.self, from: data)
            
            //print(resultData.main.temp)
            //print(resultData.main.temp_max)
            //print(resultData.main.temp_min)
            
            //self. = resultData.weather[0].main
            self.now = Double(resultData.main.temp)
            self.max = Double(resultData.main.temp_max)
            self.min = Double(resultData.main.temp_min)
            
            self.flag = true
            print("true")
            
            
        }
        task.resume()
        while flag == false{
            print("LoadNow...")
            sleep(1)
        }
        return (now, max, min)
        
    }
    
}
