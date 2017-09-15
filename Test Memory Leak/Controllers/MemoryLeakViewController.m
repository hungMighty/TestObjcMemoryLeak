//
//  MemoryLeakViewController.m
//  Objc Playground
//
//  Created by Ahri on 9/13/17.
//  Copyright © 2017 hungMighty. All rights reserved.
//

#import "MemoryLeakViewController.h"
#import "MenuViewController.h"

@interface MemoryLeakViewController ()

@end

@implementation MemoryLeakViewController

- (void)dealloc {
    NSLog(@"Calling Dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.aStr = @"A String Value";
    
    // After executing, this block still lives... self obviously is retained
    // We get a warning
//    self.selfPointingBlock = ^BOOL(NSString *str) {
//        NSLog(@"Print out NUM - UIView Animation: %@", self.aStr);
//
//        return false;
//    };
    
    
    // This Block does not retain self -> dealloc will be called
    __weak typeof(self) weakSelf = self;
    self.weakSelfBlock = ^void(BOOL boolValue, NSNumber *num) {
        if (weakSelf) {
            __weak typeof(weakSelf) strongSelf = weakSelf;
            NSLog(@"Print out NUM - UIView Animation: %@", strongSelf.aStr);
        }
    };
    
    // Create retain cycle and no warning at all. Therefore, it does not matter what stores the block...
    // If it is being held by a strong pointer while keeping a self. A retain cycle is created
    
//    for (int i = 0; i < self.navigationController.viewControllers.count; i++) {
//        if ([self.navigationController.viewControllers[i] isKindOfClass:[MenuViewController class]]) {
//            MenuViewController *view = (MenuViewController *)self.navigationController.viewControllers[i];
//            view.retainCycleBlock = ^{
//                NSLog(@"Print out NUM - UIView Animation: %@", self.aStr);
//            };
//            break;
//        }
//    }
    
    
    
    for (int i = 0; i < self.navigationController.viewControllers.count; i++) {
        if ([self.navigationController.viewControllers[i] isKindOfClass:[MenuViewController class]]) {
            MenuViewController *view = (MenuViewController *)self.navigationController.viewControllers[i];
            __weak typeof(self) weakSelf = self;
            view.retainCycleBlock = ^{
//                if (weakSelf) {
//                    __strong typeof(weakSelf) strongSelf = weakSelf;
//                    NSLog(@"Print out NUM - UIView Animation: %@", strongSelf.aStr);
//                }
                
                // able to keep self until this block done executing
                NSLog(@"Calling from MenuViewController's Block: %@", self.aStr);
            };
            break;
        }
    }
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
