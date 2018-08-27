//
//  NSObject+ZYObserverable.h
//  TempOCProoj
//
//  Created by 朱金倩 on 2018/8/25.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ZYKVO_ValueDidChangedBlock) (id observedObject, NSString *key, id oldValue , id newValue);

@interface NSObject (ZYObserverable)

- (void)zy_addObserver:(nonnull NSObject *)observer
                forKey:(nonnull NSString *)key
               options:(NSKeyValueObservingOptions)options
          changedBlock:(ZYKVO_ValueDidChangedBlock)block;

@end
