//
//  ZYYSubVC.m
//  scrollVC
//
//  Created by zyy on 2017/12/19.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "ZYYSubVC.h"

@interface ZYYSubVC ()

@end

@implementation ZYYSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setBackColor:(UIColor *)backColor{
    
    self.view.backgroundColor = backColor;
    
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