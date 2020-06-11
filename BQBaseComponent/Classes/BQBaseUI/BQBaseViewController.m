//
//  BQBaseViewController.m
//  BQBaseProject
//
//  Created by Zhang Jie on 2020/6/9.
//  Copyright © 2020 BiQuan. All rights reserved.
//

#import "BQBaseViewController.h"
#import "UIColor+Hex.h"
#import "UIViewController+Extension.h"
/**
   一些其他公用设置，方法都也可以定义在这个里面。
 */

@interface BQBaseViewController ()

@end

@implementation BQBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor bq_colorWithHexString:@"#F8F8F8"];
    [self addBlackBackButton];
    
    [self setupForDismissKeyboard];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
