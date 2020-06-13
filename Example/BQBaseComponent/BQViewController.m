//
//  BQViewController.m
//  BQBaseComponent
//
//  Created by zhang_j@yeah.net on 06/11/2020.
//  Copyright (c) 2020 zhang_j@yeah.net. All rights reserved.
//

#import "BQViewController.h"
#import "MBProgressHUD+BQ.h"
#import "UIButton+WBBlock.h"
#import "BQCommMacro.h"
#import "BQViewControllerOne.h"
#import "BQTwoViewController.h"
@interface BQViewController ()

@end

@implementation BQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = UIColor.whiteColor;
    [MBProgressHUD showSuccessHUD:nil text:@"弹框1"];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD showFailedHUD:self.view text:@"弹框2"];
    });
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 40)];
    WS(weakSelf);
    [button wb_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        BQViewControllerOne *vc = [[BQViewControllerOne alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    button.backgroundColor = UIColor.redColor;
    [self.view addSubview:button];
    
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 100, 40)];
    [button1 wb_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        BQTwoViewController *vc = [[BQTwoViewController alloc] init];
        [weakSelf presentViewController:vc animated:YES completion:nil];
    }];
    button1.backgroundColor = UIColor.redColor;
    [self.view addSubview:button1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
