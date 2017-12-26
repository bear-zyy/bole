//
//  palyViewController.m
//  videoPlay
//
//  Created by zyy on 2017/12/22.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "palyViewController.h"
#import "tableCell.h"

@interface palyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * tableview;

@property(nonatomic,strong) NSMutableArray * dataSource;

@end

@implementation palyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    [self.tableview registerClass:[tableCell class] forCellReuseIdentifier:@"tableCell"];
    
    self.dataSource = [NSMutableArray arrayWithArray:@[
                                                       @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"
                                                       ,@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"
                                                       ,@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"
                                                       ,@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"]];
    [self.tableview reloadData];
    // Do any additional setup after loading the view.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    tableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
//    if (!cell) {

//        cell = [[[tableCell alloc] initWithStyle:UITableViewCellStyleDefault] reuseIdentifier:@"tableCell"];
        
//    }
    cell.stringUrl = self.dataSource[indexPath.row];
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 250;
    
}


@end
