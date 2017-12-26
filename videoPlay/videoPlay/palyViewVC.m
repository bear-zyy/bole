//
//  palyViewVC.m
//  videoPlay
//
//  Created by zyy on 2017/12/22.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "palyViewVC.h"
#import <Masonry.h>
#import "WMPlayer.h"
@interface palyViewVC ()

//@property(nonatomic,strong) ZYYPlayView * zyyPlayer;
@property(nonatomic,strong) WMPlayer * player;


@end

@implementation palyViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(320, 200));
    }];
    
//    [view addSubview:self.player];
//    [self.player mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.edges.mas_equalTo(view);
//    }];
//
//    //http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4
//    //http://video.rz158.com/cisio/testfiletest20171102.mp4
//    self.player.URLString = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
//
//    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"play" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [self.view addSubview:button];
//    button.frame = CGRectMake(100, 50, 100, 50);
//    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}

//-(void)click{
//
////
//    [self.player play];
//
//}
//
//-(WMPlayer *)player{
//
//    if (!_player) {
//        _player = [[WMPlayer alloc] init];
//    }
//    return _player;
//}

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
