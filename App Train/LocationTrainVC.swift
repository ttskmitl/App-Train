//
//  LocationViewController.swift
//  NEWApp
//
//  Created by Nithit Sathornlak on 3/15/2560 BE.
//  Copyright © 2560 Arisara Corp. All rights reserved.
//

import UIKit

class LocationTrainViewController: UIViewController {
    
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
            
            
            let url = URL(string: "http://train.telecom.kmitl.ac.th/downloadlatlng275.php")
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
                                    
                                    
                                    
                                    
                                    
                                    let stationName:[String] = ["กรุงเทพ", "พญาไท", "มักกะสัน", "อโศก", "คลองตัน", "สุขุมวิท71", "หัวหมาก", "บ้านทับช้าง", "ซอยวัดลานบุญ", "ลาดกระบัง", "พระจอมเกล้า", "หัวตะเข้",
                                        "คลองหลวงแพ่ง", "คลองอุดมชลจร", "เปรง", "คลองแขวงกลั่น", "คลองบางพระ", "บางเตย", "ชุมทางฉะเชิงเทรา", "โพรงอากาศ", "บางน้ำเปรี้ยว", "ชุมทางคลองสิบเก้า", "คลองยี่สิบเอ็ด", "โยทะกา", "บ้านสร้าง", "หนองน้ำขาว", "บ้านปากพลี",
                                        "ปราจีนบุรี", "โคกมะกอก", "ประจันตคาม", "หนองแสง", "บ้านดงบัง", "บ้านพรมแสง", "บ้านเกาะแดง", "กบินทร์บุรี", "กบินทร์เก่า", "หนองสัง", "พระปรง", "บ้านแก้ง", "ศาลาลำดวน", "สระแก้ว", "ท่าเกษม", "ห้วยโจด", "วัฒนานคร", "บ้านโป่งคอม",
                                        "ห้วยเดื่อ", "อรัญประเทศ"];
                                    
                                    let stationNameENG:[String] = ["BANGKOK", "Phayathai", "Makkasan", "Asoke", "Khlong Tan", "Sukhumvit71", "Hua Mak", "Ban Thap Chang",
                                                                   "Soi Wat Lan Boon", "Lat Krabang", "Pra Chom Klao", "Hua Takhe", "Khlong Luang Phaeng", "Khlong Udom Chonlajorn", "Preng",
                                                                   "Khlong Kwaeng Klan", "Khlong Bang Phra", "Bang Toey", "Chachoengsao Junction", "Phrong Akat", "Bang Nam Prieo", "Khlong Sip Kao Junction",
                                                                   "Khlong Yi Sip Et", "Yothaka", "Ban Sang", "Nong Nam Khao", "Ban Pak Phli", "Prachin Buri", "Khok Makok", "Prachantakham", "Nong Saeng", "Ban Dong Bang",
                                                                   "Ban Phrom Saeng", "Ban Ko Daeng", "Kabin Buri", "Kabin Kao", "Nong Sang", "Phra Prong", "Ban Kaeng", "Sala Lamduan", "Sa Kaeo", "Tha Kasem", "Huai Chot",
                                                                   "Watthana Nakhon", "Ban Pong Kom", "Huai Dua", "Aranyaprathet"];
                                    
                                    
                                    
