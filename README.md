# GrandModel
GrandModel is an iOS MVC Base Model,it's a super model for all the Models  **GrandModel 是一个iOS MVC的基类,它可以作为所有Model的父类**
##Key Features(关键特点)
+ Override Description and DebugDescription func, you can print all the cars on the console **重写了Description方法,和DebugDescription方法,可以在在控制台打印出全部变量**
+ Implement NSCoding protocal, all the model which in herit GrandModel can archive automatically **实现了NSCoding协议,可以将子类的所有数据自动归档**
+ Can Transmate Dict to Model automatically **可以实现自动将字典转化成Model**
+ 
##Requirements 【系统需要】

Xcode 7.2 and iOS 8.0(the lasted swift grammar)
【Xcode 7.2 and iOS 8.0(最新的Swift语法)】

##Installation 【安装】
+ GrandModel do not support Cocoapods,Please copy GrandModel.swift the file to your project, and please note: GtandModel do not support Objective C
**GrandModel 不支持CocoaPods，所以请直接拷贝GrandModel.swift文件到你的项目里面就行，请注意GrandModel不支持Objective C**
<br>

##How To Use It 【怎么使用】
+ GrandModel override description func and debugDescription func，  So any class inherid from GrandModel can print all the properties **GrandModel 重新了description和debugDescription方法，因此任务继承天GrandModel的类都可以打印出所有属性出来**
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
  
  then is easy to use mapModel func to convert Dict to model
  
   let demoDict:[String:AnyObject] = ["sName":1234567,"iAge":"12","ib":true,"iGrade":"6","UserName":"userName","DemoOther":["userName":"OtherUserName"],
        "DemoOthers":[["userName":"OtherUserName1"],["userName":"OtherUserName2"]]]
    var demo  = DemoClass.mapModel(demoDict)
    print(demo)
```

##Contact 
Any issue or problem please contact me:3421902@qq.com, I will be happy fix it
**任何问题或者BUG请直接和我联系3421902@qq.com, 我会乐于帮你解决**
