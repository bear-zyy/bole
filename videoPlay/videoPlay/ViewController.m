//
//  ViewController.m
//  videoPlay
//
//  Created by zyy on 2017/12/22.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "ViewController.h"
#import "palyViewController.h"
#import "palyViewVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"playview" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    button.frame = CGRectMake(100, 50, 100, 50);
    [button addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * play = [UIButton buttonWithType:UIButtonTypeCustom];
    [play setTitle:@"play" forState:UIControlStateNormal];
    [play setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:play];
    play.frame = CGRectMake(200, 100, 100, 50);
    [play addTarget:self action:@selector(playClick) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)playClick{
    
    [self presentViewController:[palyViewVC new] animated:YES completion:nil];
    
}

-(void)play{
    
    [self presentViewController:[palyViewController new] animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
