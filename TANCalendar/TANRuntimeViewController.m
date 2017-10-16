//
//  TANRuntimeViewController.m
//  TANCalendar
//
//  Created by merrill on 2017/8/17.
//  Copyright © 2017年 TAN. All rights reserved.
//

#import "TANRuntimeViewController.h"

#import <objc/message.h>
#import <objc/runtime.h>
#import "TANBelleTeacher.h"
#import "TANBelleTeacher+Category.h"

@interface TANRuntimeViewController ()

@end

@implementation TANRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"runtime";
    [self changeVariable];
    [self addMethod];
    [self addExtentionProperty];
    [self exchangeMethod];
}


// 属性值交换
- (void)changeVariable {
    TANBelleTeacher *belleTeacher = [TANBelleTeacher new];
    belleTeacher.name = @"希尔瓦娜斯";
    NSLog(@"%@",belleTeacher.name);
    
    unsigned int count;
    Ivar *ivar = class_copyIvarList([belleTeacher class], &count);
    for (int i = 0; i< count; i++) {
        Ivar var = ivar[i];
        const char *varName = ivar_getName(var);
        NSString *name = [NSString stringWithCString:varName encoding:NSUTF8StringEncoding];
        if ([name isEqualToString:@"_name"]) {
            object_setIvar(belleTeacher, var, @"奥妮克希亚");
            break;
        }
    }
    NSLog(@"%@",belleTeacher.name);
}

// 增加方法
- (void)addMethod
{
    TANBelleTeacher *belleTeacher = [TANBelleTeacher new];
    belleTeacher.name = @"希尔瓦娜斯";
    
    class_addMethod([belleTeacher class], @selector(join), (IMP)fuck, "v@:");
    [belleTeacher performSelector:@selector(join)];
}

void fuck(id self, SEL _cmd){
    NSLog(@"干");
}


// 增加属性
- (void)addExtentionProperty
{
    TANBelleTeacher *belleTeacher = [TANBelleTeacher new];
    belleTeacher.boyFriend = @"Merlin";
    NSLog(@"添加属性boyFriend结果:%@ ",belleTeacher.boyFriend);
}


// 方法交换
- (void)exchangeMethod
{
    TANBelleTeacher *belleTeacher = [TANBelleTeacher new];
    belleTeacher.name = @"希尔瓦娜斯";
    [belleTeacher getUndressed];
    [belleTeacher bathe];
    
    NSLog(@"----------交换方法实现-----------");
    Method m1 = class_getInstanceMethod([belleTeacher class], @selector(getUndressed));
    Method m2 = class_getInstanceMethod([belleTeacher class], @selector(bathe));
    method_exchangeImplementations(m1, m2);
    
    [belleTeacher getUndressed];
    [belleTeacher bathe];
}


// 使用runtime对当前的应用中加载的类进行打印操作
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    unsigned int count = 0;
    Class *classes = objc_copyClassList(&count);
    for (int i = 0; i < count; i++) {
        const char *cname = class_getName(classes[i]);
        printf("%s\n", cname);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 函数的定义规则如下：
 
 对对象进行操作的方法一般以object_开头
 对类进行操作的方法一般以class_开头
 对类或对象的方法进行操作的方法一般以method_开头
 对成员变量进行操作的方法一般以ivar_开头
 对属性进行操作的方法一般以property_开头开头
 对协议进行操作的方法一般以protocol_开头
 */

/**
 那么Runtime在我们实际开发中会起到说明作用呢？主要有以下几点：
 1. 动态的添加对象的成员变量和方法,修改属性值和方法
 2. 动态交换两个方法的实现
 3. 实现分类也可以添加属性
 4. 实现NSCoding的自动归档和解档
 5. 实现字典转模型的自动转换
 6. 动态创建一个类(比如KVO的底层实现)
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
