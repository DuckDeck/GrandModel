//
//  DemoClass.swift
//  GrandModelDemo
//
//  Created by HuStan on 5/15/16.
//  Copyright © 2016 StanHu. All rights reserved.
//

import UIKit

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

