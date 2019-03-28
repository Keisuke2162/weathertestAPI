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


    let London: String = "London"
    //var requestUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request3hours = Get3hoursWeather()
        let requestNow = GetNowWeather()
        
        let requestUrl = request3hours.createUrl(city: London)
        let requestUrlNow = requestNow.createUrl(city: London)
        print("現在の天気URL\(requestUrlNow)")
        print("3時間毎の天気URL\(requestUrl)")
        
        let weatherResult = request3hours.request(requestUrl: requestUrl)
        print("returnOK")

        print(weatherResult)

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

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}


