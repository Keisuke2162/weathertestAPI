//
//  ViewController.swift
//  weathertestAPI
//
//  Created by 植田圭祐 on 2019/03/21.
//  Copyright © 2019 Keisuke Ueda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var nowTemp: UILabel!
    @IBOutlet weak var nowWeather: UILabel!
    @IBOutlet weak var clockLabel: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    struct main: Codable {
        let temp: Float
        let temp_min: Float
        let temp_max: Float
        let pressure: Float
        let sea_level: Float
        let grnd_level: Float
        let humidity: Float
        let temp_kf: Float
    }
    
    struct weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct clouds: Codable {
        let all: Int
    }
    
    struct wind: Codable {
        let speed: Float
        let deg: Float
    }
    
    struct rain: Codable {
        let three: Float?
        
        private enum CodingKeys: String, CodingKey {
            case three = "3h"
        }
    }
    
    struct sys: Codable {
        let pod: String
    }
    
    struct coord: Codable {
        let lat: Float
        let lon: Float
    }
    
    struct city: Codable {
        let id: Int
        let name: String
        let coord: coord
        let country: String
        let population: Int
    }
    
    struct list: Codable {
        let dt: Int
        let main: main
        let weather: [weather]
        let clouds: clouds
        let wind: wind
        let rain: rain?
        let sys: sys
        let dt_txt: String
    }
    
    struct weatherResult: Codable {
        let cod: String
        let message: Float
        let cnt: Int
        let list: [list]
        let city: city
    }
    
    
    let originalUrl = "http://api.openweathermap.org/data/2.5/forecast?q="
    
    let units = "&units=metric"
    let appKey = "&APPID=40a48ba11c0ea30426196bab04221fec"
    
    
    var tempArray = [Float]()
    var clockArray = [String]()
    var weatherArray = [String]()
    var city: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // request(requestUrl: requestUrl)

        // Do any additional setup after loading the view.
    }
    @IBAction func londonCity(_ sender: Any) {
        createUrl(city: "London")
    }
    
    @IBAction func tokyoCity(_ sender: Any) {
        createUrl(city: "Tokyo")
    }
    
    @IBAction func madridCity(_ sender: Any) {
        createUrl(city: "Madrid")
    }
    
    @IBAction func totsukaCity(_ sender: Any) {
        createUrl(city: "Totsuka")
    }
    
    func createUrl(city: String) {
        let requestUrl = originalUrl + city + units + appKey
        print(requestUrl)
        request(requestUrl: requestUrl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func request(requestUrl: String) {
        guard let url = URL(string: requestUrl) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data: Data?,response: URLResponse?, error: Error?) in
            
            guard error == nil else {
                let alert = UIAlertController(title: "ERRORだべ", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
                //decoder.keyDecodingStrategy = .convertFromSnakeCase
            let resultData = try! decoder.decode(weatherResult.self, from: data)
            
            
            self.weatherArray.removeAll()
            self.tempArray.removeAll()
            self.clockArray.removeAll()
            
            for i in 0...4 {
                let weather = resultData.list[i].weather[0].main
                let temp = resultData.list[i].main.temp
                let clock = resultData.list[i].dt_txt
                

                
                self.weatherArray.append(weather)
                self.tempArray.append(temp)
                self.clockArray.append(clock)
                
                print(resultData.list[i].main.temp)
                
                
                
            }

            let weatherMark = self.weatherArray[0]
            
            DispatchQueue.main.async {
                self.cityName.text = resultData.city.name
                self.nowTemp.text = String(self.tempArray[0])
                self.nowWeather.text = self.weatherArray[0]
                self.clockLabel.text = self.clockArray[0]
                self.weatherImage.image = UIImage(named: weatherMark)
            }
        }
        task.resume()
    }
}


