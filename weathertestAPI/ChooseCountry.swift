//
//  ChooseCountry.swift
//  weathertestAPI
//
//  Created by 植田圭祐 on 2019/04/11.
//  Copyright © 2019 Keisuke Ueda. All rights reserved.
//

import UIKit

class ChooseCountry: UIViewController {
    //
    let country = ["Japan","England"]
    
    //
    var countryName = ""
    var countryNumber = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        makeButton()
        
        // Do any additional setup after loading the view.
    }
    
    //
    func makeButton() {
        let screenWidth:CGFloat = self.view.frame.width
        //let screenHeight:CGFloat = self.view.frame.height
        
        //
        let width = screenWidth/4
        var rectY = 78.6
        let rectX = 23.75
        let height = 55
        
        //
        for i in 0..<country.count {
            //
            let button = UIButton()
            
            //
            button.frame = CGRect(x: 0, y: 0, width: 300, height: 500)
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 3
            
            //
            button.tag = i
            
            //
            if i != 0 && i % 3 == 0 {
                rectY += 100
            }
            
            //
            let xPlus = i % 3
            let x = rectX + (128.75 * Double(xPlus))
            let y = rectY
            
            print(y)
            
            //button.layer.position = CGPoint(x: self.view.frame.width/i, y: 100)
            
            //
            button.frame = CGRect(x:CGFloat(x), y:CGFloat(y), width:width, height:CGFloat(height))
            button.setImage(UIImage(named: country[i]), for: .normal)
            
            //
            button.setTitle(country[i], for: .normal)
            button.setTitleColor(UIColor.blue, for: .normal)
            
            //
            button.addTarget(self, action: #selector(ChooseCountry.tapButton(sender:)), for: .touchUpInside)
            
            //
            self.view.addSubview(button)
            
        }
    }
    
    //
    @objc func tapButton(sender: UIButton) {
        //print(sender.tag)
        //print(country[sender.tag])
        
        //let couName = country[sender.tag]
        //
        countryName = country[sender.tag]
        countryNumber = String(sender.tag)
        
        //
        self.performSegue(withIdentifier: "weatherView", sender: nil)
        //ObjectTest_1().EarthDisplay()
    }
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let next = segue.destination as? ObjectTest_1
        //let _ = next?.view
        //print(countryName)
        //next?.hugTestValue.text = countryName
        //next?.cntrNum.text = countryNumber
        
    }
    
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
