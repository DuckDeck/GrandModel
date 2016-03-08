//
//  GrandModel.swift
//  GrandModelDemo
//
//  Created by Tyrant on 2/27/16.
//  Copyright © 2016 Qfq. All rights reserved.
//

import Foundation

protocol MapAble{
    static func mapModel(obj:AnyObject)->Self
}

class GrandModel:NSObject{
    class var selfMapDescription:[String:String]?{
        return nil
    }
    static var typeMapTable:[String:[String:AnyClass]] = [String:[String:AnyClass]]()
    
    
    
    required override init() {
        super.init()
        let modelName = "\(self.dynamicType)"
        if self.dynamicType == GrandModel.self
        {
            return
        }
        if !GrandModel.typeMapTable.keys.contains(modelName){
            GrandModel.typeMapTable[modelName] = [String:AnyClass]()
        }
        if GrandModel.typeMapTable[modelName]!.count != 0{
            return
        }
      //  let z = NSClassFromString("_TtC11DemoConsole9DemoOther")
        let count:UnsafeMutablePointer<UInt32> =  UnsafeMutablePointer<UInt32>()
        var properties = class_copyPropertyList(self.dynamicType, count)
        while properties.memory.debugDescription !=  "0x0000000000000000"{
            let t = property_getName(properties.memory)
            let a = property_getAttributes(properties.memory)
            let d = NSString(CString: a, encoding: NSUTF8StringEncoding)
            let n = NSString(CString: t, encoding: NSUTF8StringEncoding)
            let v = self.valueForKey(n as! String) ?? "nil"
            //这样对于没有赋值的类型，会转为String,这肯定会不行，要想其他的办法,
            //看看Attribute有什么东西,Attribute可以获取一个完整的类名，用这个类名可以获取
            //这个类，下面实战试试
            if d!.containsString("\"")
            {
                //       let first =
                let cTypes = d!.componentsSeparatedByString(",")
                if let className = cTypes.first
                {
                    if let proertyName = cTypes.last{
                        let cn = (className.stringByReplacingOccurrencesOfString("\"", withString: "") as NSString).substringFromIndex(2)
                        let pn = (proertyName as NSString).substringFromIndex(1)
                        GrandModel.typeMapTable[modelName]![pn] = NSClassFromString(cn)
                    }
                }
                
            }
            else{
                GrandModel.typeMapTable[modelName]![n! as String] = v!.dynamicType
            }
            properties = properties.successor()
        }
    }


    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        print("没有这个字段-------\(key)")
    }

// 不能重写这个方法,如果重写的话,子类会无法找到重写的方法
//    override func setValue(value: AnyObject?, forKey key: String) {
//        var resultValue:AnyObject?
//        if let v = value{
//            if v is NSNull{
//                  print("这个字段是Null值-------\(key)")
//                resultValue = ""
//            }
//        }
//        if key == "id"{
//            print("关键字冲突!  !  !  !  !------\(key)")
//        }
//        resultValue = value
//        super.setValue(resultValue, forKey: key)
//    }
}

extension GrandModel:MapAble{
    static func mapModel(obj:AnyObject)->Self{
        let modelName = "\(self)"
        let model = self.init()
        if let mapTable = self.selfMapDescription{
            if let dict = obj as? [String:AnyObject]
            {
                for item in dict{
                    if let key = mapTable[item.0]{
                        print("key 为\(item.0)将要被设成\(mapTable[item.0),其值是 \(item.1)")
                        
                        //首先判断其类型
                        
                        if   GrandModel.typeMapTable[modelName]!.keys.contains(key) &&  GrandModel.typeMapTable[modelName]![key]! is GrandModel.Type{
                            let classType = GrandModel.typeMapTable[modelName]![key]!
                            var  s =  (classType as! GrandModel.Type).init()
                            //在这里用静态方法是行不通的，只有用非静态方法了
                            //如果使用静态的方式来转换，到这里已经是死胡同了。因为在这里无法获取映射表
                            //以后再研究，

//                            let modelItem =
//
//                            model.setValue(modelItem, forKey: key)
                        }
                        else{
                            if item.1 is NSNumber{
                                model.setValue("\(item.1)", forKey: key)
                            }
                            else{
                                model.setValue(item.1, forKey: key)
                                }
                        }
                    }
                }
            }
        }
        return model
    }
}


