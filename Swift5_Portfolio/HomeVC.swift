//
//  ViewController.swift
//  Swift5_Portfolio
//
//  Created by Harry Shen on 21/1/20.
//  Copyright © 2020 Harry Shen. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var locationLb: UILabel!
    @IBOutlet weak var timeLb: UILabel!
    @IBOutlet weak var tempLb: UILabel!
    
    var timer = Timer()
    let APIUrl = NSURL(string:"http://api.openweathermap.org/data/2.5/weather?id=2207259&appid=0a2e31671a8a7afa15bfe84802130cff&units=metric")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set title of the navigation bar
        self.navigationItem.title = "Harry's Portfolio"
        // Set as Large font
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.tick), userInfo: nil, repeats: true)
        if let url = APIUrl {
            getTP(APIString: url)
        }
        getTimeZone()
    }
    
    func getTimeZone() {
        var secondsFromGMT: Int { return TimeZone.current.secondsFromGMT()}
        print("Your seconds: \(secondsFromGMT)")
        
        var localTimeZoneAbbr: String { return TimeZone.current.abbreviation() ?? ""}
        print(localTimeZoneAbbr)
        
        var localTimeName: String { return TimeZone.current.identifier }
        print(localTimeName)
        self.locationLb.text = localTimeName
    }
    
    func getTP(APIString url: NSURL) {
            var request = URLRequest(url: url as URL)
            request.httpMethod = "GET"
            let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error ?? "Error is empty.")
                } else {
                    let httpResponse = response as? HTTPURLResponse
                    print(httpResponse ?? "HTTP response is empty.")
                }
                
                guard let responseData = data else {
                    print("Error: did not receive data")
                    return
                }
                
    //            if let responseString = NSString(data: responseData, encoding: String.Encoding.utf8.rawValue) {
    //                print("Response: \(responseString)")
    //            }
                
                do {
                    
                    let weatherData = try JSONDecoder().decode(MyWeather.self, from: responseData)
                    let ggtemp = weatherData.main.temp
                    print(ggtemp, "THIS IS THE TEMP")
    
                    DispatchQueue.main.async {
                        self.tempLb.text = String(ggtemp) + " c"
                    }
                    
                } catch let err {
                    print("error parsing response from POST on /todos")
                    print(err)
                    return
                }
            })
            dataTask.resume()
        }
    
    @objc func tick() {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "HH:mm:ss"
            let date = dateFormat.string(from: Date())
            timeLb.text = "Current Local Time \(date)"
    //        timeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
            
        }
    
}

