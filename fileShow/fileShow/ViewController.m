//
//  ViewController.m
//  fileShow
//
//  Created by zyy on 2017/12/13.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "ViewController.h"
#import "FileShowViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"showFile" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    button.frame = CGRectMake(100, 50, 100, 50);
    [button addTarget:self action:@selector(showFileMethod) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)showFileMethod{
    
    FileShowViewController * controller = [[FileShowViewController alloc] init];
    controller.fileUrlString = @"http://static.rz158.com/201712/13/09/2017121309a557ae3ce5b248dca77a8e8d9c965f9d.docx";
    controller.fileName = @"文件名称";
    [self presentViewController:controller animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
