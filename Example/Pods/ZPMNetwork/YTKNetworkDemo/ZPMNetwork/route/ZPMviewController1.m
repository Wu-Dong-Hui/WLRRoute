//
//  ZPMviewController1.m
//  testPod_Example
//
//  Created by pchen on 2018/4/23.
//  Copyright © 2018年 pchen. All rights reserved.
//

#import "ZPMviewController1.h"

@interface ZPMviewController1 ()

@end

@implementation ZPMviewController1

+ (instancetype)view {
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"bundle" ofType:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
   
    UIImage *img3 = [UIImage imageNamed:@"yw.jpg"];

  //  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Storyboard" bundle:resourceBundle];
    
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
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
