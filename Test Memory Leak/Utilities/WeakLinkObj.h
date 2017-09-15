//
//  WeakLinkObj.h
//  Test Memory Leak
//
//  Created by Ahri on 9/16/17.
//  Copyright © 2017 hungMighty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeakLinkObj : NSObject

@property (nonatomic, weak) id realTarget;

+ (instancetype)initWithRealTarget:(id)target;

@end
