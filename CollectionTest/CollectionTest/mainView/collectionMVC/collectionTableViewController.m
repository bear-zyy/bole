//
//  collectionTableViewController.m
//  CollectionTest
//
//  Created by zyy on 2017/10/26.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "collectionTableViewController.h"

@interface collectionTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIScrollView * scrollView;

@property(nonatomic,strong) UITableView * leftTableView;

@property(nonatomic,strong) UITableView * centerTableView;

@property(nonatomic,strong) UITableView * rightTableView;

@property(nonatomic,strong) NSArray * dataSource;

@property(nonatomic,assign) NSInteger scrollP;

@property(nonatomic,assign) NSInteger leftP;
@property(nonatomic,assign) NSInteger centerP;
@property(nonatomic,assign) NSInteger rightP;

@end

@implementation collectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollP = 0;
    [self createNavView];
    
    [self createScrollV];
    
    // Do any additional setup after loading the view.
}

-(void)createScrollV{

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * self.dataSource.count, self.view.frame.size.height - 64);
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    [self createTableV];
    
    
}

-(void)createTableV{
   
    [self.scrollView addSubview:self.leftTableView];
    [self.scrollView addSubview:self.centerTableView];
    [self.scrollView addSubview:self.rightTableView];

}

-(UITableView *)leftTableView{

    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        
    }
    return _leftTableView;
}

-(UITableView *)centerTableView{

    if (!_centerTableView) {
        _centerTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        _centerTableView.delegate = self;
        _centerTableView.dataSource = self;
        
    }
    return _centerTableView;
    
}

-(UITableView *)rightTableView{
    
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 2, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        
    }
    return _rightTableView;
    
}

-(void)createNavView{

    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    view.frame = CGRectMake(0, 0, self.view.frame.size.width, 64);
    NSArray * navNameArr = @[@"要闻",@"十九大",@"体育",@"军事",@"足球",@"推荐",@"哈哈哈"];
    for (int i=0; i< navNameArr.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:navNameArr[i] forState:UIControlStateNormal];
        button.frame = CGRectMake(i * 50 + 10, 20, 50, 44);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
    
    self.dataSource = @[@[@"1aaa",@"bbb",@"ccc",@"ddd"]
                        ,@[@"2eee",@"fff",@"ggg",@"hhh"]
                        ,@[@"3iii",@"ggg",@"kkk",@"lll"]
                        ,@[@"4mmm",@"nnn",@"ooo",@"ppp"]
                        ,@[@"5qqq",@"rrr",@"sss",@"kkk"]
                        ,@[@"6uuu",@"vvv",@"www",@"xxx"]
                        ,@[@"7yyy",@"zzz",@"aaa",@"bbb"]];
    
    _leftP = 0;
    _centerP = 1;
    _rightP = 2;
}

-(void)buttonClick:(UIButton *)but{

    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView == self.leftTableView) {
        return [self.dataSource[self.leftP] count];
    }
    else if (tableView == self.centerTableView){
        return [self.dataSource[self.centerP] count];
    }
    else if (tableView == self.rightTableView){
        return [self.dataSource[self.rightP] count];
        
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    
    if (tableView == self.leftTableView) {
    
        cell.textLabel.text = self.dataSource[self.leftP][indexPath.row];
    }
    else if (tableView == self.centerTableView){
        cell.textLabel.text = self.dataSource[self.centerP][indexPath.row];
        
    }
    else if (tableView == self.rightTableView){
        cell.textLabel.text = self.dataSource[self.rightP][indexPath.row];
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44.0;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    float x = scrollView.contentOffset.x;
    
    self.scrollP = x / self.view.frame.size.width;
    
    if (self.scrollP == 0) {//第一个
        
        
    }
    else if (self.scrollP == self.dataSource.count - 1){//最后一个
    
        
    }
    else{
    
        if (self.leftTableView.frame.origin.x < scrollView.contentOffset.x - self.view.frame.size.width || self.leftTableView.frame.origin.x > scrollView.contentOffset.x + self.view.frame.size.width) {
            if (self.leftTableView.frame.origin.x < scrollView.contentOffset.x - self.view.frame.size.width) {
                self.leftTableView.frame = CGRectMake(scrollView.contentOffset.x + self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height - 64);
                self.leftP = self.scrollP + 1;
            }
            else{
            self.leftTableView.frame = CGRectMake(scrollView.contentOffset.x - self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height - 64);
                self.leftP = self.scrollP - 1;
            }
            
            [self.leftTableView reloadData];
        }
        else if (self.centerTableView.frame.origin.x < scrollView.contentOffset.x - self.view.frame.size.width || self.centerTableView.frame.origin.x > scrollView.contentOffset.x + self.view.frame.size.width){
            if (self.centerTableView.frame.origin.x < scrollView.contentOffset.x - self.view.frame.size.width) {
                self.centerTableView.frame = CGRectMake(scrollView.contentOffset.x + self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height - 64);
                self.centerP = self.scrollP + 1;
            }
            else{
                self.centerTableView.frame = CGRectMake(scrollView.contentOffset.x - self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height - 64);
                self.centerP = self.scrollP - 1;
            }
            [self.centerTableView reloadData];
        }
        else if (self.rightTableView.frame.origin.x < scrollView.contentOffset.x - self.view.frame.size.width || self.rightTableView.frame.origin.x > scrollView.contentOffset.x + self.view.frame.size.width){
            if (self.rightTableView.frame.origin.x < scrollView.contentOffset.x - self.view.frame.size.width) {
                self.rightTableView.frame = CGRectMake(scrollView.contentOffset.x + self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height - 64);
                self.rightP = self.scrollP + 1;
            }
            else{
                self.rightTableView.frame = CGRectMake(scrollView.contentOffset.x - self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height - 64);
                self.rightP = self.scrollP - 1;
            }
            [self.rightTableView reloadData];
        }
        else{
        
        }
        
    }
    
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
