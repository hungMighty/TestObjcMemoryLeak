//
//  ViewController.m
//  Objc Playground
//
//  Created by 2B on 7/2/17.
//  Copyright © 2017 hungMighty. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController () {
    
}

@end

@implementation MenuViewController {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.retainCycleBlock != nil) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.retainCycleBlock();
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// MARK: - Actions

- (IBAction)flexibleButtonClicked:(UIButton *)sender {
    self.viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MemoryLeakViewController"];
    [self.navigationController pushViewController:self.viewController animated:true];
}

@end
