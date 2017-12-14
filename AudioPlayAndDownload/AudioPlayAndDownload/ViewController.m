//
//  ViewController.m
//  AudioPlayAndDownload
//
//  Created by zyy on 2017/12/13.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "ViewController.h"
#import "DownloadSongManager.h"
#import "AudioModel.h"
#import "FMDBHelper.h"
#import "PlayManager.h"

@interface ViewController ()

@property(nonatomic,strong) UIButton * downLoadBut;

@property(nonatomic,strong) UIButton * palyBut;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.downLoadBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.downLoadBut setTitle:@"download" forState:UIControlStateNormal];
    [self.downLoadBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:self.downLoadBut];
    self.downLoadBut.frame = CGRectMake(100, 50, 100, 50);
    [self.downLoadBut addTarget:self action:@selector(downloadClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.palyBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.palyBut setTitle:@"play" forState:UIControlStateNormal];
    [self.palyBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:self.palyBut];
    self.palyBut.frame = CGRectMake(200, 50, 100, 50);
    [self.palyBut addTarget:self action:@selector(playMethod) forControlEvents:UIControlEventTouchUpInside];
    self.palyBut.hidden = NO;
    if (![FMDBHelper querySongWith:@""]) {
        self.palyBut.hidden = YES;
    }
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)downloadClick{
    
    __weak typeof(self) weakself = self;
    
    AudioModel * audioModel = [[AudioModel alloc] init];
    audioModel.audioUrl = @"http://video.rz158.com/201711/28/04/2017112804bdf1c7b01c084111b406973da0d01189.mp3";
    [[DownloadSongManager sharedManager] downloadAudioWithAudioModel:audioModel success:^(BOOL isSuccess) {
      
        if (isSuccess) {
            [weakself.downLoadBut setTitle:@"下载完成" forState:UIControlStateNormal];
            weakself.downLoadBut.userInteractionEnabled = NO;
            weakself.palyBut.hidden = NO;
        }
        
    } withProgress:^(CGFloat proStr) {
        
        [weakself.downLoadBut setTitle:[NSString stringWithFormat:@"%.f",proStr] forState:UIControlStateNormal];
        weakself.downLoadBut.userInteractionEnabled = NO;
        
    }];
}

-(void)playMethod{
    
    AudioModel * model = [FMDBHelper querySongWith:@""];
    
    [[PlayManager sharedInstance] playWithModel:model];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
