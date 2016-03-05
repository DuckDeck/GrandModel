//
//  main.swift
//  DemoConsole
//
//  Created by HuStan on 3/2/16.
//  Copyright © 2016 StanHu. All rights reserved.
//

import Foundation



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



class DemoClass:GrandModel {
    var name:String?
    var age:Int = 0
    var grade:Int = 0
    //需要重写selfMapDescription
    override static var selfMapDescription:[String:String]?{
        return ["sName":"name","iAge":"age","iGrade":"grade"]
    }
}

//下面来测试
let demoDict = ["sName":"Stan","iAge":"12","iGrade":"6"]
var demo = DemoClass()
demo = DemoClass.mapModel(demoDict)
print(demo)



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
