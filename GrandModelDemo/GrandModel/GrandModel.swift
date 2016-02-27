//
//  GrandModel.swift
//  GrandModelDemo
//
//  Created by Tyrant on 2/27/16.
//  Copyright © 2016 Qfq. All rights reserved.
//

import Foundation
protocol mapble{
    func mapModel(obj:AnyObject)->Self
}
class GrandModel:NSObject,NSCoding {
    var selfMapDescription:[String:String]?
    static var typeMapTable:[String:String] = [String:String]()
    required override init() {
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        let count:UnsafeMutablePointer<UInt32> =  UnsafeMutablePointer<UInt32>()
        let properties = class_copyPropertyList(self.dynamicType, count)
        var t = property_getName(properties.memory)
        var n = NSString(CString: t, encoding: NSUTF8StringEncoding)
        let v = self.valueForKey(n as! String)
        if v != nil{
            encode(v!, key: n! as String, aCoder: aCoder)
        }
        print(n)
        var s = properties.successor()
        while s != nil{
            t = property_getName(s.memory)
            if t != nil{
                n = NSString(CString: t, encoding: NSUTF8StringEncoding)
                let value = self.valueForKey(n as! String)
                s = s.successor()
                if value != nil{
                    encode(value!, key: n! as String, aCoder: aCoder)
                }
                if s.memory.debugDescription == "0x0000000000000000"{ //说明已经完了
                    break
                }
            }
            else{
                s = nil
            }
        }
        free(properties)
    }
    
    func encode(obj:AnyObject,key:String,aCoder:NSCoder){
        if obj is Int{
            aCoder.encodeInteger(obj as! Int, forKey: key)
            GrandModel.typeMapTable[key] = "Int"
        }
       else if obj is Double{
            aCoder.encodeDouble(obj as! Double, forKey: key)
            GrandModel.typeMapTable[key] = "Double"
        }
      else  if obj is Float{
            aCoder.encodeFloat(obj as! Float, forKey: key)
           GrandModel.typeMapTable[key] = "Float"
        }
       else if obj is Bool{
            aCoder.encodeBool(obj as! Bool, forKey: key)
            GrandModel.typeMapTable[key] = "Bool"
        }
        else{
            aCoder.encodeObject(obj, forKey: key)
           GrandModel.typeMapTable[key] = "Object"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        let count:UnsafeMutablePointer<UInt32> =  UnsafeMutablePointer<UInt32>()
        let properties = class_copyPropertyList(self.dynamicType, count)
        var t = property_getName(properties.memory)
        var n = NSString(CString: t, encoding: NSUTF8StringEncoding)
        var z:AnyObject?
        let type = GrandModel.typeMapTable[n! as String]!
        switch type{
                case "Int": z = aDecoder.decodeIntegerForKey(n! as String)
                case "Double": z = aDecoder.decodeDoubleForKey(n! as String)
              case "Float": z = aDecoder.decodeFloatForKey(n! as String)
              case "Bool": z = aDecoder.decodeBoolForKey(n! as String)
                default:z = aDecoder.decodeObjectForKey(n! as String)
        }
        if   z != nil //不不定是Object,所以不能取出来
        {
            self.setValue(z!, forKey: n! as String)
        }

        print(n)
        var s = properties.successor()
        while s != nil{
            t = property_getName(s.memory)
            if t != nil{
                n = NSString(CString: t, encoding: NSUTF8StringEncoding)
                switch GrandModel.typeMapTable[n! as String]!{
                case "Int": z = aDecoder.decodeIntegerForKey(n! as String)
                case "Double": z = aDecoder.decodeDoubleForKey(n! as String)
                case "Float": z = aDecoder.decodeFloatForKey(n! as String)
                case "Bool": z = aDecoder.decodeBoolForKey(n! as String)
                default:z = aDecoder.decodeObjectForKey(n! as String)
                }
                if   z != nil //不不定是Object,所以不能取出来
                {
                    self.setValue(z!, forKey: n! as String)
                }
                s = s.successor()
                if s.memory.debugDescription == "0x0000000000000000"{ //说明已经完了
                    break
                }
            }
            else{
                s = nil
            }
        }
        free(properties)
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

extension GrandModel:mapble{
    func mapModel(obj:AnyObject)->Self{
        let model = self.dynamicType.init()
        if let mapTable = selfMapDescription{
            if let dict = obj as? [String:AnyObject]
            {
                for item in dict{
                    if let key = mapTable[item.0]{
                        print("key 为\(item.0)将要被设成\(mapTable[item.0),其值是 \(item.1)")
                        model.setValue(item.1, forKey: key)
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
            let properties = class_copyPropertyList(self.dynamicType, count)
            if count != nil{
                for i in 0...count.memory{
                    let property = properties[Int(i)]
                    let name = property_getName(property)
                    let n = NSString(CString: name, encoding: NSUTF8StringEncoding) ?? "\(i)"
                    let value = self.valueForKey(n as String) ?? "nil"
                    dict[n as String] = value
                    
                }
            }
            else{
                var t = property_getName(properties.memory)
                var n = NSString(CString: t, encoding: NSUTF8StringEncoding)
                let v = self.valueForKey(n as! String) ?? "nil"
                dict[n as! String] = v
                print(n)
                var s = properties.successor()
                while s != nil{
                    t = property_getName(s.memory)
                    if t != nil{
                        n = NSString(CString: t, encoding: NSUTF8StringEncoding)
                        let value = self.valueForKey(n as! String) ?? "nil"
                        dict[n as! String] = value
                        s = s.successor()
                        if s.memory.debugDescription == "0x0000000000000000"{ //说明已经完了
                            break
                        }
                    }
                    else{
                        s = nil
                    }
                }
                free(properties)
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

