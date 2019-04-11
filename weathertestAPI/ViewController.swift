//
//  ViewController.swift
//  weathertestAPI
//
//  Created by 植田圭祐 on 2019/03/21.
//  Copyright © 2019 Keisuke Ueda. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var weatherView: UIView!
    
    var city: String = ""
    //var requestUrl: String = ""
    
    var weatherNow: (now: Double, max: Double, min: Double)!
    var weatherResult: (wewather: [String], temp: [Float], clock: [String])!
    var data: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //背景画像を設定する
        let bg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        //bg.image = UIImage(named: "London_morning")
        bg.image = UIImage(named: "London_night")
        //画面のどの層に画像を配置するか（背景なので一番深くする）
        bg.layer.zPosition = -1
        self.view.addSubview(bg)
 
       //outputWeather()
        
        /*print("LetsGoGraph")
        let makeGraph = GraphView()
        makeGraph.graphMake()
*/
        // Do any additional setup after loading the view.
      /*
        //天気情報取得処理
        getWeatherData(country: city)
        //グラフをセットする
        setGraph()
        //ラベルに気象情報を表示（気温とか）
        nowWeatherPut()
    */
    }
    
    @IBAction func city1button(_ sender: Any) {
        city = "Liverpool"
        getWeatherData(country: city)
        setGraph()
        nowWeatherPut()
    }
    
    @IBAction func city2button(_ sender: Any) {
        city = "Bristol"
        getWeatherData(country: city)
        setGraph()
        nowWeatherPut()
    }
    
    @IBAction func city3button(_ sender: Any) {
        city = "Manchester"
        getWeatherData(country: city)
        setGraph()
        nowWeatherPut()
    }
    
    @IBAction func city4button(_ sender: Any) {
        city = "London"
        getWeatherData(country: city)
        setGraph()
        nowWeatherPut()
    }
    
    @IBAction func generalButton(_ sender: Any) {
        
    }
    
    
    func getWeatherData(country: String) {
        //3時間毎の天気情報、現在の天気情報取得クラスをインスタンス化
        let request3hours = Get3hoursWeather()
        let requestNow = GetNowWeather()
        
        //3時間毎＆現在の天気情報取得APIのURLを作成する処理に飛ばす（引数は都市名）
        let requestUrl = request3hours.createUrl(city: country)
        let requestUrlNow = requestNow.createUrl(city: country)
        
        print("現在の天気URL\(requestUrlNow)")
        print("3時間毎の天気URL\(requestUrl)")
        
        //3時間毎の天気情報をリクエスト
        weatherResult = request3hours.request(requestUrl: requestUrl)
        print("returnOK")
        
        //現在の天気情報をリクエスト
        weatherNow = requestNow.request(requestUrl: requestUrlNow)
        print("returnOK2")
        
        print(weatherResult)
        print(weatherNow)
        
    }
    
    //scrollViewに気象情報を表示（多分実装はしない）
    func outputWeather() {
        
        //リクエストからの返答を受け取る
        guard let nextWeather = weatherResult else {
            return
        }
        guard let nowWeather = weatherNow else {
            return
        }
        
        
        var x = 10
        for i in 0...7 {
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
    }
    
    //グラフ表示処理
    func setGraph(){
        //天気情報をセット
        guard let nextWeather = weatherResult else {
            return
        }
        
        //
        let weatherStr = nextWeather.wewather[0]
        print(weatherStr)
        weatherImage.backgroundColor = UIColor.lightGray.withAlphaComponent(0.50)
        //天気情報の頭のお天気をアイコン（大）に表示
        weatherImage.image = UIImage(named: weatherStr)
        
        //気温情報をセット（配列）
        let sales = nextWeather.temp

        //時刻情報を配列に格納していく（時刻情報は前後を切り取ってる）
        for i in 0..<nextWeather.clock.count {
            data.append(String(nextWeather.clock[i].suffix(8).prefix(5)))
        }
        //let times = ["18","21","24","3","6","9","12","15"]
        
        //グラフ描画処理へGO（引数は気温配列＆時刻配列）
        setChart(values: sales, time: data)
    }
    
    //グラフ描画処理
    func setChart(values: [Float], time: [String]) {
        //ChartDataEntry型の配列を宣言
        var entry = [ChartDataEntry]()
        
        for i in 0..<values.count {
            //xにデータの値、yに横軸の値のセットを配列に追加
            entry.append(ChartDataEntry(x: Double(i), y: Double(values[i]) ))
        }
        
        //ChartDataEntry型の配列をグラフにセット！
        let dataSet = LineChartDataSet(values: entry, label: nil)
        //折れ線の色
        dataSet.colors = [UIColor.blue]
        //点の大きさ
        dataSet.circleRadius = 4
        //点の色
        dataSet.circleColors = [UIColor.purple]
        //dataSet.setColor(UIColor.white)
        //dataSet.highlightColor = UIColor.white
        //グラフの背景(グレーかつ半透明)
        lineChart.backgroundColor = UIColor.lightGray.withAlphaComponent(0.50)
        
        //X軸にラベルを設定
        let xAxis = lineChart.xAxis
        xAxis.valueFormatter = IndexAxisValueFormatter(values: time)
        //Viewにグラフを描画
        lineChart.data = LineChartData(dataSet: dataSet)
    }
    
    //現在の気象情報を使って表示とか
    func nowWeatherPut() {
        guard let nowWeather = weatherNow else {
            return
        }
        
        let temp = nowWeather.now
        tempLabel.backgroundColor = UIColor.lightGray.withAlphaComponent(0.50)
        tempLabel.text = String(format: "%.2f ℃", temp)
    }
    
    //い　つ　も　の
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}


