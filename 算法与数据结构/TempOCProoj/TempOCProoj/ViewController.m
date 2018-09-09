//
//  ViewController.m
//  TempOCProoj
//
//  Created by 朱金倩 on 2018/8/18.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+ZYObserverable.h"
#import "ZYTempView.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface ZYLineView : UIView
@end

@implementation ZYLineView

- (void)drawRect:(CGRect)rect {
    CGPoint p0 = CGPointMake(20,  300);
    CGPoint p1 = CGPointMake(100, 210);
    CGPoint p2 = CGPointMake(180, 210);
    CGPoint p3 = CGPointMake(260, 300);
    
    NSValue *v0 = [NSValue valueWithCGPoint:p0];
    NSValue *v1 = [NSValue valueWithCGPoint:p1];
    NSValue *v2 = [NSValue valueWithCGPoint:p2];
    NSValue *v3 = [NSValue valueWithCGPoint:p3];
    
    NSArray *points = @[v0,v0,v1,v2,v3,v3];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:p0];
    
    
    for (NSUInteger i = 0; i < points.count - 3; i ++) {
        CGPoint t0 = [[points objectAtIndex:i] CGPointValue];
        CGPoint t1 = [[points objectAtIndex:i + 1] CGPointValue];
        CGPoint t2 = [[points objectAtIndex:i + 2] CGPointValue];
        CGPoint t3 = [[points objectAtIndex:i + 3] CGPointValue];

        for (NSUInteger k = 0; k < 100 ; k++) {
            CGFloat tt = k / 100.0;
            CGPoint controlPoint = [self getPointWith:tt p0:t0 p1:t1 p2:t2 p3:t3];
            [path addLineToPoint:controlPoint];
        }
    }
    [path addLineToPoint:p3];
    [path stroke];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = rect;
    layer.backgroundColor = [[UIColor whiteColor] CGColor];
    layer.bounds = CGRectMake(0, 0, rect.size.width, rect.size.height);
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.lineWidth = 2;
    layer.fillColor = [[UIColor whiteColor] CGColor];
    layer.path = path.CGPath;
    
    UIView *tv = [UIView new];
    [self printClass:tv];
    [self.layer addSublayer:layer];
}

- (CGPoint)getPointWith:(CGFloat)t
                     p0:(CGPoint)p0
                     p1:(CGPoint)p1
                     p2:(CGPoint)p2
                     p3:(CGPoint)p3 {
    CGFloat tt = t * t;
    CGFloat ttt = tt * t;
    
    CGFloat f0 = -0.5 * ttt + tt - 0.5 * t;
    CGFloat f1 = 1.5 * ttt - 2.5 * tt + 1.0f;
    CGFloat f2 = -1.5 * ttt + 2.0 * tt + 0.5 * t;
    CGFloat f3 = 0.5 * ttt - 0.5 * tt;
    
    CGFloat x = p0.x * f0 + p1.x * f1 + p2.x * f2 + p3.x * f3;
    CGFloat y = p0.y * f0 + p1.y * f1 + p2.y * f2 + p3.y * f3;
    
    return CGPointMake(x, y);
}

- (void)printClass:(NSObject *)object {
    NSLog(@"class name : %@", NSStringFromClass([object class]));
}

@end

#import <objc/runtime.h>

typedef void(^ZYTimerActionBlock)();

@interface ZYTimer : NSObject

- (instancetype)initWithInterval:(NSTimeInterval)interval
                      afterDelay:(NSTimeInterval)delay
                        isRepeat:(BOOL)isRepeat
                         inQueue:(nonnull dispatch_queue_t)queue
                    timerHandler:(nullable ZYTimerActionBlock)handler;
- (void)start;
- (void)cancel;

@end

@interface ZYTimer()

@property (nonatomic, copy) ZYTimerActionBlock handler;
@property (nonatomic, assign) NSTimeInterval delay;
@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, assign) BOOL isRepeat;
@property (nonatomic, strong) dispatch_queue_t timerQueue;

@end


@implementation ZYTimer
{
    dispatch_source_t _timer;
    BOOL _isActive;
}

