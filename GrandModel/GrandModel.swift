//
//  GrandModel.swift
//  GrandModelDemo
//
//  Created by HuStan on 3/9/16.
//  Copyright © 2016 StanHu. All rights reserved.
//
import Foundation
import UIKit

typealias arrTypeBlock = (arrName:String)->AnyClass

protocol MapAble{
    static func mapModel(obj:AnyObject)->Self
}

class GrandModel:NSObject,NSCoding{
    var selfMapDescription:[String:String]?{
        get{
            return nil
        }
    }

    
    var arrType:arrTypeBlock?{
        get{
            return nil
        }
    }

    
    static var typeMapTable:[String:[String:(String,AnyClass)]] = [String:[String:(String,AnyClass)]]()
   
    required override init() {
        super.init()
        let modelName = "\(self.dynamicType)"
        if self.dynamicType == GrandModel.self
        {
            return
        }
        if !GrandModel.typeMapTable.keys.contains(modelName){
            GrandModel.typeMapTable[modelName] = [String:(String,AnyClass)]()
        }
        if GrandModel.typeMapTable[modelName]!.count != 0{
            return
        }
        
        
        
        //  let z = NSClassFromString("_TtC11DemoConsole9DemoOther")
        //对于NSIndexPath还有NSRange之类的就算了
        var count:UInt32 =  0
    //   var vars = class_copyIvarList(self.dynamicType, &count)
//        for j in 0..<count {
//            let s = NSString(CString: ivar_getTypeEncoding(vars[Int(j)]), encoding: NSUTF8StringEncoding)
//            print(s)
//        }
        //Issue0，问题是在Swift中无法获取IVar的类型。所有的数据全是空的，所以不得不放弃这个,而Property是可以获取类型的
        let pr = class_copyPropertyList(self.dynamicType, &count)
    
        
        for i  in 0..<count {
           let des = String.fromCString(property_getAttributes(pr[Int(i)]))
            let cTypes = des!.componentsSeparatedByString(",")
            if let className = cTypes.first
            {
                if let proertyName = cTypes.last{
                    let pn = (proertyName as NSString).substringFromIndex(1)
                    if des!.containsString("\""){
                        let cn = (className.stringByReplacingOccurrencesOfString("\"", withString: "") as NSString).substringFromIndex(2)
                        GrandModel.typeMapTable[modelName]![pn] = (cn,NSClassFromString(cn)!)
                    }
                    else if des!.containsString("{"){ //用{来可能比较好一点
                        let cgType = (className as NSString).substringWithRange(NSMakeRange(4, 4))
                        switch cgType{
                        case "Rect":GrandModel.typeMapTable[modelName]![pn] = ("CGRect",NSValue.self)
                        case "Size":GrandModel.typeMapTable[modelName]![pn] = ("CGSize",NSValue.self)
                        case "Poin":GrandModel.typeMapTable[modelName]![pn] = ("CGPoint",NSValue.self)
                        default:break
                        }
                    }
                    else{
                        let numType = (className as NSString).substringWithRange(NSMakeRange(1, 1))
                        switch numType{
                        case "q": GrandModel.typeMapTable[modelName]![pn] = ("Int",NSNumber.self)
                        case "f": GrandModel.typeMapTable[modelName]![pn] = ("Float",NSNumber.self)
                        case "d": GrandModel.typeMapTable[modelName]![pn] = ("Double",NSNumber.self)
                        case "B": GrandModel.typeMapTable[modelName]![pn] = ("Bool",NSNumber.self)
                        default:break
                        }
                    }
                }
            }
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
    /*
    func encodeWithCoder(aCoder: NSCoder) {
        let modelName = "\(self.dynamicType)"
        let dictProperties = GrandModel.typeMapTable[modelName]
        let count:UnsafeMutablePointer<UInt32> =  UnsafeMutablePointer<UInt32>()
        var properties = class_copyPropertyList(self.dynamicType, count)
        while properties.memory.debugDescription !=  "0x0000000000000000"{
            let t = property_getName(properties.memory)
            let n = NSString(CString: t, encoding: NSUTF8StringEncoding) as! String
            let v = self.valueForKey(n)
            encode(dictProperties![n]!.0, propertyName: n, value: v, aCoder: aCoder)
            properties = properties.successor()
        }
        
    }
    
    func encode(classType:String,propertyName:String,value:AnyObject?,aCoder:NSCoder){
        switch classType{
        case "Int": aCoder.encodeInteger(value as! Int, forKey: propertyName)
        case "Float": aCoder.encodeFloat(value as! Float, forKey: propertyName)
        case "Double": aCoder.encodeDouble(value as! Double, forKey: propertyName)
        case "CGRect": aCoder.encodeCGRect((value as! NSValue).CGRectValue(), forKey: propertyName)
        case "CGSize": aCoder.encodeCGSize((value as! NSValue).CGSizeValue(), forKey: propertyName)
        case "CGPoint": aCoder.encodeCGPoint((value as! NSValue).CGPointValue(), forKey: propertyName)
        default:aCoder.encodeObject(value, forKey: propertyName)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        let modelName = "\(self.dynamicType)"
        let dictProperties = GrandModel.typeMapTable[modelName]
        let count:UnsafeMutablePointer<UInt32> =  UnsafeMutablePointer<UInt32>()
        var properties = class_copyPropertyList(self.dynamicType, count)
        var result:AnyObject?
        while properties.memory.debugDescription !=  "0x0000000000000000"{
            let t = property_getName(properties.memory)
            let n = NSString(CString: t, encoding: NSUTF8StringEncoding) as! String
            let classType = dictProperties![n]!.0 //获取类型
            switch classType{
            case "Int": result = aDecoder.decodeIntegerForKey(n)
            case "Float": result = aDecoder.decodeFloatForKey(n)
            case "Double": result = aDecoder.decodeDoubleForKey(n)
            case "CGRect":
                result = NSValue(CGRect:aDecoder.decodeCGRectForKey(n))
            case "CGPoint":
                result = NSValue(CGPoint:aDecoder.decodeCGPointForKey(n))
            case "CGSize":
                result = NSValue(CGSize:aDecoder.decodeCGSizeForKey(n))
            default:result = aDecoder.decodeObjectForKey(n)
            }
            if result != nil{
                self.setValue(result!, forKey: n)
            }
            properties = properties.successor()
        }
    }
*/
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        let item = self.dynamicType.init()
        let properties = item.getSelfProperty()
        for propertyName in properties{
            let value = self.valueForKey(propertyName)
            aCoder.encodeObject(value, forKey: propertyName)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        let item = self.dynamicType.init()
        let properties = item.getSelfProperty()
        for propertyName in properties{
            let value = aDecoder.decodeObjectForKey(propertyName)
            self.setValue(value, forKey: propertyName)
        }
    }
    
    
    func getSelfProperty()->[String]{
        var selfProperties = [String]()
        var count:UInt32 =  0
        let properties = class_copyPropertyList(self.dynamicType, &count)
        for i in 0..<count {
            let t = property_getName(properties[Int(i)])
            if let n = NSString(CString: t, encoding: NSUTF8StringEncoding) as? String
            {
                selfProperties.append(n as String)
            }
        }
        return selfProperties
    }
}

extension GrandModel:MapAble{
    static func mapModel(obj:AnyObject)->Self{
        //  let modelName = "\(self)"
        let model = self.init()
        let modelName = "\(model.dynamicType)"
        let dictTypes = GrandModel.typeMapTable[modelName]
        if let mapDict = model.selfMapDescription{
            if let dict = obj as? [String:AnyObject]
            {
                for item in dict{
                    if let key = mapDict[item.0]{
                        print("key 为\(item.0)将要被设成\(key),其值是 \(item.1)")
                        let type = dictTypes![key]
                        if type == nil {
                            continue
                        }
                        if type!.1 is GrandModel.Type {
                            if !(item.1 is NSNull)
                            {
                              let s =  model.mapModel(item.1,type: type!.1)
                             model.setValue(s, forKey: key)
                            }
                            continue
                        }
                       else if type!.1 is NSArray.Type { //这个可真不好办了，因为Runtime只能获取到NSArray的属性，所以还需要一个变量来获取数据类型
                            var arrModel = [AnyObject]()
                            if let itemDict = item.1 as? [AnyObject]{
                                if let typeBlock = model.arrType{
                                   let aType = typeBlock(arrName: type!.0)
                                    if aType is GrandModel.Type{
                                        for item in itemDict {
                                            var m = (aType as! GrandModel.Type).init()
                                            m = m.mapModel(item, type: aType) as! GrandModel
                                            arrModel.append(m)
                                        }
                                        model.setValue(arrModel, forKey: key)
                                    }
                                    
                                    else{
                                        //如果只是简单类型，但是 一般不会出现这种情况
                                    }
                                    continue
                                }
                            }
                        }
                        if item.1 is NSNull {
                            continue
                        }
                        if item.1 is NSNumber{
                            if type?.0 == "Bool"{
                                model.setValue(item.1.boolValue, forKey: key)
                            }
                            else{
                                model.setValue("\(item.1)", forKey: key)
                            }
                        }
                        else{
                            model.setValue(item.1, forKey: key)
                        }
                    }
                }
            }
        }
    return model
}
    
    
    
    func mapModel(obj:AnyObject,type:AnyClass)->AnyObject{
        let model = (type as! GrandModel.Type).init()
        let modelName = "\(type)"
        let dictTypes = GrandModel.typeMapTable[modelName]
        if let mapDict = model.selfMapDescription{
            if let dict = obj as? [String:AnyObject]{
                for item in dict{
                    if let key = mapDict[item.0]{
                        print("key 为\(item.0)将要被设成\(key),其值是 \(item.1)")
                        let type = dictTypes![key]
                        if type!.1 is GrandModel.Type {
                            let s =  self.mapModel(item.1,type: type!.1)
                            model.setValue(s, forKey: key)
                        }
                        if item.1 is NSNull {
                            continue
                        }
                        if item.1 is NSNumber{
                            if type?.0 == "Bool"{
                                model.setValue(item.1.boolValue, forKey: key)
                            }
                            else{
                                model.setValue("\(item.1)", forKey: key)
                            }
                        }
                        else{
                            model.setValue(item.1, forKey: key)
                        }
                    }
                }
            }
        }
        return model
    }

    
}




extension GrandModel{
    internal override var description:String{
        get{
            var dict = [String:AnyObject]()
            var count:UInt32 =  0
            let properties = class_copyPropertyList(self.dynamicType, &count)
            for i in 0..<count {
                let t = property_getName(properties[Int(i)])
                if let n = NSString(CString: t, encoding: NSUTF8StringEncoding) as? String
                {
                    let v = self.valueForKey(n ) ?? "nil"
                    dict[n] = v
                }
                
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


//                            let method =   class_getClassMethod(type!.1, NSSelectorFromString("mapModel:"))
//                                let p = method_getImplementation(method)
//                            method_setImplementation(<#T##m: Method##Method#>, <#T##imp: IMP##IMP#>)
//                            typealias MyCFunction = @convention(c) (AnyObject, Selector) -> Void
//                           let curriedImplementation = unsafeBitCast(p, MyCFunction.self)
//
//                           curriedImplementation(self, NSSelectorFromString("mapModel:"))
//                            print(method)


//首先判断其类型
//              if   GrandModel.typeMapTable[modelName]!.keys.contains(key) &&  GrandModel.typeMapTable[modelName]![key]! is GrandModel.Type{
//                 let classType = GrandModel.typeMapTable[modelName]![key]!
//              var  s =  (classType as! GrandModel.Type).init()
//在这里用静态方法是行不通的，只有用非静态方法了
//如果使用静态的方式来转换，到这里已经是死胡同了。因为在这里无法获取映射表
//以后再研究，

//                            let modelItem =
//
//                            model.setValue(modelItem, forKey: key)
//     }
//  else{
