//
//  AnaylizeViewController.swift
//  project01
//
//  Created by 김가영 on 2020/05/01.
//  Copyright © 2020 김가영. All rights reserved.
//

import UIKit
import SafariServices

class AnaylizeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, SFSafariViewControllerDelegate{

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var fineDust: UIPickerView!
    @IBOutlet weak var humidity: UISlider!
    @IBOutlet weak var uvRays: UISlider!
    @IBOutlet weak var result: UIButton!
    @IBOutlet weak var moreInfo: UIButton!
    
    let fineDustArray: Array<String> = ["좋음(0-15)", "보통(16-35)", "나쁨(36-75)", "매우나쁨(76~)"]
    var selectRow = 0
    
    typealias cosName = (Name:String, Price:Int, Brand:String) //날씨에 따른 화장품의 이름과 가격 튜플
    let name01:cosName = ("워터 스플래쉬 선 크림", 18000, "에스쁘아") //for sunny day
    let name02:cosName = ("수딩 파우더", 18000, "궁중비책") //for rainy day
    let name03:cosName = ("센시티브 스킨 안티 더스트 클렌징폼", 29800, "아이소이") //for smoky day
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { textField.resignFirstResponder()
    return true } //textfield delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1 //pickerView의 요소수 리턴
       }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fineDustArray.count
    } //빈 pickerView 만듬(datasource와 관련)

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fineDustArray[row]
        } //pickerView에 데이터 넣음(delegate와 관련)
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectRow = row
        } //pickerView에서 row를 이용해 데이터 가져오기
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    } //safari end
    
    @IBAction func openWeatherURL(_ sender: UIButton) {
        guard let url = URL(string: "https://weather.naver.com") else {
            return
        }

        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        
        safariVC.delegate = self
    } //safari에서 url열기
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toTodayView" {
    let destVC = segue.destination as! TodayPickViewController
        
    let yourName: String! = name.text //textfield

    var outString: String = yourName
        outString += "님!! 오늘은 "
        if self.humidity.value < 0.5 && self.uvRays.value >= 0.5 {
        destVC.index = 0
            if selectRow == 2 || selectRow == 3 {
                destVC.index = 2
                outString += "<\(name03.Brand)>의 \n\(name03.Name)"
                outString += "(\(String(name03.Price))원)"//smoky day, Int->String type
        }
            else {
                outString += "<\(name01.Brand)>의 \n\(name01.Name)"
                outString += "(\(String(name01.Price))원)"//sunny day, Int->String type
            }
    }
    else if self.humidity.value >= 0.5 && self.uvRays.value < 0.5 {
        destVC.index = 1
            if selectRow == 2 || selectRow == 3 {
                destVC.index = 2
                outString += "<\(name03.Brand)>의 \n\(name03.Name)"
                outString += "(\(String(name03.Price))원)" //smoky day, Int->String type
        }
            else {
            outString += "<\(name02.Brand)>의 \n\(name02.Name)"
            outString += "(\(String(name02.Price))원)"//rainy day, Int->String type
            }
    }
        outString += "을 추천드려요:)"
        destVC.info = outString
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
}
}
