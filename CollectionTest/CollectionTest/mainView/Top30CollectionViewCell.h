//
//  Top30CollectionViewCell.h
//  Career
//
//  Created by souzhiyun Mr_Liu on 2017/5/3.
//  Copyright © 2017年 souzhiyun_lyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Top30CollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UILabel * label;

@property (strong , nonatomic) NSString * title;

/**label的背景为灰色:首页为灰色，搜索点击进入的页面为透明色*/

@end
