//
//  ViewController.swift
//  GrandModelDemo
//
//  Created by HuStan on 3/9/16.
//  Copyright © 2016 StanHu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let demoDict:[String:Any] = ["sName":"1234567",
                                      "iAge":"12",
                                        "ib":true,
                                    "iGrade":"6",
                                  "UserName":"StanHu",
                              "intergerDemo":1000,
                                     "money":"222.4",  //money不能使用
                                 "SUserName":"123123",
                                 "DemoOther":["userName":"OtherUserName"],
                                "DemoOthers":[["userName":"OtherUserName1"],["userName":"OtherUserName2"]]]
        
        
        //let demoDict:[String:Any] = ["DemoOther":["userName":"OtherUserName"]]
        
        
      
        
        
        //let demoDict:[String:Any] = ["money":"222.4"]
        
        //let demoDict:[String:AnyObject] = ["ib":true,"score":11]
        let demo  = DemoClass.map(demoDict)
        //demo.otherClass = DemoOther.mapModel(demoDict["DemoOther"]!)
        print(demo)
        //print(demo.otherClasses)
        print(demo.otherClasses!)
        
        let dict = demo.convert()
        for (key,value) in dict{
            print("\(key) = \(value)")
        }
        
        //这个先这样，明天再测试
        enum week{
            case mon,thu,wed,tur,fri,sai,sun
        }
        //TestModel加入枚举
        class TestModel:GrandModel {
            var i:Int?
            var j = 1
            var a:String?
            var weeb:week?
        }
        let model = TestModel()
        print(model)
        

        
        
        /*
         
         let demo1 = DemoClass()
         demo1.userName = "demo1UserName"
         demo1.name = "demo1Name"
         demo1.rectDemo = CGRect(x: 100, y: 100, width: 100, height: 100)
         print(demo1)
         let ach = NSKeyedArchiver.archivedDataWithRootObject(demo1)
         let s = NSKeyedUnarchiver.unarchiveObjectWithData(ach)
         print(s)
         */
        
        /*
         //下面来试验
         let demoTest = DemoArchiver()
         demoTest.demoFloat = 11.11
         demoTest.demoClass = demoArc()
         demoTest.demoClass?.daInt = 8
         demoTest.demoClass?.daString = "demoArc"
         let a1 = demoArc()
         let a2 = demoArc()
         a1.daInt = 1
         a2.daInt = 2
         a2.daString = "a2"
         demoTest.demoArray = [a1,a2]
         demoTest.demoDict  = ["demo1":a1,"demo2":a2]
         print(demoTest)
         let a = NSKeyedArchiver.archivedDataWithRootObject(demoTest)
         let b = NSKeyedUnarchiver.unarchiveObjectWithData(a)
         print(b)
         
         */

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

