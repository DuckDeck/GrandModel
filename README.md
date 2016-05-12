# GrandModel
GrandModel is an iOS MVC Base Model,it's a super model for all the Models  **GrandModel 是一个iOS MVC的基类,它可以作为所有Model的父类**
##Key Features(关键特点)
+ Override Description and DebugDescription func, you can print all the cars on the console **重写了Description方法,和DebugDescription方法,可以在在控制台打印出全部变量**
+ Implement NSCoding protocal, all the model which in herit GrandModel can archive automatically **实现了NSCoding协议,可以将子类的所有数据自动归档**
+ Can Transmate Dict to Model automatically **可以实现自动将字典转化成Model**

##Requirements 【系统需要】

Xcode 7.2 and iOS 8.0(the lasted swift grammar)
【Xcode 7.2 and iOS 8.0(最新的Swift语法)】

##Installation 【安装】
+ GrandModel do not support Cocoapods,Please copy GrandModel.swift the file to your project, and please note: GtandModel do not support Objective C
**GrandModel 不支持CocoaPods，所以请直接拷贝GrandModel.swift文件到你的项目里面就行，请注意GrandModel不支持Objective C**
<br>

##How To Use It 【怎么使用】
+ GrandModel override description func and debugDescription func，  So any class inherid from GrandModel can print all the properties **GrandModel 重新了description和debugDescription方法，因此任务继承于GrandModel的类都可以打印出所有属性出来**
+ GrandModel implement NSCoding protocal, So any class inherid from GrandModel can archive and unarchive automatically**GrandModel实现了NSCoding协议，因此所有继承了GrandModel的类都可以实现自动归档**
+ Any class inherid from GrandModel can use mapModel func to complete Dict->Model transform。Please refer the code below:**因此所有继承了GrandModel的类都可以用mapModel方法来实现Dict-》Model转换，请参考以下代码**
``` Swift
// define a class inherid GrandModel, and clain all the vars
class DemoClass:GrandModel {
    var name:String?
    var age:Int = 0
    var grade:Int = 0
    var score:Float = 0.0
    var isFool:Bool = false
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
    
    // then define a map table, the key is the dict that you want to transform, and the value is the var name.
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
    then override the selfMapDescription property and return the mapdict                   
    override  var  selfMapDescription: [String : String]?{
        return DemoClass.mapDict
    }
    if your project have array property, You must let GrandModel know the array type
     override var arrType:arrTypeBlock?
    {
        return   {(t:String) -> AnyClass in
          return DemoOther.self
        }
        
    }
  }
  
  class DemoOther: GrandModel {
    var userName:String?
     static var mapDict = ["userName":"userName"]
    override var selfMapDescription: [String : String]?{
        return DemoOther.mapDict
    }

}
  
  then is easy to use mapModel func to convert Dict to model
  
   let demoDict:[String:AnyObject] = ["sName":1234567,"iAge":"12","ib":true,"iGrade":"6","UserName":"userName","DemoOther":["userName":"OtherUserName"],
        "DemoOthers":[["userName":"OtherUserName1"],["userName":"OtherUserName2"]]]
    var demo  = DemoClass.mapModel(demoDict)
    print(demo)
    //打印结果
    DemoClass:["money": 10.1, "grade": 6, "isFool": 1, "intergerDemo": 2, "dateDemo": 2016-05-12 06:43:28 +0000, "otherClasses": <_TtCs21_SwiftDeferredNSArray 0x7f9c0bd1d780>(
DemoOther:["selfMapDescription": {
    userName = userName;
}, "userName": OtherUserName1],
DemoOther:["selfMapDescription": {
    userName = userName;
}, "userName": OtherUserName2]
)
, "pointDemo": NSPoint: {0, 0}, "age": 12, "selfMapDescription": {
    DemoOther = otherClass;
    DemoOthers = otherClasses;
    UserName = userName;
    iAge = age;
    iGrade = grade;
    ib = isFool;
    sName = name;
    sUserName = userName;
    score = score;
    userName = userName;
}, "name": 1234567, "sizeDemo": NSSize: {0, 0}, "score": 0, "arrType": <__NSMallocBlock__: 0x7f9c0bd1e700>, "dataDemo": <>, "rectDemo": NSRect: {{0, 0}, {0, 0}}, "userName": userName, "otherClass": DemoOther:["selfMapDescription": {
    userName = userName;
}, "userName": OtherUserName]]
可见，字典被正确地转化成了Model，无论里面有自定义类还是数组
```

##Contact 
Any issue or problem please contact me:3421902@qq.com, I will be happy fix it
**任何问题或者BUG请直接和我联系3421902@qq.com, 我会乐于帮你解决**