- (instancetype)initWithInterval:(NSTimeInterval)interval
                      afterDelay:(NSTimeInterval)delay
                        isRepeat:(BOOL)isRepeat
                         inQueue:(nonnull dispatch_queue_t)queue
                    timerHandler:(nullable ZYTimerActionBlock)handler {
    self = [super init];
    if (self) {
        self.handler = handler;
        self.timerQueue = queue;
        self.isRepeat = YES;
        self.delay = delay;
        self.interval = interval;
        _isActive = NO;
    }
    return self;
}

- (void)start {
    if (self.timerQueue == nil) {
        return;
    }
    if (!_isActive) {
        if (!_timer) {
            [self createTimer];
        }
        dispatch_resume(_timer);
        _isActive = YES;
    }
}

- (void)cancel {
    if (_isActive) {
        !_timer ? : dispatch_source_cancel(_timer);
        _isActive = NO;
    }
}

- (void)createTimer {
    dispatch_queue_t queue = dispatch_get_main_queue();
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_time_t startTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.delay * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)self.interval * NSEC_PER_SEC;
    dispatch_source_set_timer(_timer, startTime, interval, 0);
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            !strongSelf.handler ? : strongSelf.handler();
            if (!strongSelf.isRepeat) {
                dispatch_source_cancel(strongSelf -> _timer);
            }
        });
    });
}




@end

@interface Student : NSObject

@end

@implementation Student

- (int)age {
    return 888;
}

@end

@interface Employee : NSObject
@end

@implementation Employee
- (int)age {
    return 777;
}
@end


@interface Person : NSObject

@property (copy, nonatomic) NSString * pName;
- (void)showInfo;
- (void)updateName:(NSString *)name;
@property (assign, nonatomic) NSInteger age;

@end

@implementation Person
@dynamic age;

int age(id self , SEL _cmd) {
    return 999;
}

int tempAge(id self, SEL _cmd) {
    return 1000;
}

//1
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    return [[Employee alloc] init];
//}

//2
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"resolveInstanceMethod : %@", NSStringFromSelector(sel));
    class_addMethod([self class], NSSelectorFromString(@"tempAge"), (IMP)age, "i@:");
    return NO;
}

//3
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"methodSignatureForSelector : %@",NSStringFromSelector(aSelector));
    NSMethodSignature *sig = [super methodSignatureForSelector:aSelector];
    if (!sig) {
        Student *stu = [[Student alloc] init];
        sig = [stu methodSignatureForSelector:aSelector];
    }
    NSLog(@"methodSignatureForSelector signature : %@",sig);
    return sig;
}

//4
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"methodSignatureForSelector signature : %@",anInvocation.methodSignature);
    Student *s = [[Student alloc] init];
    [anInvocation invokeWithTarget:s];
}

- (void)showInfo {
    NSLog(@"%@",[self class]);
}

- (void)updateName:(NSString *)name {
    [self willChangeValueForKey:@"pName"];
    _pName = name;
    [self didChangeValueForKey:@"pName"];
}

@end




@interface ViewController ()

@property (nonatomic, strong) ZYTimer *timer;
@property (nonatomic, strong) dispatch_source_t src;
@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation ViewController
{
    Person * _p;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    Person *p = [[Person alloc] init];
    p.pName = @"willson";
    _p = p;
   
    [p addObserver:self forKeyPath:@"pName" options:NSKeyValueObservingOptionNew context:nil];
    
    int count = 0;
    Method *list = class_copyMethodList(object_getClass(p), &count);
    for (int i = 0 ; i < count ; i++) {
        Method m = list[i];
        SEL sel = method_getName(m);
        NSString *methodName = NSStringFromSelector(sel);
        NSLog(@"kvo person obj method name : %@",methodName);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"pName"]) {
        NSLog(@"pName changed : %@",change[NSKeyValueChangeNewKey]);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_p updateName:@"helen"];
    NSLog(@"age : %zd",_p.age);
    
}

- (void)gcdTest {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"A");
    });
    NSLog(@"B");
    dispatch_queue_t tempQueue = dispatch_queue_create(DISPATCH_QUEUE_SERIAL, nil);
    
//    dispatch_queue_t tempQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0ul);
    dispatch_sync(tempQueue, ^{
        NSLog(@"C");
    });
    
    dispatch_async(tempQueue, ^{
        NSLog(@"D");
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"E");
    });
    
    [self performSelector:@selector(method) withObject:nil afterDelay:0.0];
    NSLog(@"F");
}

- (void)method {
    NSLog(@"G");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end



