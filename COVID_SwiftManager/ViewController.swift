//
//  ViewController.swift
//  COVID_SwiftManager
//
//  Created by Amit Gupta on 10/19/20.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController {

    /*
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var buttonRefresh: UIButton!
    @IBOutlet weak var labelIncreaseDeaths: UILabel!
    @IBOutlet weak var labelDeaths: UILabel!
    @IBOutlet weak var labelTotalTests: UILabel!
    @IBOutlet weak var labelPositiveTests: UILabel!
    @IBOutlet weak var labelNegativeTests: UILabel!
    */
    
    @IBOutlet weak var buttonRefresh: UIButton!
    
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var labelIncreaseDeaths: UILabel!
    
    @IBOutlet weak var labelDeaths: UILabel!
    
    @IBOutlet weak var labelTotalTests: UILabel!
    
    
    @IBOutlet weak var labelPositiveTests: UILabel!
    
    @IBOutlet weak var labelNegativeTests: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        print("Button pressed")
        buttonRefresh.setTitle("Updating...", for: UIControl.State.normal)
        let uploadURL="https://api.covidtracking.com/v1/us/current.json"
        let params:[String:String]=[:]
        debugPrint("Calling the AI service with URL=",uploadURL," and params = ",params)
        
        AF.request(uploadURL).responseJSON { response in
            //debugPrint("AF.Response:",response)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                debugPrint("Initial value is ",value)
                debugPrint("Initial JSON is ",json)
                self.labelDate.text="Date: " + json[0]["date"].stringValue
                //self.states=json[0]["states"].intValue
                self.labelPositiveTests.text="Positive tests : " + (Int(json[0]["positive"].stringValue)?.withCommas())!
                self.labelNegativeTests.text="Negative tests: " + (Int(json[0]["negative"].stringValue)?.withCommas())!
                self.labelDeaths.text="Deaths: " + (Int(json[0]["death"].stringValue)?.withCommas())!
                self.labelTotalTests.text="Total tests: " + (Int(json[0]["totalTestResults"].stringValue)?.withCommas())!
                self.labelIncreaseDeaths.text="Increase in deaths: " + (Int(json[0]["deathIncrease"].stringValue)?.withCommas())!
                self.buttonRefresh.setTitle("Updated", for: UIControl.State.normal)
            case .failure(let error):
                print("\n\n Request failed with error: \(error)")
            }
        }
    }
}

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}


