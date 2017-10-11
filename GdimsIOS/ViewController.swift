//
//  ViewController.swift
//  GdimsIOS
//
//  Created by 包宏燕 on 2017/10/10.
//  Copyright © 2017年 bhy. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire
import ObjectMapper
import Toast_Swift
class ViewController: UIViewController {
    var sessionManager:SessionManager?
    var url = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //        loginRequst()
        var style = ToastStyle()
        
        // this is just one of many style options
        style.messageColor = .blue
        loginRequst()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginRequst()  {
        url = "http://183.230.108.112:8099/meteor/findMonitor.do"
        
        self.view.isUserInteractionEnabled = false
        /*需要上传的参数集合*/
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        let parameters = ["mobile": "15702310784","imei":"0" ] as [String : Any]
        sessionManager = Alamofire.SessionManager(configuration: configuration)
        /*上传的Alamofire方法*/
        sessionManager?.request(url,method:.post, parameters: parameters).responseObject { (response: DataResponse<BaseModel>) in
            switch response.result {
            case .success:
                if let values = response.result.value {
                    if values.result == "1" {
                        if values.info == "[]"{
                            self.view.makeToast("没有查到该号码对应的群测群防人员", duration: 1, position: .center)
                        }
                        else{
                            self.view.makeToast("登录成功", duration: 1, position: .center)
                        }
                    }else{
                        self.view.makeToast("没有查到该号码对应的群测群防人员", duration: 1, position: .center)
                    }
                    
                    self.view.isUserInteractionEnabled = true
                }
            case .failure(let error):
                print(error)
                
                self.view.makeToast("登录失败,请检查登录信息", duration: 1, position: .center)
                self.view.isUserInteractionEnabled = true
            }
            
        }
    }
    
    //    func macroRequst()  {
    //        url = "http://183.230.108.112:8099/meteor/findMonitor.do?mobile=15702310784&&imei=0"
    //        Alamofire.request(url).responseObject { (response: DataResponse<BaseModel>) in
    //            let myResponse = response.result.value
    //            print(myResponse!.info!)
    //
    //            let extractedExpr: [InfoModel]? = Mapper<InfoModel>().mapArray(JSONString: (myResponse?.info)!)
    //
    //            for forecast in extractedExpr! {
    //                print(forecast.dimension!)
    //                print(forecast.monPointName!)
    //            }
    //        }
    //    }
    
}

