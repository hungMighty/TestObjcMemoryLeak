//
//  MemoryLeakViewController.h
//  Objc Playground
//
//  Created by 2B on 9/13/17.
//  Copyright © 2017 hungMighty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemoryLeakViewController : UIViewController

@property (nonatomic, strong) NSString *aStr;
@property (nonatomic, copy) BOOL (^selfPointingBlock)(NSString *str);
@property (nonatomic, copy) void (^weakSelfBlock)(BOOL boolValue, NSNumber *num);
@property (nonatomic, strong) NSTimer *timer;

@end
