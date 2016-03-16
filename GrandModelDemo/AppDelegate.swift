//
//  AppDelegate.swift
//  GrandModelDemo
//
//  Created by HuStan on 3/9/16.
//  Copyright © 2016 StanHu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
       
        
        
        /*
        
        enum Week{
        case Mon,Thu,Wed,Tur,Fri,Sai,Sun
        }
        enum WeekA:Int{
        case Mon = 0,Thu,Wed,Tur,Fri,Sai,Sun
        }
        enum WeekB:NSInteger{
        case Mon = 0,Thu,Wed,Tur,Fri,Sai,Sun
        }
        enum WeebC:NSString,CustomStringConvertible{
        case Mon = "Mon",
        Thu = "Thu"
        
        var description:String{
        switch self{
        case .Mon:return "Mon"
        case.Thu:return "Thu"
        }
        }
        
        }
        class TestModel: GrandModel {
        var i = 0
        var a:String?
        var weekA:Week?
        var weekB:WeekA?
        var weekC:WeekB?
        var weekD:WeebC = .Mon
        }
        let model = TestModel()
        print(model)
        model.a = "aaa"
        model.weekA = Week.Mon
        print(model)
        struct StructDemo {
        var q = 1
        var w = "w"
        }
        class ClassDemo {
        var q = 1
        var w = "w"
        }
        class ClassDemoA:GrandModel{
        var q = 1
        var w = "w"
        }
        class TestModelA: GrandModel {
        var i:Int = 1
        var o:String?
        var structDemo:StructDemo?
        var classDemo:ClassDemo?
        var classDemoA:ClassDemoA?
        var classDemoAArray:[ClassDemoA]?
        var classDemoDict:[String:ClassDemoA]?
        }
        let modelA = TestModelA()
        print(modelA)
        modelA.classDemoA = ClassDemoA()
        print(modelA)
        modelA.classDemoAArray = [ClassDemoA]()
        modelA.classDemoAArray?.append(ClassDemoA())
        modelA.classDemoAArray?.append(ClassDemoA())
        modelA.classDemoDict = [String:ClassDemoA]()
        modelA.classDemoDict!["1"] = ClassDemoA()
        modelA.classDemoDict!["2"] = ClassDemoA()
        print(modelA)
        */
        
        
        /*
        
        class DemoOther: GrandModel {
        var userName:String?
        override static var selfMapDescription:[String:String]?{
        return [ "userName":"userName"]
        }
        }
        
        
        class DemoClass:GrandModel {
        var name:String?
        var age:Int = 0
        var grade:Int = 0
        var score:Float = 0.0
        var money:Double = 10.1
        var intergerDemo:NSInteger = 2
        var pointDemo:CGPoint = CGPointZero
        var sizeDemo:CGSize = CGSizeZero
        var rectDemo:CGRect = CGRectZero
        var dataDemo:NSData = NSData()
        var dateDemo = NSDate()
        var userName:String?
        var otherClass:DemoOther?
        var otherClasses:[DemoOther]?
        //需要重写selfMapDescription
        override static var selfMapDescription:[String:String]?{
        return ["sName":"name",
        "iAge":"age",
        "iGrade":"grade",
        "UserName":"userName",
        "sUserName":"userName",
        "userName":"userName",
        "DemoOther":"otherClass",
        "DemoOthers":"otherClasses"]
        }
        }
        
        //下面来测试
        
        let demoOther = DemoOther()
        //demoOther.userName = "DemoUserName"
        //let demoDict = ["sName":1234567,"iAge":"12","iGrade":"6","UserName":"userName","DemoOther":["userName":"OtherUserName"],
        //    "DemoOthers":[["userName":"OtherUserName1"],["userName":"OtherUserName2"]]
        //]
        let demoDict = ["sName":1234567,"iAge":"12","iGrade":"6","UserName":"userName","DemoOther":["userName":"OtherUserName"],
        "DemoOthers":[["userName":"OtherUserName1"],["userName":"OtherUserName2"]]
        ]
        var demo = DemoClass()
        demo = DemoClass.mapModel(demoDict)
        //demo.otherClass = DemoOther.mapModel(demoDict["DemoOther"]!)
        print(demo)
        print(demo.otherClass)
        
        
        enum week{
        case Mon,Thu,Wed,Tur,Fri,Sai,Sun
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
        

        //下面来试验
        let demoTest = DemoArchiver()
        demoTest.demoFloat = 11.11
        demoTest.demoClass = demoArc()
        demoTest.demoClass?.daInt = 8
        demoTest.demoClass?.daString = "demoArc"
        let a1 = demoArc()
        let a2 = demoArc()
        a1.daString = "a1"
        a1.daInt = 1
        a2.daInt = 2
        a2.daString = "a2"
        demoTest.demoArray = [a1,a2]
        demoTest.demoDict  = ["demo1":a1,"demo2":a2]
        print(demoTest)
        let a = NSKeyedArchiver.archivedDataWithRootObject(demoTest)
        let b = NSKeyedUnarchiver.unarchiveObjectWithData(a)
        print(b)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        return true
    }
}

class DemoClass:GrandModel {
    var name:String?
    var age:Int = 0
    var grade:Int = 0
    var score:Float = 0.0
    var money:Double = 10.1
    var intergerDemo:NSInteger = 2
    var pointDemo:CGPoint = CGPointZero
    var sizeDemo:CGSize = CGSizeZero
    var rectDemo:CGRect = CGRectZero
    var dataDemo:NSData = NSData()
    var dateDemo = NSDate()
    var userName:String?
    //需要重写selfMapDescription
    override static var selfMapDescription:[String:String]?{
        return ["sName":"name",
            "iAge":"age",
            "iGrade":"grade",
            "UserName":"userName",
            "sUserName":"userName",
            "userName":"userName",]
    }
}


class DemoArchiver:GrandModel {
    var demoString:String?
    var demoInt = 10
    var demoFloat:Float?
    var demoBool:Bool = true
    var demoDouble:Double = 12
    var demoDate:NSDate?
    var demoClass:demoArc?
    var demoArray:[demoArc]?
    var demoDict:[String:demoArc]?
}


class demoArc:GrandModel {
    var daString:String?
    var daInt:Int = 0
}

        