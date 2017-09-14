//
//  MemoryLeakViewController.m
//  Objc Playground
//
//  Created by Ahri on 9/13/17.
//  Copyright © 2017 hungMighty. All rights reserved.
//

#import "MemoryLeakViewController.h"

@interface MemoryLeakViewController ()

@end

@implementation MemoryLeakViewController

- (void)dealloc {
    NSLog(@"Calling Dealloc");
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.aNum = [NSNumber numberWithInt:10];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    __weak typeof(self) weakSelf = self;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)),
//                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                       if (weakSelf) {
//                           __strong typeof(weakSelf) strongSelf = weakSelf;
//                           NSLog(@"Print out NUM after 1 second: %ld", [strongSelf.aNum integerValue]);
//                       }
//                   });
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(100 * NSEC_PER_MSEC)),
//                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                       if (weakSelf) {
//                           __strong typeof(weakSelf) strongSelf = weakSelf;
//                           NSLog(@"Print out NUM after 0.1 second: %ld", [strongSelf.aNum integerValue]);
//                       }
//                   });
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    __weak typeof(self) weakSelf = self;
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        NSLog(@"Print out NUM - Main Queue: %ld", [self.aNum integerValue]);
//    });
    
    // WILL NEVER ENTER - dealloc already called by then so weakSelf of course is nil
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (weakSelf) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSLog(@"Print out NUM: %ld - after 2 seconds", [strongSelf.aNum integerValue]);
        }
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(100 * NSEC_PER_MSEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (weakSelf) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSLog(@"Print out NUM - after 0.1 seconds: %ld", [strongSelf.aNum integerValue]);
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
