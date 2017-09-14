//
//  ViewController.h
//  Objc Playground
//
//  Created by Ahri on 7/2/17.
//  Copyright © 2017 hungMighty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemoryLeakViewController.h"

@interface MenuViewController : UIViewController

@property (nonatomic, weak) MemoryLeakViewController *viewController;

@end

