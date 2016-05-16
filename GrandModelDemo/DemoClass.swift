//
//  DemoClass.swift
//  GrandModelDemo
//
//  Created by HuStan on 5/15/16.
//  Copyright © 2016 StanHu. All rights reserved.
//

import UIKit

class DemoClass: GrandModel {
    var name:String?
    var age:Int = 0
    var grade:Int = 0
    var score:Float = 0.0
    var isFool:Bool = false
    var money:Double?
    var intergerDemo:NSInteger = 2
    var pointDemo:CGPoint = CGPointZero
    var sizeDemo:CGSize = CGSizeZero
    var rectDemo:CGRect = CGRectZero
    var dataDemo:NSData = NSData()
    var dateDemo = NSDate()
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
                           "DemoOthers":"otherClasses",
                           "ib":"isFool"]
    
    override  var  selfMapDescription: [String : String]?{
        return DemoClass.mapDict
    }
    
}


class DemoArchiver:GrandModel {
    var demoString:String?
    var demoInt = 10
    var demoFloat:Float?
    var demoBool:Bool = true
    var demoDouble:Double = 0.0
    var demoDate:NSDate?
    var demoClass:demoArc?
    var demoArray:[demoArc]?
    var demoDict:[String:demoArc]?
}


class demoArc:GrandModel {
    var daString:String?
    var daInt:Int = 0
}

class DemoOther: GrandModel {
    var userName:String?
    static var mapDict = ["userName":"userName"]
    override var selfMapDescription: [String : String]?{
        return DemoOther.mapDict
    }
    
}