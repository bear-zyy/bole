//
//  ZYYScrolMainlVC.m
//  scrollVC
//
//  Created by zyy on 2017/12/15.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "ZYYScrolMainlVC.h"
#import "ZYYTitleView.h"
#import "ZYYScrollVCCell.h"
#import "ZYYSubVC.h"

@interface ZYYScrolMainlVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate,ZYYTitleDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property(nonatomic,strong) ZYYTitleView * titleView;


@end

@implementation ZYYScrolMainlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTopView];
    
    [self createCollectionView];
    
    [self initSubVC];
    // Do any additional asetup after loading the view.
}

-(void)createTopView{
    
    //要求   第一只需要输入参数  和frame  然后有代理点击时间，有属性设置index
    //
    self.titleView = [[ZYYTitleView alloc] initWithFrame:CGRectMake(0, 0, 375, 45)];
    [self.view addSubview:self.titleView];
    self.titleView.lineType = equalSpace;
    self.titleView.backColor = [UIColor grayColor];
    self.titleView.titleSelectColor = [UIColor redColor];
    self.titleView.downIndexLineSelectColor = [UIColor blueColor];
    self.titleView.titleNormalColor = [UIColor orangeColor];
    self.titleView.downIndexLineNormalColor = [UIColor blackColor];
    self.titleView.titleFont = 15;
    self.titleView.titleArray = @[@"你",@"我",@"他"];
    self.titleView.delegate = self;
}

-(void)createCollectionView{
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView.backgroundColor = [UIColor whiteColor];
    // cell size
    CGFloat screenW = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenH = [[UIScreen mainScreen] bounds].size.height;
    flowLayout.itemSize = CGSizeMake(screenW, screenH - 45);
    [self.view addSubview:_collectionView];
    _collectionView.frame = CGRectMake(0, 45, screenW, screenH - 45);
    [_collectionView registerClass:[ZYYScrollVCCell class] forCellWithReuseIdentifier:@"ZYYScrollVCCell"];
    
}

-(void)initSubVC{
    
    self.dataArray = [NSMutableArray array];
    
    for (int i=0; i< 3; i++) {
        
        ZYYSubVC * subVC = [ZYYSubVC new];
        [self.dataArray addObject:subVC];
        if (i == 0) {
            subVC.backColor = [UIColor grayColor];
        }
        else if (i == 1){
            subVC.backColor = [UIColor lightGrayColor];
            
        }
        else if (i == 2){
            subVC.backColor = [UIColor darkGrayColor];
            
        }
    }
    
    [_collectionView reloadData];
    
}

-(void)zyyTitleViewSelcetTitleIndex:(NSInteger)index{

    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ZYYScrollVCCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZYYScrollVCCell" forIndexPath:indexPath];
    cell.subVC = self.dataArray[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    
    self.titleView.titleIndex = index;
    
}


@end
