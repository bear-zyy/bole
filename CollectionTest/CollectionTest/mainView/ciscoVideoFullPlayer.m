//
//  ciscoVideoFullPlayer.m
//  CollectionTest
//
//  Created by zyy on 2017/10/16.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "ciscoVideoFullPlayer.h"

static void *PlayViewStatusObservationContext = &PlayViewStatusObservationContext;

@interface ciscoVideoFullPlayer ()

@property(nonatomic,assign) UIInterfaceOrientation orientationType;

@property(nonatomic,strong)UITapGestureRecognizer * singleTap;

@end

@implementation ciscoVideoFullPlayer

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self.sliderProgress setThumbImage:[UIImage imageNamed:@"sike_icon_prograssbar"] forState:UIControlStateNormal];
    
    [self createNoti];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    self.orientationType = orientation;
    
    self.topView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
    self.bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
    
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    self.singleTap.numberOfTapsRequired = 1; // 单击
    self.singleTap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:self.singleTap];
}

- (IBAction)playOrPuse:(id)sender {
    
    self.playOrPauseBut.selected = !self.playOrPauseBut.selected;
    
    self.fullPlayOrPauseBlocl(self.playOrPauseBut.selected);
    
}

-(void)handleSingleTap:(UITapGestureRecognizer*)tap{

    [UIView animateWithDuration:0.5 animations:^{
        if (self.bottomView.alpha == 0.0) {
            [self showControlView];
        }else{
            [self hiddenControlView];
        }
    } completion:^(BOOL finish){
        
    }];
    
}

-(void)showControlView{

    self.bottomView.alpha = 1.0;
    self.topView.alpha = 1.0;
}

-(void)hiddenControlView{
    self.bottomView.alpha = 0.0;
    self.topView.alpha = 0.0;
    
}

-(void)createNoti{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
}

-(void)statusBarOrientationChange:(NSNotification *)noti{

    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    self.orientationType = orientation;
}

- (IBAction)backViewClick:(id)sender {
    
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    
    self.backFullVideoBlock();
    
}

- (IBAction)LandscapeOrPortrait:(id)sender {
    
    if (self.orientationType == UIInterfaceOrientationPortrait) {
        NSLog(@"UIInterfaceOrientationPortrait");
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    }
    else if (self.orientationType == UIInterfaceOrientationLandscapeLeft || self.orientationType == UIInterfaceOrientationLandscapeRight){
        NSLog(@"UIInterfaceOrientationLandscapeRight");
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    }
}
- (IBAction)fastVideo15Second:(id)sender {
    
    self.videoFastOrBack(YES);
    
}

- (IBAction)backVideo15Second:(id)sender {
    
    self.videoFastOrBack(NO);
    
}

@end
