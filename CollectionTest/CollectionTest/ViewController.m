//
//  ViewController.m
//  CollectionTest
//
//  Created by zyy on 2017/7/26.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "ViewController.h"
#import "Top30CollectionViewCell.h"
#import "FlowLayout.h"
#import "CollectionViewController.h"
#import "tableViewController.h"
#import "PYSearchViewController.h"
#import "UIViewControllerVideo.h"
#import "collectionTableViewController.h"
@interface ViewController ()<UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate,PYSearchViewControllerDelegate>
{

    UICollectionView * _collectionView;
    
    NSMutableArray * _dataSource;
    
}

//@property (strong, nonatomic) UICollectionViewFlowLayout *layout;

@property(nonatomic,strong)UISearchBar *searchBar1;

@property (strong, nonatomic) FlowLayout *layout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    _searchBar1=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width-40, 30)];
    _searchBar1.placeholder=@"关键字搜索圈子";
    _searchBar1.backgroundImage=[UIImage new];
    _searchBar1.layer.masksToBounds=YES;
    _searchBar1.layer.cornerRadius=15;
    _searchBar1.delegate=self;
    _searchBar1.tintColor=[UIColor lightGrayColor];
    _searchBar1.barTintColor=[UIColor whiteColor];
    [self configeSearchBar:_searchBar1];
    
    [self.view addSubview:_searchBar1];
    
    _dataSource = [NSMutableArray array];
    
    self.layout = [[FlowLayout alloc] init];
    self.layout.alignment = FlowAlignmentLeft;
//    self.layout.alignment = FlowAlignmentLeft;
    self.layout.estimatedItemSize = CGSizeMake(100, 30);
    self.layout.sectionInset = UIEdgeInsetsMake(0, 15, 10, 10);
    self.layout.minimumLineSpacing=10;
    self.layout.minimumInteritemSpacing=10;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:self.layout];
    _collectionView.showsVerticalScrollIndicator=NO;
    _collectionView.scrollEnabled=NO;
    
    _collectionView.backgroundColor=[UIColor whiteColor];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.userInteractionEnabled=YES;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[Top30CollectionViewCell class] forCellWithReuseIdentifier:@"Top30CollectionViewCell"];
    
    _dataSource = [NSMutableArray arrayWithArray:@[@"招聘",@"iOS开发工程师",@"手绘圈",@"职业圈",@"室内设计",@"Java",@"建筑师",@"产品经理圈"]];
    
    [_collectionView reloadData];
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(clickvideo) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitle:@"clickvideo" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 300, 100, 100);
    [self.view addSubview:button];
    
    UIButton * buttontable= [UIButton buttonWithType:UIButtonTypeCustom];
    [buttontable addTarget:self action:@selector(clicktable) forControlEvents:UIControlEventTouchUpInside];
    [buttontable setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buttontable setTitle:@"click" forState:UIControlStateNormal];
    buttontable.frame = CGRectMake(200, 300, 100, 100);
    [self.view addSubview:buttontable];

    
    UIButton * searchtable= [UIButton buttonWithType:UIButtonTypeCustom];
    [searchtable addTarget:self action:@selector(searchclick) forControlEvents:UIControlEventTouchUpInside];
    [searchtable setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [searchtable setTitle:@"search" forState:UIControlStateNormal];
    searchtable.frame = CGRectMake(200, 400, 100, 100);
    [self.view addSubview:searchtable];
    
    
    UIButton * collectiontable= [UIButton buttonWithType:UIButtonTypeCustom];
    [collectiontable addTarget:self action:@selector(collectionclick) forControlEvents:UIControlEventTouchUpInside];
    [collectiontable setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [collectiontable setTitle:@"collectiontable" forState:UIControlStateNormal];
    collectiontable.frame = CGRectMake(100, 400, 100, 100);
    [self.view addSubview:collectiontable];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)collectionclick{

    collectionTableViewController * vc = [[collectionTableViewController alloc] init];
    
    [self presentViewController:vc animated:YES completion:nil];
    
}

-(void)searchclick{

    NSArray *hotSeaches = @[@"阅读圈", @"产品经理", @"人力资源", @"iOS开发", @"美食", @"旅行", @"新媒体圈", @"极限运动圈",@"人力资源", @"iOS开发", @"美食", @"旅行", @"新媒体圈", @"极限运动圈"];
    // 2. Create a search view controller
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"关键字搜索圈子话题" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // Called when search begain.
        // eg：Push to a temp view controller
//        [searchViewController.navigationController pushViewController:[[PYTempViewController alloc] init] animated:YES];
    }];
    // 3. Set style for popular search and search history