                                    let stationTable:[[Double]] = [	[	13.734988	,	13.743988	,	100.512247	,	100.521247	],	//	กรุงเทพ
                                        [	13.743998	,	13.767855	,	100.512247	,	100.528571	],	//	กรุงเทพ-พญาไท
                                        [	13.752534	,	13.761534	,	100.528581	,	100.537581	],	//	พญาไท
                                        [	13.749211	,	13.761534	,	100.537591	,	100.542881	],	//	พญาไท-มักกะสัน
                                        [	13.749211	,	13.758211	,	100.542891	,	100.551891	],	//	มักกะสัน
                                        [	13.745856	,	13.758211	,	100.551901	,	100.558616	],	//	มักกะสัน-อโศก
                                        [	13.745856	,	13.754856	,	100.558626	,	100.567626	],	//	อโศก
                                        [	13.741226	,	13.754856	,	100.567636	,	100.586695	],	//	อโศก-คลองตัน
                                        [	13.741226	,	13.747226	,	100.586705	,	100.592705	],	//	คลองตัน
                                        [	13.739971	,	13.747226	,	100.592715	,	100.597254	],	//	คลองตัน-สุขุมวิท 71
                                        [	13.739971	,	13.745971	,	100.597264	,	100.603264	],	//	สุขุมวิท 71
                                        [	13.733767	,	13.745971	,	100.603274	,	100.635342	],	//	สุขุมวิท 71-หัวหมาก
                                        [	13.733767	,	13.742767	,	100.635352	,	100.644352	],	//	หัวหมาก
                                        [	13.728604	,	13.742767	,	100.644362	,	100.684222	],	//	หัวหมาก-บ้านทับช้าง
                                        [	13.728604	,	13.737604	,	100.684232	,	100.693232	],	//	บ้านทับช้าง
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
                                        [	13.704155	,	13.799977	,	101.050723	,	101.103407	],	//	ชุมทางฉะเชิงเทรา-โพรงอากาศ
                                        [	13.799987	,	13.817987	,	101.085407	,	101.103407	],	//	โพรงอากาศ
                                        [	13.817997	,	13.841611	,	101.085407	,	101.110765	],	//	โพรงอากาศ-บางน้ำเปรี้ยว
                                        [	13.841621	,	13.859621	,	101.092765	,	101.110765	],	//	บางน้ำเปรี้ยว
                                        [	13.859631	,	13.898502	,	101.092765	,	101.123012	],	//	บางน้ำเปรี้ยว-ชุมทางคลองสิบเก้า
                                        [	13.898512	,	13.916512	,	101.105012	,	101.123012	],	//	ชุมทางคลองสิบเก้า
                                        [	13.916522	,	13.934507	,	101.105012	,	101.136279	],	//	ชุมทางคลองสิบเก้า-คลองยี่สิบเอ็ด
                                        [	13.934517	,	13.943517	,	101.118279	,	101.136279	],	//	คลองยี่สิบเอ็ด
                                        [	13.943527	,	13.961833	,	101.118279	,	101.158473	],	//	คลองยี่สิบเอ็ด-โยทะกา
                                        [	13.961843	,	13.979843	,	101.140473	,	101.158473	],	//	โยทะกา
                                        [	13.979853	,	14.004881	,	101.140473	,	101.210905	],	//	โยทะกา-บ้านสร้าง
                                        [	14.004891	,	14.022891	,	101.192905	,	101.210905	],	//	บ้านสร้าง
                                        [	14.004891	,	14.053974	,	101.210915	,	101.263781	],	//	บ้านสร้าง-หนองน้ำขาว
                                        [	14.044974	,	14.053974	,	101.263791	,	101.272791	],	//	หนองน้ำขาว
                                        [	14.044974	,	14.08335	,	101.272801	,	101.306228	],	//	หนองน้ำขาว-บ้านปากพลี
                                        [	14.06535	,	14.08335	,	101.306238	,	101.324238	],	//	บ้านปากพลี
                                        [	14.061812	,	14.08335	,	101.324248	,	101.364586	],	//	บ้านปากพลี-ปราจีนบุรี
                                        [	14.061812	,	14.079812	,	101.364596	,	101.382596	],	//	ปราจีนบุรี
                                        [	14.055777	,	14.079812	,	101.382606	,	101.44845	],	//	ปราจีนบุรี-โคกมะกอก
                                        [	14.055777	,	14.073777	,	101.44855	,	101.46655	],	//	โคกมะกอก
                                        [	14.054668	,	14.073777	,	101.46665	,	101.510048	],	//	โคกมะกอก-ประจันตคาม
                                        [	14.054668	,	14.072668	,	101.510058	,	101.528058	],	//	ประจันตคาม
                                        [	14.048027	,	14.072668	,	101.528068	,	101.565207	],	//	ประจันตคาม-หนองแสง
                                        [	14.048027	,	14.057027	,	101.565217	,	101.574217	],	//	หนองแสง
                                        [	14.031123	,	14.057027	,	101.574227	,	101.589905	],	//	หนองแสง-บ้านดงบัง
                                        [	14.031123	,	14.049123	,	101.589915	,	101.607915	],	//	บ้านดงบัง
                                        [	14.013339	,	14.049123	,	101.607925	,	101.63332	],	//	บ้านดงบัง-บ้านพรมแสง
                                        [	14.013339	,	14.031339	,	101.63338	,	101.65138	],	//	บ้านพรมแสง
                                        [	14.002926	,	14.031339	,	101.65139	,	101.674315	],	//	บ้านพรมแสง-บ้านเกาะแดง
                                        [	14.002926	,	14.011926	,	101.674325	,	101.683325	],	//	บ้านเกาะแดง
                                        [	13.98082	,	14.011926	,	101.683335	,	101.713852	],	//	บ้านเกาะแดง-กบินทร์บุรี
                                        [	13.98082	,	13.99882	,	101.713862	,	101.731862	],	//	กบินทร์บุรี
                                        [	13.98082	,	14.001273	,	101.731872	,	101.755947	],	//	กบินทร์บุรี-กบินทร์เก่า
                                        [	13.992273	,	14.001273	,	101.755957	,	101.764957	],	//	กบินทร์เก่า
                                        [	13.971702	,	14.001273	,	101.764967	,	101.81643	],	//	กบินทร์เก่า-หนองสัง
                                        [	13.971702	,	13.989702	,	101.81644	,	101.83444	],	//	หนองสัง
                                        [	13.943985	,	13.989702	,	101.83445	,	101.91211	],	//	หนองสัง-พระปรง
                                        [	13.943985	,	13.961985	,	101.91212	,	101.93012	],	//	พระปรง
                                        [	13.908303	,	13.961985	,	101.93013	,	101.960026	],	//	พระปรง-บ้านแก้ง
                                        [	13.908303	,	13.926303	,	101.960036	,	101.978036	],	//	บ้านแก้ง
                                        [	13.873769	,	13.926303	,	101.978046	,	102.000465	],	//	บ้านแก้ง-ศาลาลำดวน
                                        [	13.873769	,	13.891769	,	102.000475	,	102.018475	],	//	ศาลาลำดวน
                                        [	13.817814	,	13.891769	,	102.018485	,	102.066201	],	//	ศาลาลำดวน-สระแก้ว
                                        [	13.817814	,	13.835814	,	102.066211	,	102.084211	],	//	สระแก้ว
                                        [	13.7812	,	13.835814	,	102.084221	,	102.159752	],	//	สระแก้ว-ท่าเกษม
                                        [	13.7812	,	13.7992	,	102.159762	,	102.177762	],	//	ท่าเกษม
                                        [	13.7616	,	13.7992	,	102.177772	,	102.222248	],	//	ท่าเกษม-ห้วยโจด
                                        [	13.7616	,	13.7796	,	102.222258	,	102.240258	],	//	ห้วยโจด
                                        [	13.732161	,	13.7796	,	102.240268	,	102.314782	],	//	ห้วยโจด-วัฒนานคร
                                        [	13.732161	,	13.750161	,	102.314792	,	102.332792	],	//	วัฒนานคร
                                        [	13.720212	,	13.750161	,	102.332802	,	102.376018	],	//	วัฒนานคร-บ้านโป่งคอม
                                        [	13.720212	,	13.729212	,	102.376028	,	102.385028	],	//	บ้านโป่งคอม
                                        [	13.703872	,	13.729212	,	102.385038	,	102.413383	],	//	บ้านโป่งคอม-ห้วยเดื่อ
                                        [	13.703872	,	13.721872	,	102.413393	,	102.431393	],	//	ห้วยเดื่อ
                                        [	13.683745	,	13.721872	,	102.431403	,	102.49586	],	//	ห้วยเดื่อ-อรัญประเทศ
                                        [	13.683745	,	13.701745	,	102.49596	,	102.51396	],	//	อรัญประเทศ
                                        
                                    ];
                                    
                                    
                                    //trainnumber
                                    if (hour < 13) {
                                        self.NumberOfTrain.text = "ขบวนที่ 275"
                                        self.LabelOfTrain1.text = "หัวลำโพงไปอรัญประเทศ"
                                        self.LabelOfTrain2.text = "Hualampong to Aranyaprathet"
                                        direction = 1;
                                        
                                    }
                                        
                                    else {
                                        self.NumberOfTrain.text = "ขบวนที่ 276"
                                        self.LabelOfTrain1.text = "อรัญประเทศไปหัวลำโพง"
                                        self.LabelOfTrain2.text = "Aranyaprathet to Hualampong"
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
