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
    
    self.aStr = @"A String Value";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:2.0 animations:^() {
        // SAFE ZONE
        self.view.backgroundColor = UIColor.yellowColor;
        
    } completion:^(BOOL finished) {
        if (weakSelf) {
            NSLog(@"Print out NUM - UIView Animation: %@", weakSelf.aStr);
        }
    }];

    // Main queue is very strong, sometimes even weakSelf got retained for execution
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (weakSelf) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSLog(@"Print out NUM - Main Queue: %@", strongSelf.aStr);
        }
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (0.5 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (weakSelf) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSLog(@"Print out NUM: %@ - after 0.5 second", strongSelf.aStr);
        }
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(100 * NSEC_PER_MSEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (weakSelf) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSLog(@"Print out NUM - after 0.1 second: %@", strongSelf.aStr);
        }
        
        // able to retain self and wait for this block to get called
//        NSLog(@"Print out NUM - after 0.1 second: %@", self.aStr);
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
