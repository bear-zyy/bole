//
//  tableCell.m
//  videoPlay
//
//  Created by zyy on 2017/12/25.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "tableCell.h"
#import "WMPlayer.h"
#import <Masonry.h>

@interface tableCell ()

@property(nonatomic,strong) WMPlayer * player;


@end

@implementation tableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView * view = [[UIView alloc] init];
        view.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(320, 200));
        }];
        
        [view addSubview:self.player];
        [self.player mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(view);
        }];
        
    }
    return self;
}

-(void)setStringUrl:(NSString *)stringUrl{
    
    self.player.URLString = stringUrl;
    
}

-(WMPlayer *)player{

    if (!_player) {
        _player = [[WMPlayer alloc] init];
    }
    return _player;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
