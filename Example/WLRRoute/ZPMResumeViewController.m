//
//  ZPMResumeViewController.m
//  ZPMRoute_Example
//
//  Created by Roy on 2018/4/28.
//  Copyright © 2018年 Neo. All rights reserved.
//

#import "ZPMResumeViewController.h"

@interface ZPMResumeViewController ()

@end

@implementation ZPMResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"简历";
    
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor blueColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.frame = self.view.bounds;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"这是简历页";
    [self.view addSubview:label];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