//    if (0 == indexPath.section) {
        searchViewController.hotSearchStyle = 3;
        searchViewController.searchHistoryStyle = PYHotSearchStyleDefault;
//    } else {
//        searchViewController.hotSearchStyle = PYHotSearchStyleDefault;
//        searchViewController.searchHistoryStyle = (NSInteger)indexPath.row;
//    }
    // 4. Set delegate
    searchViewController.delegate = self;
    // 5. Present a navigation controller
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:searchViewController animated:YES completion:nil];
    
}

-(void)clicktable{

    [self presentViewController:[[tableViewController alloc] init] animated:YES completion:nil];
    
}

-(void)clickvideo{

    [self presentViewController:[[UIViewControllerVideo alloc] init] animated:NO completion:nil];
    
//    [self presentViewController:[[CollectionViewController alloc] init] animated:YES completion:nil];
    
}

- (void)configeSearchBar:(UISearchBar *)searchBar{
    
    searchBar.frame = CGRectMake(0, 64, self.view.frame.size.width-40, 44);
    
    UITextField *searchField = [searchBar valueForKey:@"_searchField"];
    
//    NSLog(@"%@",searchField);
//
    
    [searchBar setImage:[UIImage imageNamed:@"label_delete.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
//    if (searchField) {
//        [searchField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
//        [searchField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];

//    UIButton * but = (UIButton*)searchField.subviews[1];
////    [searchField setValue:[UIImage imageNamed:@""] forKey:@""];
//    [but setImage:[UIImage imageNamed:@"label_delete.png"] forState:UIControlStateNormal];
    
//    }
    
    for (UIView *vw in [searchBar.subviews[0] subviews]) {
        
        if ([vw isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            UITextField *view = (UITextField *)vw;
            view.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
            NSLog(@"%@",view);
            
//            view.attributedPlaceholder =
//            NSMutableAttributedString * attr = [[NSMutableAttributedString alloc] init];
//            [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, 3)];
//            [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
//            view.attributedPlaceholder = attr;
            
//            [view setValue:[UIColor redColor] forKeyPath:@"placeholderLabel.textColor"];
//            [view setValue:[UIFont systemFontOfSize:10] forKeyPath:@"_placeholderLabel.font"];
            
//            for (UIView * sub in view.subviews) {
//                if ([sub isKindOfClass:NSClassFromString(@"UISearchBarTextFieldLabel")]) {
//                    UILabel * label = (UILabel *)sub;
//                    label.font = [UIFont systemFontOfSize:10];
//                    label.textColor = [UIColor redColor];
//                }
//            }
        }
    }
    
    // 去除边框黑线
    searchBar.layer.borderWidth = 1;
    searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    [searchBar layoutIfNeeded];
}

#pragma mark - ---------- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *model = _dataSource[indexPath.row];
    
    //method 1
    //    CGSize boundSize = CGSizeMake(CGFLOAT_MAX, 25);
    //    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:11]};
    //    CGRect requiredRect = [model.position boundingRectWithSize:boundSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:attr context:nil];
    //    CGSize size = requiredRect.size;
    //    size.height = 25;
    //    size.width += 10;
    
    //method 2
    CGFloat width1= [self widthOfString:model font:[UIFont systemFontOfSize:11] height:30];
    CGSize size=CGSizeMake(width1, 30);
    
    return size;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _dataSource.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Top30CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Top30CollectionViewCell" forIndexPath:indexPath];
    
    NSString * string =_dataSource[indexPath.row];
    
    cell.title = string;
    
//    cell.backgroundColor = [UIColor redColor];
    
    CGFloat width1= [self widthOfString:string font:[UIFont systemFontOfSize:11] height:30];
    cell.label.frame=CGRectIntegral( CGRectMake(0, 0, width1, 30));
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"%@", _dataSource[indexPath.row]);
    
}

-(CGFloat)widthOfString:(NSString *)string font:(UIFont *)font height:(CGFloat)height
{
    NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
    CGRect rect=[string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.width+18;//18：label字左右空隙
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
