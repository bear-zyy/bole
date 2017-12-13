//
//  FileShowViewController.m
//  Bole
//
//  Created by zyy on 2017/9/21.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "FileShowViewController.h"
#import <QuickLook/QuickLook.h>
#import "AFNetworking.h"

@interface FileShowViewController ()<QLPreviewControllerDataSource,UIActionSheetDelegate,UIDocumentInteractionControllerDelegate>

@property(nonatomic,strong) QLPreviewController * previewVC;

@property(nonatomic,strong) NSURL * fileUrlStr;

@property(nonatomic,strong)UIDocumentInteractionController * documentInteractionController;

@end

@implementation FileShowViewController

-(NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    
    //读取沙盒中的文件
    
    return self.fileUrlStr;
    
}


-(void)loadFile{
    
    //1.创建会话管理者
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    
    NSURL *url = [NSURL URLWithString:self.fileUrlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //2.下载文件
    /*
     第一个参数:请求对象
     第二个参数:progress 进度回调 downloadProgress
     第三个参数:destination 回调(目标位置)
     有返回值
     targetPath:临时文件路径
     response:响应头信息
     第四个参数:completionHandler 下载完成之后的回调
     filePath:最终的文件路径
     */
    NSURLSessionDownloadTask *download = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        //监听下载进度
        //completedUnitCount 已经下载的数据大小
        //totalUnitCount     文件数据的中大小
        NSLog(@"%f",1.0 *downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        
        NSLog(@"targetPath:%@",targetPath);
        NSLog(@"fullPath:%@",fullPath);
        
        return [NSURL fileURLWithPath:fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        NSLog(@"下载成功 %@",filePath);
        
        self.fileUrlStr = filePath;
        
        self.previewVC = [[QLPreviewController alloc] init];
        self.previewVC.dataSource = self;
        //        [self presentViewController:self.previewVC animated:YES completion:nil];
        //        [self.navigationController pushViewController:self.previewVC animated:YES];
        [self addChildViewController:self.previewVC];
        self.previewVC.view.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
        [self.view addSubview:self.previewVC.view];

    }];
    [download resume];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBarButtonItems];
    
    [self loadFile];
    
    // Do any additional setup after loading the view.
}

#pragma mark - ---------- nav
- (void)addBarButtonItems
{
    
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
    [self.view addSubview:view];

    
    UIButton * moreBut = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBut.frame = CGRectMake(15, 20, 40, 20);
    [moreBut setTitle:@"更多" forState:UIControlStateNormal];
    moreBut.titleLabel.font = [UIFont systemFontOfSize:15];
    moreBut.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
    [moreBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [moreBut addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:moreBut];
    
    UILabel * label = [[UILabel alloc] init];
    label.text = self.fileName;
    label.font = [UIFont boldSystemFontOfSize:18];
    label.frame = CGRectMake(150, 20, 100, 30);
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
//    self.navigationController.navigationBar.backgroundColor = UIColorHex(0x3aced1);
    
}

-(void)moreClick{

//    UIActionSheet * action = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"用其他应用打开" otherButtonTitles:nil, nil];
    UIAlertController * controler = [[UIAlertController alloc] init];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"其他应用打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _documentInteractionController = [UIDocumentInteractionController
                                          interactionControllerWithURL:self.fileUrlStr];
        [_documentInteractionController setDelegate:self];
        [_documentInteractionController presentPreviewAnimated:YES];
        [_documentInteractionController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
        
    }];
    
    [controler addAction:action];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [controler addAction:cancel];
    [self presentViewController:controler animated:NO completion:nil];
    
//    [action showInView:self.view];
}

//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//
//    NSLog(@"%ld" , (long)buttonIndex);
//
//    if (buttonIndex == 1) {
//
//    }
//    else{
//        _documentInteractionController = [UIDocumentInteractionController
//                                          interactionControllerWithURL:self.fileUrlStr];
//        [_documentInteractionController setDelegate:self];
//        [_documentInteractionController presentPreviewAnimated:YES];
//        [_documentInteractionController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
//    }
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
