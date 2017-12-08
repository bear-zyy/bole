//
//  CISCOVideoCell.m
//  Bole
//
//  Created by zyy on 2017/10/16.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "CISCOVideoCell.h"
#import "Masonry.h"
@interface CISCOVideoCell ()

@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property(nonatomic,strong)UITapGestureRecognizer * singleTap;

@end

@implementation CISCOVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    [self.backGroundView addSubview:self.player];
    
//    [self.player mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.edges.equalTo(self.backGroundView);
//        
//    }];
//    
//    self.player.hidden = YES;
//    
//    [self.backGroundView sendSubviewToBack:self.player];
    
    self.operationDownView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
    
    [self.sliderView setThumbImage:[UIImage imageNamed:@"sike_icon_prograssbar"] forState:UIControlStateNormal];
    
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    self.singleTap.numberOfTapsRequired = 1; // 单击
    self.singleTap.numberOfTouchesRequired = 1;
    [self.contentView addGestureRecognizer:self.singleTap];
    
    self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //    UIActivityIndicatorViewStyleWhiteLarge 的尺寸是（37，37）
    //    UIActivityIndicatorViewStyleWhite 的尺寸是（22，22）
    [self.contentView addSubview:self.loadingView];
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.backGroundView);
    }];
    self.failLabel.hidden = YES;
    
    // Initialization code
}

-(void)setDict:(NSDictionary *)dict{

    UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [self.backImageView addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.backImageView);
    }];
    
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [playBtn addTarget:self action:@selector(playclick:) forControlEvents:UIControlEventTouchUpInside];
    [playBtn setBackgroundImage:[UIImage imageNamed:@"sike_icon_stop"] forState:UIControlStateNormal];
    
//    self.showImageView.userInteractionEnabled = YES;
//    
//    self.showImageView.backgroundColor = [UIColor blackColor];
//    
//    self.showImageView.image = nil;
//    
//
    self.backImageView.userInteractionEnabled = YES;
    [self.backImageView addSubview:playBtn];
    
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.backImageView);
        
    }];
    
    self.operationDownView.hidden = YES;
    
    
    
//    self.player.URLString = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
//    
//    self.player.hidden = NO;
    
}

-(void)playclick:(UIButton*)but{

//    self.fullBlock();
    
    self.ciscoVideoBlock(nil);
    
//    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        
//        self.backImageView.alpha = 0;
//        
//        self.player.hidden = NO;
//        
//        
//    } completion:^(BOOL finished) {
//        
//        [self.player play];
//        
//    }];
}

-(void)aaa{

}

- (IBAction)playOrPause:(id)sender {
    
    self.playOrPuseuBut.selected = !self.playOrPuseuBut.selected;
    
    self.playOrPause(self.playOrPuseuBut.selected);
    
}

- (IBAction)fullVideoClick:(id)sender {
    
    self.fullBlock();
}

-(void)handleSingleTap:(UITapGestureRecognizer *)tap{

    [UIView animateWithDuration:0.5 animations:^{
        if (self.operationDownView.alpha == 0.0) {
            [self showControlView];
        }else{
            [self hiddenControlView];
        }
    } completion:^(BOOL finish){
        
    }];
    
}

-(void)showControlView{
    self.operationDownView.alpha = 1.0;
}

-(void)hiddenControlView{
    self.operationDownView.alpha = 0.0;
}

#pragma mark 代理
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
