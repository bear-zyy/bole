//
//  ViewController.m
//  scrollVC
//
//  Created by zyy on 2017/12/15.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "ViewController.h"
#import "ZYYScrolMainlVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"scrollclick" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    button.frame = CGRectMake(100, 50, 200, 50);
    [button addTarget:self action:@selector(scrollclick) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)scrollclick{
    
    ZYYScrolMainlVC * vc = [[ZYYScrolMainlVC alloc] init];
    
    [self presentViewController:vc animated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
