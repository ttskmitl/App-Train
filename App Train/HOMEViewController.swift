//
//  HOMEViewController.swift
//  App Train
//
//  Created by Peeranut Sapniti on 9/4/2560 BE.
//  Copyright © 2560 Arisara Corp. All rights reserved.
//

import UIKit

class HOMEViewController: UIViewController {

    @IBOutlet weak var Train: UIButton!
    @IBOutlet weak var station: UIButton!
    
    @IBOutlet weak var MyBG: UIImageView!
    
    @IBOutlet weak var stationIcon: UIImageView!
    @IBOutlet weak var trainIcon: UIImageView!
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Train.titleLabel?.textAlignment = NSTextAlignment.center
        station.titleLabel?.textAlignment = NSTextAlignment.center
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
