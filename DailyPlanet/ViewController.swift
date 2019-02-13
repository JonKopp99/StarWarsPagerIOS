//
//  ViewController.swift
//  DailyPlanet
//
//  Created by Thomas Vandegriff on 2/7/19.
//  Copyright © 2019 Make School. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController{
var label1 = UILabel()
var label2 = UILabel()
var label3 = UILabel()
    
var prevButton = UIButton()
var nextButton = UIButton()
    
var currentIndex = 1

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchHeaderData()
        
        //TODO: Call function to fetch image data here
        fetchNasaDailyImage()
        
        
        label1.frame = CGRect(x: 10, y: 20, width: self.view.bounds.width - 20, height: 50)
        label2.frame = CGRect(x: 10, y: 70, width: self.view.bounds.width - 20, height: 50)
        label3.frame = CGRect(x: 10, y: 120, width: self.view.bounds.width - 20, height: 50)
        
        label1.font = UIFont(name: "Arial-BoldMT", size: 40)
        label2.font = UIFont(name: "Arial-BoldMT", size: 40)
        label3.font = UIFont(name: "Arial-BoldMT", size: 40)
        
        label1.textAlignment = .center
        label2.textAlignment = .center
        label3.textAlignment = .center
        
        label1.textColor = .black
        label2.textColor = .black
        label3.textColor = .black
        
        prevButton.frame = CGRect(x: 0, y: self.view.bounds.height - 100, width: 200, height: 50)
        nextButton.frame = CGRect(x: self.view.bounds.width - 200, y: self.view.bounds.height - 100, width: 200, height: 50)
        prevButton.setTitle("Previous", for: .normal)
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), for: .normal)
        prevButton.setTitleColor(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), for: .normal)
        nextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        prevButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        self.view.addSubview(label1);self.view.addSubview(label2);self.view.addSubview(label3)
        self.view.addSubview(prevButton);self.view.addSubview(nextButton)
        
    }
    @objc func nextPressed()
    {
        if(currentIndex != 87)
        {
            currentIndex += 1
        }
        fetchNasaDailyImage()
    }
    @objc func prevPressed()
    {
        if(currentIndex != 1)
        {
            currentIndex -= 1
        }
        fetchNasaDailyImage()
    }
    //MARK: Data Fetch functions
    
    func fetchHeaderData() {
        
        let defaultSession = URLSession(configuration: .default)
        
        // Create URL
        let url = URL(string: "https://httpbin.org/headers")
        
        // Create Request
        let request = URLRequest(url: url!)
        
        // Create Data Task
        let dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
//            print("data is: ", data!)
//            print("response is: ", response!)
            
        })
        dataTask.resume()
    }

    
     // CODE BASE for In-Class Activity I
    func fetchNasaDailyImage() {
        
        //TODO: Create session configuration here
        let defaultSession = URLSession(configuration: .default)
        
        //TODO: Create URL (...and send request and process response in closure...)
        let theUrl = ("https://swapi.co/api/people/" + String(currentIndex))
        if let url = URL(string: theUrl) {
            
           //TODO: Create Request here
            let request = URLRequest(url: url)
            // Create Data Task...
            let dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                if(error != nil)
                {
                    print(error!)
                    return
                }
//                print("data is: ", data!)
//                print("response is: ", response!)
                
                do {
                    
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                   
                     DispatchQueue.main.async {
                        let name = jsonObject!["name"] as! String
                        print(name)
                        self.label1.text = name
                        let gender = jsonObject!["gender"] as! String
                        print(gender)
                        self.label2.text = gender
                        let eyeColor = jsonObject!["eye_color"] as! String
                        print(eyeColor)
                        self.label3.text = eyeColor
                    }
                    
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            })
            dataTask.resume()
        }
    }
}

