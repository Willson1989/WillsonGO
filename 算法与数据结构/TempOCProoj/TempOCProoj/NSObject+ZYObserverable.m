//
//  NSObject+ZYObserverable.m
//  TempOCProoj
//
//  Created by 朱金倩 on 2018/8/25.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

#import "NSObject+ZYObserverable.h"
#import <objc/runtime.h>
#import <objc/message.h>

static char const * kObservers= "ZYOBSERVERS";


@interface ZYKVOOberverInfo : NSObject

@property (nonatomic, copy) ZYKVO_ValueDidChangedBlock block;
@property (nonatomic, copy) NSString * observerName;
@property (nonatomic, copy) NSString * key;

- (instancetype)initWithObserverName:(NSString *)name key:(NSString *)key block:(ZYKVO_ValueDidChangedBlock)block;

@end

@implementation ZYKVOOberverInfo

- (instancetype)initWithObserverName:(NSString *)name key:(NSString *)key block:(ZYKVO_ValueDidChangedBlock)block {
    self = [super init];
    if (self) {
        self.block = block;
        self.observerName = name;
        self.key = key;
    }
    return self;
}

@end

@implementation NSObject (ZYObserverable)


- (void)zy_addObserver:(nonnull NSObject *)observer
            forKey:(nonnull NSString *)key
               options:(NSKeyValueObservingOptions)options
          changedBlock:(ZYKVO_ValueDidChangedBlock)block {
    if (key.length == 0) {
        return;
    }
    //先获取key指定的setter方法字符串
    NSString *setterName = zy_setterString(key);
    
    //获取被观察类的setter方法
    Method setterMethod = class_getInstanceMethod(self.class, NSSelectorFromString(setterName));
    
    //获取被观察的类并以此生成相应的子类
    NSString *oldClazzName = NSStringFromClass(self.class);
    NSString *kvoClazzName = [NSString stringWithFormat:@"ZYKVO_%@",oldClazzName];
    Class kvoClazz;
    kvoClazz = objc_lookUpClass(kvoClazzName.UTF8String);
    if (!kvoClazz) {
        //如果新的子类找不到，则创建一个
        kvoClazz = objc_allocateClassPair(self.class, kvoClazzName.UTF8String, 0);
        objc_registerClassPair(kvoClazz);
    }
    
    if (setterMethod) {
        //如果setter方法在父类中存在,则为ZYKVO_Class添加该方法，并指向自己的实现函数指针
        class_addMethod(kvoClazz, NSSelectorFromString(setterName), (IMP)setterIMP, "v@:@");
    } else {
        //如果方法不存在，则通过KVC来改变值
        //method swizzle
        Method oriSetter = class_getInstanceMethod(self.class, @selector(setValue:forKey:));
        Method newSetter = class_getInstanceMethod(self.class, @selector(swizz_setValue:forKey:));
        method_exchangeImplementations(oriSetter, newSetter);
    }
    //让父类的isa指针指向新创建的子类
    object_setClass(self, kvoClazz);
    
    ZYKVOOberverInfo *info = [[ZYKVOOberverInfo alloc] initWithObserverName:observer.description key:key block:block];
    NSMutableArray *observers = objc_getAssociatedObject(self, kObservers);
    if (!observers) {
        observers = [NSMutableArray array];
        objc_setAssociatedObject(self, kObservers, observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [observers addObject:info];
}

- (void)swizz_setValue:(nonnull id)newValue forKey:(nonnull NSString *)key {
    id oldValue = [self valueForKey:key];
    //因为已经进行了方法置换，所以此时swizz_setValue:forKey:是父类的原来的setValue:forKey:方法
    [self swizz_setValue:newValue forKey:key];
    //通知观察者
    NSMutableArray *observers = objc_getAssociatedObject(self, kObservers);
    for (ZYKVOOberverInfo *obv in observers) {
        if ([obv.key isEqualToString:key]) {
            obv.block(self, key, oldValue, newValue);
        }
    }
}

void setterIMP(id self, SEL _cmd, id newValue) {
    
    //当前self.class已经指向了ZYKVO_XX
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *temp = zy_upperTolower([setterName substringFromIndex:@"set".length], 0);//去除set并将大写改成小写
    NSString *key = [temp substringToIndex:temp.length-1];//去除冒号
    
    id oldValue = [self valueForKey:key];
    //构造父类结构体
    struct objc_super superClazz = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    ((void (*)(void * , SEL, id))objc_msgSendSuper)(&superClazz, _cmd, newValue);
    
    //通知观察者
    NSMutableArray *observers = objc_getAssociatedObject(self, kObservers);
    for (ZYKVOOberverInfo *obv in observers) {
        if ([obv.key isEqualToString:key]) {
            obv.block(self, key, oldValue, newValue);
        }
    }
}

static NSString * zy_setterString(NSString *key){
    NSString *newKey = zy_lowerToUpper(key, 0);
    return [NSString stringWithFormat:@"set%@:",newKey];
}

static NSString * zy_lowerToUpper(NSString *str,NSInteger location){
    NSRange range = NSMakeRange(location, 1);
    NSString *lowerLetter = [str substringWithRange:range];
    return [str stringByReplacingCharactersInRange:range withString:lowerLetter.uppercaseString];
}

static NSString * zy_upperTolower(NSString *str,NSInteger location){
    NSRange range = NSMakeRange(location, 1);
    NSString *lowerLetter = [str substringWithRange:range];
    return [str stringByReplacingCharactersInRange:range withString:lowerLetter.lowercaseString];
}

@end
