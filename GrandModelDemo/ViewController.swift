//
//  ViewController.swift
//  GrandModelTest
//
//  Created by Stan Hu on 2020/3/16.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            /*  //测试map
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
            
             */
            
            
            
             /*NSKeyedArchiver 目前没有问题
             let demo1 = DemoClass()
             demo1.userName = "demo1UserName"
             demo1.name = "demo1Name"
             demo1.rectDemo = CGRect(x: 100, y: 100, width: 100, height: 100)
             print(demo1)
             let ach = NSKeyedArchiver.archivedData(withRootObject: demo1)
             let s = NSKeyedUnarchiver.unarchiveObject(with: ach) as! DemoClass
             print(s.userName)
             print(s.name)
            */
            
            
            
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
            let a = NSKeyedArchiver.archivedData(withRootObject: demoTest)
            let b = NSKeyedUnarchiver.unarchiveObject(with: a)
             print(b)
        
    }


}

open class Store {
    let storesToDisk: Bool = true
}
open class BookmarkStore: Store {
    let itemCount: Int = 10
}
public struct Bookmark {
    enum Group {
        case tech
        case news
    }
    fileprivate let store = {
        return BookmarkStore()
    }()
    let title: String?
    let url: URL
    let keywords: [String]
    let group: Group
}

let aBookmark = Bookmark(title: "Appventure", url: URL(string: "appventure.me")!, keywords: ["Swift", "iOS", "OSX"], group: .tech)


@objcMembers class DemoClass: GrandModel {
    var name:String?
    var age:Int = 0
    var grade:Int = 0
    var score:Float = 0.0
    var isFool:Bool = false
    var money:Double? = 0.0  //如果是非对象类型，那么就不能为可空类型，不然后是找不到这个对象的
    var intergerDemo:NSInteger = 2
    var pointDemo:CGPoint = CGPoint.zero
    var sizeDemo:CGSize = CGSize.zero
    var rectDemo:CGRect = CGRect.zero
    var dataDemo:Data = Data()
    var dateDemo = Date()
    var userName:String?
    var otherClass:DemoOther?
    var otherClasses:[DemoOther]?

    static let mapDict =  ["sName":"name",
                           "iAge":"age",
                           "iGrade":"grade",
                           "UserName":"userName",
                           "score":"score",
                           "sUserName":"userName",
                           "userName":"userName",
                           "DemoOther":"otherClass",
                           "SUserName":"otherClass.userName",
                           "DemoOthers":"otherClasses",
                           "ib":"isFool"]
    
    override  var  selfMapDescription: [String : String]?{
        return DemoClass.mapDict
    }
    
}


@objcMembers class DemoArchiver:GrandModel {
    var demoString:String?
    var demoInt = 10
    var demoFloat:Float?
    var demoBool:Bool = true
    var demoDouble:Double = 0.0
    var demoDate:Date?
    var demoClass:demoArc?
    var demoArray:[demoArc]?
    var demoDict:[String:demoArc]?
}


@objcMembers class demoArc:GrandModel {
    var daString:String?
    var daInt:Int = 0
}

@objcMembers class DemoOther: GrandModel {
    var userName:String?
    static var mapDict = ["userName":"userName"]
    override var selfMapDescription: [String : String]?{
        return DemoOther.mapDict
    }
    
}


