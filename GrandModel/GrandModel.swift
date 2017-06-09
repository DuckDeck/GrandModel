//
//  GrandModel.swift
//  GrandModelDemo
//
//  Created by HuStan on 3/9/16.
//  Copyright © 2016 StanHu. All rights reserved.
//
import Foundation
import UIKit


class GrandModel:NSObject,NSCoding{
    var selfMapDescription:[String:String]?{
        get{
            return nil
        }
    }

    static var typeMapTable:[String:[String:GrandType]] = [String:[String:GrandType]]()
    required override init() {
        super.init()
        let modelName = "\(type(of: self))"
        if type(of: self) == GrandModel.self
        {
            return
        }
        if !GrandModel.typeMapTable.keys.contains(modelName){
            GrandModel.typeMapTable[modelName] = [String:GrandType]()
        }
        if GrandModel.typeMapTable[modelName]!.count != 0{
            return
        }
        let mir = Mirror(reflecting: self)
        for (key,value) in mir.children {
           let grandType = GrandType(propertyMirrorType: Mirror(reflecting: value), belongType: type(of: self)) //有了大神的这个还真是方便多了
            GrandModel.typeMapTable[modelName]![key!] = grandType
        }
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("没有这个字段-------\(key)")
    }
    
    func encode(with aCoder: NSCoder) {
        let item = type(of: self).init()
        let properties = item.getSelfProperty()
        for propertyName in properties{
            let value = self.value(forKey: propertyName)
            aCoder.encode(value, forKey: propertyName)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        let item = type(of: self).init()
        let properties = item.getSelfProperty()
        for propertyName in properties{
            let value = aDecoder.decodeObject(forKey: propertyName)
            self.setValue(value, forKey: propertyName)
        }
    }
    
    
    func getSelfProperty()->[String]{
        var selfProperties = [String]()
        var count:UInt32 =  0
        let properties = class_copyPropertyList(type(of: self), &count)
        for i in 0..<count {
            let t = property_getName(properties?[Int(i)])
            if let n = NSString(cString: t!, encoding: String.Encoding.utf8.rawValue) as String?
            {
                selfProperties.append(n as String)
            }
        }
        return selfProperties
    }
}





extension GrandModel{
    internal override var description:String{
        get{
            var dict = [String:AnyObject]()
            var count:UInt32 =  0
            let properties = class_copyPropertyList(type(of: self), &count)
            for i in 0..<count {
                let t = property_getName(properties?[Int(i)])
                if let n = NSString(cString: t!, encoding: String.Encoding.utf8.rawValue) as String?
                {
                    let v = self.value(forKey: n ) ?? "nil"
                    dict[n] = v as AnyObject?
                }
            }
            return "\(type(of: self)):\(dict)"
        }
    }
    internal override var debugDescription:String{
        get{
            return self.description
        }
    }
}


