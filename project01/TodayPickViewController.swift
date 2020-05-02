//
//  TodayPickViewController.swift
//  project01
//
//  Created by 김가영 on 2020/05/01.
//  Copyright © 2020 김가영. All rights reserved.
//

import UIKit
import SafariServices //safari로 url열게하기 위함

class TodayPickViewController: UIViewController, SFSafariViewControllerDelegate {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var recommendation: UILabel!
    @IBOutlet weak var viewCosmetic: UIButton!
    
    var info: String! = ""
    var index: Int! = 0
    var imageName:Array = ["sunny.png", "rainy.png","cloudy.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        weatherImage.image = UIImage(named:imageName[index]) //image array
        if let contentString = info {
         recommendation.text = contentString //recommendation comments
        }
        if let contentInt = index {
            weatherImage.image = UIImage(named:imageName[contentInt])
        } //image view
    }
    
    @IBAction func openCosmeticURL(_ sender: UIButton){
        switch index {
        case 0:
            guard let url = URL(string: "https://www.oliveyoung.co.kr/store/goods/getGoodsDetail.do?goodsNo=A000000128040") else {
                return
            }
                    let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
            safariVC.delegate = self
        case 1:
            guard let url = URL(string: "http://www.0to7.com/pms/product/detail?productId=2799792&rccode=pc_search1") else {
                           return
                       }
                    let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
            safariVC.delegate = self
        case 2:
             guard let url = URL(string: "https://www.isoi.co.kr/product/goods_detail?goods_no=1814") else {
                                      return
                                  }
                    let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
            safariVC.delegate = self
        default :
            print("NULL")
        }
    } //safari에서 url열기
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
