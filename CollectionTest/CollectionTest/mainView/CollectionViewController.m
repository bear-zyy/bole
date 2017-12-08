//
//  CollectionViewController.m
//  CollectionTest
//
//  Created by zyy on 2017/7/28.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "CollectionViewController.h"
#import "HomeCollectionCell.h"
@interface CollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray * _dataArray;
}
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.estimatedItemSize = CGSizeMake(120, 150);
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 10, 10);
    layout.minimumLineSpacing=10;
    layout.minimumInteritemSpacing=10;
    
    self.CollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 375, 600) collectionViewLayout:layout];
    [self.view addSubview:self.CollectionView];
    
    self.CollectionView.showsVerticalScrollIndicator=NO;
    self.CollectionView.scrollEnabled=NO;
    
    self.CollectionView.backgroundColor=[UIColor whiteColor];
    self.CollectionView.delegate=self;
    self.CollectionView.dataSource=self;
    self.CollectionView.userInteractionEnabled=YES;
    
    
    [self.CollectionView registerClass:[HomeCollectionCell class] forCellWithReuseIdentifier:@"HomeCollectionCell"];
    
    _dataArray = [NSMutableArray array];

    
    _dataArray = [NSMutableArray arrayWithArray:@[@"label_delete.png",@"label_delete.png",@"label_delete.png",@"label_delete.png"]];
    
    [self.CollectionView reloadData];
    
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionCell" forIndexPath:indexPath];
    
    cell.imageUrl = _dataArray[indexPath.row];
    
    return cell;
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