extension GrandModel:CustomDebugStringConvertible{
    internal override var description:String{
        get{
            var dict = [String:AnyObject]()
            let count:UnsafeMutablePointer<UInt32> =  UnsafeMutablePointer<UInt32>()
            var properties = class_copyPropertyList(self.dynamicType, count)
            while properties.memory.debugDescription !=  "0x0000000000000000"{
                let t = property_getName(properties.memory)
                let n = NSString(CString: t, encoding: NSUTF8StringEncoding)
                let v = self.valueForKey(n as! String) ?? "nil"
                dict[n as! String] = v
                properties = properties.successor()
            }
        return "\(self.dynamicType):\(dict)"
        }
    }
    internal override var debugDescription:String{
        get{
            return self.description
        }
    }
}






//    func encodeWithCoder(aCoder: NSCoder) {
//        let count:UnsafeMutablePointer<UInt32> =  UnsafeMutablePointer<UInt32>()
//        let properties = class_copyPropertyList(self.dynamicType, count)
//        var t = property_getName(properties.memory)
//        var n = NSString(CString: t, encoding: NSUTF8StringEncoding)
//        let v = self.valueForKey(n as! String)
//        if v != nil{
//            encode(v!, key: n! as String, aCoder: aCoder)
//        }
//        print(n)
//        var s = properties.successor()
//        while s != nil{
//            t = property_getName(s.memory)
//            if t != nil{
//                n = NSString(CString: t, encoding: NSUTF8StringEncoding)
//                let value = self.valueForKey(n as! String)
//                s = s.successor()
//                if value != nil{
//                    encode(value!, key: n! as String, aCoder: aCoder)
//                }
//                if s.memory.debugDescription == "0x0000000000000000"{ //说明已经完了
//                    break
//                }
//            }
//            else{
//                s = nil
//            }
//        }
//        free(properties)
//    }
//
//    func encode(obj:AnyObject,key:String,aCoder:NSCoder){
//        if obj is Int{
//            aCoder.encodeInteger(obj as! Int, forKey: key)
//            GrandModel.typeMapTable[key] = "Int"
//        }
//       else if obj is Double{
//            aCoder.encodeDouble(obj as! Double, forKey: key)
//            GrandModel.typeMapTable[key] = "Double"
//        }
//      else  if obj is Float{
//            aCoder.encodeFloat(obj as! Float, forKey: key)
//           GrandModel.typeMapTable[key] = "Float"
//        }
//       else if obj is Bool{
//            aCoder.encodeBool(obj as! Bool, forKey: key)
//            GrandModel.typeMapTable[key] = "Bool"
//        }
//        else{
//            aCoder.encodeObject(obj, forKey: key)
//           GrandModel.typeMapTable[key] = "Object"
//        }
//    }

//    required init?(coder aDecoder: NSCoder) {
//        super.init()
//        let count:UnsafeMutablePointer<UInt32> =  UnsafeMutablePointer<UInt32>()
//        let properties = class_copyPropertyList(self.dynamicType, count)
//        var t = property_getName(properties.memory)
//        var n = NSString(CString: t, encoding: NSUTF8StringEncoding)
//        var z:AnyObject?
//        let type = GrandModel.typeMapTable[n! as String]!
//        switch type{
//                case "Int": z = aDecoder.decodeIntegerForKey(n! as String)
//                case "Double": z = aDecoder.decodeDoubleForKey(n! as String)
//              case "Float": z = aDecoder.decodeFloatForKey(n! as String)
//              case "Bool": z = aDecoder.decodeBoolForKey(n! as String)
//                default:z = aDecoder.decodeObjectForKey(n! as String)
//        }
//        if   z != nil //不不定是Object,所以不能取出来
//        {
//            self.setValue(z!, forKey: n! as String)
//        }
//
//        print(n)
//        var s = properties.successor()
//        while s != nil{
//            t = property_getName(s.memory)
//            if t != nil{
//                n = NSString(CString: t, encoding: NSUTF8StringEncoding)
//                switch GrandModel.typeMapTable[n! as String]!{
//                case "Int": z = aDecoder.decodeIntegerForKey(n! as String)
//                case "Double": z = aDecoder.decodeDoubleForKey(n! as String)
//                case "Float": z = aDecoder.decodeFloatForKey(n! as String)
//                case "Bool": z = aDecoder.decodeBoolForKey(n! as String)
//                default:z = aDecoder.decodeObjectForKey(n! as String)
//                }
//                if   z != nil //不不定是Object,所以不能取出来
//                {
//                    self.setValue(z!, forKey: n! as String)
//                }
//                s = s.successor()
//                if s.memory.debugDescription == "0x0000000000000000"{ //说明已经完了
//                    break
//                }
//            }
//            else{
//                s = nil
//            }
//        }
//        free(properties)
//    }
