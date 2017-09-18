//
//  LocationViewController.swift
//  NEWApp
//
//  Created by Nithit Sathornlak on 3/15/2560 BE.
//  Copyright © 2560 Arisara Corp. All rights reserved.
//

import UIKit

class view: UIViewController {
    
    @IBOutlet weak var myLabel1: UILabel!
    @IBOutlet weak var mygray: UIView!
    @IBOutlet weak var myCurrentPosition: UILabel!
    @IBOutlet weak var myNextStation: UILabel!
    @IBOutlet weak var NumberOfTrain: UILabel!
    @IBOutlet weak var LabelOfTrain1: UILabel!
    @IBOutlet weak var LabelOfTrain2: UILabel!
    @IBOutlet weak var nowstation1: UILabel!
    @IBOutlet weak var nowstation2: UILabel!
    @IBOutlet weak var nextstation1: UILabel!
    @IBOutlet weak var nextstation2: UILabel!
    @IBOutlet weak var labelforupdate: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        _ = Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(self.viewDidAppear(_:)), userInfo: nil, repeats: true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear( _: Bool) {
        // ViewControllers view ist fully loaded and could present further ViewController
        //Here you could do any other UI operations
        if Reachability.isConnectedToNetwork() == true
        {
            
            
            let url = URL(string: "http://train.telecom.kmitl.ac.th/downloadlatlng283.php")
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error != nil
                {
                    print ("ERROR")
                }
                else
                {
                    if let content = data
                    {
                        do
                        {
                            if let myJsonArray = try JSONSerialization.jsonObject(with: content, options: .allowFragments) as? Array<AnyObject>
                            {
                                
                                var lat = ""
                                var long = ""
                                var d = ""
                                var sv = ""
                                
                                for myJson in myJsonArray
                                {
                                    if let L = myJson["L"] as? String
                                    {
                                        lat = L
                                    }
                                    else
                                    {
                                        lat = ""
                                    }
                                    
                                    if let n = myJson["n"] as? String
                                    {
                                        long = n
                                    }
                                    else
                                    {
                                        long = ""
                                    }
                                    if let day = myJson["day"] as? String
                                    {
                                        d = day
                                    }
                                    else
                                    {
                                        d = ""
                                    }
                                    
                                    if let s = myJson["s"] as? String
                                    {
                                        sv = s
                                    }
                                    else
                                    {
                                        sv = ""
                                    }
                                    
                                    
                                    let date = Date()
                                    let calender = Calendar.current
                                    
                                    let hour = calender.component(.hour, from: date)
                                    
                                    
                                    self.labelforupdate.text = "updated: \(d)"
                                    
                                    let la = Double(lat)
                                    let ln = Double(long)
                                    let service = Int(sv)
                                    
                                    
                                    var direction = 0
                                    var index = 0
                                    
                                    
                                    
                                    
                                    
                                    let stationName:[String] = ["กรุงเทพ","พญาไท","มักกะสัน","อโศก","คลองตัน","สุขุมวิท 71","หัวหมาก","บ้านทับช้าง","ซอยวัดลานบุญ","ลาดกระบัง","พระจอมเกล้า","หัวตะเข้","คลองหลวงแพ่ง","คลองอุดมชลจร","เปรง","คลองแขวงกลั่น","คลองบางพระ","บางเตย","ชุมทางฉะเชิงเทรา","แปดริ้ว","ดอนสีนนท์","พานทอง","ชลบุรี","บางพระ","เขาพระบาท","ชุมทางศรีราชา","บางละมุง","พัทยา","พัทยาใต้","ตลาดน้ำสี่ภาค","บ้านห้วยขวาง","ญาณสังวราราม","สวนนงนุช","ชุมทางเขาชีจรรย์","บ้านพลูตาหลวง"];
                                    
                                    let stationNameENG:[String] = ["BANGKOK HUALAMPONG","Phayathai","Makkasan","Asoke","Khlong Tan","Sukhumvit 71",
                                                                   "Hua Mak","Ban Thap Chang","Soi Wat Lan Boon","Lat Krabang","Pra Chom Klao","Hua Takhe","Khlong Luang Phaeng",
                                                                   "Khlong Udom Chonlajorn","Preng","Khlong Kwaeng Klan","Khlong Bang Phra","Bang Toey","Chachoengsao Junction",
                                                                   "Paet Riu","Don Si Non","Phan Thong","Chon Buri","Bang Phra","Khao Phrabat","Si Racha Junction",
                                                                   "Bang Lamung","Pattaya","Pattaya Tai","Talad Nam Si Phak","Ban Huai Kwang","Yanasangwararam",
                                                                   "Suan Nong Nuch","Kaochichan Junction","Ban Plu Ta Luang",];
                                    
                                    
                                    
                                    let stationTable:[[Double]] = [	[	13.734988   ,   13.743988   ,   100.512247  ,   100.521247	],	//	กรุงเทพ
                                        [	13.743998   ,   13.767855   ,   100.512247  ,   100.528571	],	//	กรุงเทพ-พญาไท
                                        [	13.752534   ,   13.761534   ,   100.528581  ,   100.537581	],	//	พญาไท
                                        [	13.749211	,   13.761534	,   100.537591	,   100.542881	],	//	พญาไท-มักกะสัน
                                        [	13.749211	,   13.758211	,   100.542891	,   100.551891	],	//	มักกะสัน
                                        [	13.745856	,   13.758211	,   100.551901	,   100.558616	],	//	มักกะสัน-อโศก
                                        [	13.745856	,   13.754856	,   100.558626	,   100.567626	],	//	อโศก
                                        [	13.741226	,   13.754856	,   100.567636	,   100.586695	],	//	อโศก-คลองตัน
                                        [	13.741226	,   13.747226	,   100.586705	,   100.592705	],	//	คลองตัน
                                        [	13.739971	,   13.747226	,   100.592715	,   100.597254	],	//	คลองตัน-สุขุมวิท 71
                                        [	13.739971	,   13.745971	,   100.597264	,   100.603264	],	//	สุขุมวิท 71
                                        [	13.733767	,   13.745971	,   100.603274	,   100.635342	],	//	สุขุมวิท 71-หัวหมาก
                                        [	13.733767	,   13.742767	,   100.635352	,   100.644352	],	//	หัวหมาก
                                        [	13.728604	,   13.742767	,   100.644362	,   100.684222	],	//	หัวหมาก-บ้านทับช้าง
                                        [	13.728604	,   13.737604	,   100.684232	,   100.693232	],	//	บ้านทับช้าง
                                        [	13.725295	,	13.737604	,	100.693242	,	100.713642	],	//	บ้านทับช้าง-ซอยวัดลานบุญ
                                        [	13.725295	,	13.734295	,	100.713652	,	100.722652	],	//	ซอยวัดลานบุญ
                                        [	13.723117	,	13.734295	,	100.722662	,	100.744137	],	//	ซอยวัดลานบุญ-ลาดกระบัง
                                        [	13.723117	,	13.732117	,	100.744147	,	100.753147	],	//	ลาดกระบัง
                                        [	13.72524	,	13.732117	,	100.753157	,	100.77239	],	//	ลาดกระบัง-พระจอมเกล้า
                                        [	13.72524	,	13.73124	,	100.7724	,	100.7784	],	//	พระจอมเกล้า
                                        [	13.72524	,	13.731468	,	100.77841	,	100.779861	],	//	พระจอมเกล้า-หัวตะเข้
                                        [	13.725468	,	13.731468	,	100.779871	,	100.785871	],	//	หัวตะเข้
                                        [	13.715631	,	13.731468	,	100.785881	,	100.858345	],	//	หัวตะเข้-คลองหลวงแพ่ง
                                        [	13.715631	,	13.724631	,	100.858355	,	100.867355	],	//	คลองหลวงแพ่ง
                                        [	13.712106	,	13.724631	,	100.867365	,	100.89476	],	//	คลองหลวงแพ่ง-คลองอุดมชลจร
                                        [	13.712106	,	13.721106	,	100.89477	,	100.90377	],	//	คลองอุดมชลจร
                                        [	13.706353	,	13.721106	,	100.90378	,	100.923881	],	//	คลองอุดมชลจร-เปรง
                                        [	13.706353	,	13.715353	,	100.923891	,	100.932891	],	//	เปรง
                                        [	13.702468	,	13.715353	,	100.932901	,	100.958396	],	//	เปรง-คลองแขวงกลั่น
                                        [	13.702468	,	13.711468	,	100.958406	,	100.967406	],	//	คลองแขวงกลั่น
                                        [	13.699568	,	13.711468	,	100.967416	,	100.986945	],	//	คลองแขวงกลั่น-คลองบางพระ
                                        [	13.699568	,	13.708568	,	100.986955	,	100.995955	],	//	คลองบางพระ
                                        [	13.695743	,	13.708568	,	100.995965	,	101.013495	],	//	คลองบางพระ-บางเตย
                                        [	13.695743	,	13.704743	,	101.013505	,	101.022505	],	//	บางเตย
                                        [	13.686145	,	13.704743	,	101.022515	,	101.050713	],	//	บางเตย-ชุมทางฉะเชิงเทรา
                                        [	13.686145	,	13.704145	,	101.050723	,	101.070902	],	//	ชุมทางฉะเชิงเทรา
                                        [	13.686145	,   13.704145	,   101.070912	,   101.073763	],	//	ชุมทางฉะเชิงเทรา-แปดริ้ว
                                        [	13.689895   ,   13.695895	,   101.073773	,   101.079773	],	//	แปดริ้ว
                                        [	13.611066   ,   13.707908	,   101.079783	,   101.129733	],	//	แปดริ้ว-ดอนสีนนท์
                                        [	13.593066	,   13.611066	,   101.101032	,   101.119032	],	//	ดอนสีนนท์
                                        [	13.471978	,   13.593056	,   101.072307	,   101.119032	],	//	ดอนสีนนท์-พานทอง
                                        [	13.453968	,   13.471968	,   101.072307	,   101.090307	],	//	พานทอง
                                        [	13.351346	,   13.453958	,   100.984688	,   101.090307	],	//	พานทอง-ชลบุรี
                                        [	13.333336	,   13.351336	,   100.984688	,   101.011688	],	//	ชลบุรี
                                        [	13.240224	,   13.333326	,   100.949029	,   101.011688	],	//	ชลบุรี-บางพระ
                                        [	13.231214	,   13.240214	,   100.949029	,   100.958029	],	//	บางพระ
                                        [	13.206994	,   13.231204	,   100.937271	,   100.958029	],	//	บางพระ-เขาพระบาท
                                        [	13.197984	,   13.206984	,   100.937271	,   100.950771	],	//  เขาพระบาท
                                        [	13.165016	,   13.197974	,   100.936726	,   100.954726	],	//	เขาพระบาท-ชุมทางศรีราชา
                                        [	13.147006	,   13.165006	,   100.936726	,   100.954726	],	//	ชุมทางศรีราชา
                                        [	13.043494	,   13.146996	,   100.930955	,   100.954726	],	//	ชุมทางศรีราชา-บางละมุง
                                        [	13.025484	,   13.043484	,   100.930955	,   100.948955	],	//	บางละมุง
                                        [	12.949278	,   13.025474	,   100.900307	,   100.948955	],	//	บางละมุง-พัทยา
                                        [	12.931268	,   12.949268	,   100.900307	,   100.918307	],	//	พัทยา
                                        [	12.917371	,   12.931258	,   100.892202	,   100.918307	],	//	พัทยา-พัทยาใต้
                                        [	12.899361	,   12.917361	,   100.892202	,   100.910202	],	//	พัทยาใต้
                                        [	12.874119	,   12.899351	,   100.892202	,   100.91412	],	//	พัทยาใต้-ตลาดน้ำสี่ภาค
                                        [	12.865109	,   12.874109	,   100.90512	,   100.91412	],	//	ตลาดน้ำสี่ภาค
                                        [	12.833448	,   12.865099	,   100.90512	,   100.930441	],	//	ตลาดน้ำสี่ภาค-บ้านห้วยขวาง
                                        [	12.815438	,   12.833438	,   100.912441	,   100.930441	],	//	บ้านห้วยขวาง
                                        [	12.810398	,   12.815428	,   100.912441	,   100.931488	],	//	บ้านห้วยขวาง-ญาณสังวราราม
                                        [	12.792388	,   12.810388	,   100.913488	,   100.931488	],	//	ญาณสังวราราม
                                        [	12.783697	,   12.792378	,   100.913488	,   100.933301	],	//	ญาณสังวราราม-สวนนงนุช
                                        [	12.765687	,   12.783687	,   100.915301	,   100.933301	],	//	สวนนงนุช
                                        [	12.742729	,   12.765677	,   100.915301	,   100.97442	],	//	สวนนงนุช-ชุมทางเขาชีจรรย์
                                        [	12.724719	,   12.742719	,   100.945497	,   100.97442	],	//	ชุมทางเขาชีจรรย์
                                        [	12.713563	,   12.724709	,   100.945497	,   100.981444	],	//	ชุมทางเขาชีจรรย์-บ้านพลูตาหลวง
                                        [	12.695553	,   12.713553	,   100.963444	,   100.981444	],	//	บ้านพลูตาหลวง
                                    ];
                                    
                                    
                                    //trainnumber
                                    if (hour < 13) {
                                        self.NumberOfTrain.text = "ขบวนที่ 283"
                                        self.LabelOfTrain1.text = "หัวลำโพงไปบ้านพลูตาหลวง"
                                        self.LabelOfTrain2.text = "Hualampong to Banplutaluang"
                                        direction = 1;
                                        
                                    }
                                        
                                    else {
                                        self.NumberOfTrain.text = "ขบวนที่ 284"
                                        self.LabelOfTrain1.text = "บ้านพลูตาหลวงไปหัวลำโพง"
                                        self.LabelOfTrain2.text = "Banplutaluang to Hualampong"
                                        direction = -1;
                                        
                                    }
                                    
                                    
                                    
                                    
                                    if (service==1){
                                        var CurrentStation = 1000;
                                        
                                        for i in (0..<stationTable.count).reversed(){
                                            if (la! >= stationTable[i][0] && la! <= stationTable[i][1] && ln! >= stationTable[i][2] && ln! <= stationTable[i][3]){
                                                CurrentStation = i;
                                                _ = 1000;
                                            }
                                            else{
                                            }
                                        }
                                        
                                        if (CurrentStation<1000){
                                            //บอกสถานีปัจจุบัน
                                            if (CurrentStation % 2 == 0){
                                                self.nowstation1.text = stationName[CurrentStation / 2]
                                                self.nowstation2.text = stationNameENG[CurrentStation / 2]
                                                
                                                index = (CurrentStation / 2) + direction;
                                                //บอกสถานีถัดไป
                                                if (index < 0 || index > (stationName.count - 1)){
                                                    self.nextstation1.text = "-"
                                                    self.nextstation2.text = "-"
                                                }
                                                else {
                                                    self.nextstation1.text = stationName[index]
                                                    self.nextstation2.text = stationNameENG[(CurrentStation / 2) + direction]
                                                }
                                            }
                                            else{
                                                self.nowstation1.text = "ระหว่างทางไป \(stationName[(CurrentStation + direction) / 2])"
                                                self.nowstation2.text = "On the way to  \(stationNameENG[(CurrentStation + direction) / 2])"
                                                self.nextstation1.text = stationName[(CurrentStation + direction) / 2]
                                                self.nextstation2.text = stationNameENG[(CurrentStation + direction) / 2]
                                            }
                                        }
                                        else {
                                            self.nowstation1.text = " "
                                            self.nowstation2.text = " "
                                            self.nextstation1.text = " "
                                            self.nextstation2.text = " "
                                        }
                                        
                                    }
                                    else{
                                        self.nowstation1.text = "งดให้บริการระบบติดตามรถไฟ"
                                        self.nowstation2.text = " "
                                        self.nextstation1.text = "No tracking system service"
                                        self.nextstation2.text = " "
                                    }
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                }
                            }
                        }
                        catch
                        {
                            print(error)
                        }
                    }
                }
                
            }
            task.resume()
            
        }
        else
        {
            let alertController = UIAlertController (title: "No Internet Connection", message: "Make sure your device is connected to internet", preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else{
                    return
                }
                
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
        
        
        
    }
    
    func reNew(){
        //reload application data (renew root view )
        UIApplication.shared.keyWindow?.rootViewController = storyboard!.instantiateViewController(withIdentifier: "LocationTrainViewController")
    }
    
    
    
    
}
