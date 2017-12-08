//
//  tableViewController.m
//  CollectionTest
//
//  Created by zyy on 2017/7/28.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "tableViewController.h"
#import "ZTStatusCell.h"

#import "ZTStatusFrame.h"

#import "ZTStatus.h"

@interface tableViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView  * tableview;

@property (nonatomic, strong) NSMutableArray *statusFrame;

@end

@implementation tableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 600) style:UITableViewStylePlain];
    
    [self.tableview registerClass:[ZTStatusCell class] forCellReuseIdentifier:@"status"];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    self.tableview.estimatedRowHeight = 120;
    
    [self.view addSubview:self.tableview];

    NSArray * array = @[@{@"screen_name":@"于点",@"smallCircle":@"平面设计",@"created_at":@"12-4 8：30",@"text":@"你是一个人才，你是一个人才，哈哈哈哈哈   也是够了",@"pic_urls":@[@"label_delete.png",@"label_delete.png",@"label_delete.png",@"label_delete.png"]}
                        ,@{@"screen_name":@"于点",@"smallCircle":@"平面设计",@"created_at":@"12-4 8：30",@"text":@"你是一个hah哈哈哈哈哈哈哈哈哈哈哈哈哈哈  越多越好大啊啊大事发生大法师法人才，你是一个人才，哈哈哈哈哈   也是够了",@"pic_urls":@[@"label_delete.png"]}
                        ,@{@"screen_name":@"于点",@"smallCircle":@"平面设计",@"created_at":@"12-4 8：30",@"text":@"",@"pic_urls":@[@"label_delete.png",@"label_delete.png",@"label_delete.png",@"label_delete.png",@"label_delete.png",@"label_delete.png",@"label_delete.png"]}];
     NSMutableArray * statusArr = [NSMutableArray array];
    for (NSDictionary * dict in array) {
        ZTStatus *status = [[ZTStatus alloc] init];
        status.text = dict[@"text"];
        status.created_at = dict[@"created_at"];
        ZTUsers * user = [[ZTUsers alloc] init];
        user.screen_name = dict[@"screen_name"];
        user.profile_image_url = dict[@"profile_image_url"];
        user.smallCircle = dict[@"smallCircle"];
        status.user = user;
        status.id = 3;
        status.source = @"www";
        status.reposts_count = 4;
        status.comments_count = 6;
        status.attitudes_count = 8;
        status.pic_urls = dict[@"pic_urls"];
        [statusArr addObject:status];
    }
    
    self.statusFrame = [NSMutableArray array];
    for (ZTStatus *status in statusArr) {
        ZTStatusFrame *statusFrame = [[ZTStatusFrame alloc] init];
        statusFrame.status = status;
        [self.statusFrame addObject:statusFrame];
    }

    [_tableview reloadData];
    // Do any additional setup after loading the view.
}
#pragma mark - ------ Table view data source ------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return self.statusFrame.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZTStatusCell *cell = [ZTStatusCell statusCell:tableView indexPath:indexPath];
    ZTStatusFrame *statusFrame = self.statusFrame[indexPath.row];
    cell.statusFrame = statusFrame;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.statusFrame[indexPath.row] cellHeight];
}

#pragma mark - 懒加载
- (NSMutableArray *)statusFrame {
    if (!_statusFrame) {
        _statusFrame = [NSMutableArray array];
    }
    return _statusFrame;
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
