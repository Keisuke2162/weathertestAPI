//
//  ViewController.swift
//  weathertestAPI
//
//  Created by 植田圭祐 on 2019/03/21.
//  Copyright © 2019 Keisuke Ueda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherView: UIView!
    
    let London: String = "Kawasaki"
    //var requestUrl: String = ""
    
    var weatherNow: (now: Double, max: Double, min: Double)!
    var weatherResult: (wewather: [String], temp: [Float], clock: [String])!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let request3hours = Get3hoursWeather()
        let requestNow = GetNowWeather()
        
        let requestUrl = request3hours.createUrl(city: London)
        let requestUrlNow = requestNow.createUrl(city: London)
        
        print("現在の天気URL\(requestUrlNow)")
        print("3時間毎の天気URL\(requestUrl)")
        
        weatherResult = request3hours.request(requestUrl: requestUrl)
        print("returnOK")
        
        weatherNow = requestNow.request(requestUrl: requestUrlNow)
        print("returnOK2")

        print(weatherResult)
        print(weatherNow)
 
       outputWeather()

        // Do any additional setup after loading the view.
    }
   /* @IBAction func londonCity(_ sender: Any) {
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
    }*/

    
    func outputWeather() {
        
        guard let nextWeather = weatherResult else {
            return
        }
        guard let nowWeather = weatherNow else {
            return
        }
        var x = 10
        for i in 0...10 {
            //let str = " 15:00\n Clear\n 19"
            let nextLabel_1 = UILabel()
            let weather = nextWeather.clock[i].suffix(8).prefix(5)
            nextLabel_1.numberOfLines = 0
//            nextLabel_1.frame = CGRect(x: x, y: 300, width: 160, height: 150)
            nextLabel_1.frame = CGRect(x: x, y: 0, width: 160, height: 150)
            //nextLabel_1.text = ("\(nextWeather.clock[i])\n\(nextWeather.wewather[i])\n\(nextWeather.temp[i])")
            nextLabel_1.text = ("\(weather)\n\(nextWeather.wewather[i])\n\(nextWeather.temp[i])")
            //nextLabel_1.text = str
            nextLabel_1.font = UIFont.systemFont(ofSize: 15)
            x += 75
            //self.view.addSubview(nextLabel_1)
            self.weatherView.addSubview(nextLabel_1)
            
            //
           
        }
        let nowLabel = UILabel()
        nowLabel.numberOfLines = 0
        nowLabel.frame = CGRect(x: 10, y: 200, width: 160, height: 150)
        nowLabel.font = UIFont.systemFont(ofSize: 15)
        nowLabel.text = ("現在の気温⇨\(Float(nowWeather.now))")
        self.view.addSubview(nowLabel)
        
        //print(str)
        
    /*    let nextLabel_2 = UILabel()
        nextLabel_2.frame = CGRect(x: 10, y: 400, width: 160, height: 30)
        //nextLabel_1.text = nextWeather.wewather[0]
        nextLabel_2.text = "Clear"
        nextLabel_2.font = UIFont.systemFont(ofSize: 30)
        
        let nextLabel_3 = UILabel()
        nextLabel_3.frame = CGRect(x: 10, y: 500, width: 160, height: 30)
        //nextLabel_1.text = nextWeather.wewather[0]
        nextLabel_3.text = "19℃"
        nextLabel_3.font = UIFont.systemFont(ofSize: 30) */
        

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}


