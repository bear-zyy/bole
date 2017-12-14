//
//  ViewController.m
//  PopView
//
//  Created by zyy on 2017/12/14.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "ViewController.h"
#import "popView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"popViewShow" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    button.frame = CGRectMake(100, 50, 150, 50);
    [button addTarget:self action:@selector(popViewShow) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)popViewShow{
    
    popView * view = [[NSBundle mainBundle] loadNibNamed:@"popView" owner:self options:nil].firstObject;
    view.popViewType = 1;
    view.popViewBlock = ^(NSString *string) {
        NSLog(@"%@" , string);
    };
    [view show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
