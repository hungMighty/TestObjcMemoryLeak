//
//  WeakLinkObj.m
//  Test Memory Leak
//
//  Created by 2B on 9/16/17.
//  Copyright © 2017 hungMighty. All rights reserved.
//

#import "WeakLinkObj.h"

@implementation WeakLinkObj

+ (instancetype)initWithRealTarget:(id)target {
    WeakLinkObj *obj = [[WeakLinkObj alloc] init];
    if (obj) {
        obj.realTarget = target;
    }
    return obj;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.realTarget;
}

@end
