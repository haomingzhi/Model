//
//  PromoteTableViewCell.m
//  yinglingzhe
//
//  Created by LinFeng on 2016/10/20.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "PromoteTableViewCell.h"
#import "BUImageRes.h"
//#import <star\>

@implementation PromoteTableViewCell

- (void)awakeFromNib {
    // Initialization code
    //自定义tableView分割线
    UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 0.5)];
    [lineImageView setBackgroundColor:kUIColorFromRGB(color_5)];
    [self.contentView addSubview:lineImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)fitCellMode{
    
    
    //头像
    _headerImageView.frame = CGRectMake(15, 10, 37.5, 37.5);
    _headerImageView.layer.cornerRadius = 37.5/2.0;
    _headerImageView.layer.masksToBounds = YES;
    _headerImageView.contentMode = UIViewContentModeScaleToFill;
    
    float x,y,width,heigh;
    //用户昵称
    x = _headerImageView.frame.origin.x + _headerImageView.frame.size.width+10;
    y = 23;
    width = 200;
    heigh = 14;
    _nameLbl.frame = CGRectMake(x, y, width, heigh);
    _nameLbl.font = [UIFont systemFontOfSize:14.0];
    _nameLbl.textColor = kUIColorFromRGB(color_1);
//    _nameLbl.text = @"用户昵称";
    
    if (_starView == nil) {
        _starView = [[CWStarRateView alloc]initWithFrame:CGRectMake(_nameLbl.x+_nameLbl.width+10, _starView.y, 200, 30) numberOfStars:5];
        [self.contentView addSubview:_starView];
    }
    
    
    //点赞数
//    _goodNumLbl.text = @"110";
    UIFont *font = [UIFont systemFontOfSize:12.0];
    CGSize maxSize = CGSizeMake(100, 12);
    CGSize size = [_goodNumLbl.text size:font constrainedToSize:maxSize];
    x = __SCREEN_SIZE.width-25-size.width;
    y = 22;
    width = size.width;
    heigh = size.height;
    _goodNumLbl.frame = CGRectMake(x, y, width, heigh);
//    _goodNumLbl.textColor = kUIColorFromRGB(color_3);
    [_goodNumLbl setFont:font];
    
    //点赞图标
//    y = 21;
//    x = _goodNumLbl.frame.origin.x-10-15;
//    width = 15;
//    heigh = 15;
//    _goodImageView.frame = CGRectMake(x,y, width, heigh);
//    _goodImageView.contentMode = UIViewContentModeScaleToFill;
    _goodImageView.hidden = YES;
    
    //讨论内容
//    _contetLbl.text = @"在家一定要冷静冷静冷静,在家一定要冷静冷静冷静,在家一定要冷静冷静冷静,在家一定要冷静冷静冷静,";
    maxSize = CGSizeMake(__SCREEN_SIZE.width-63-15, __SCREEN_SIZE.height);
    font = [UIFont systemFontOfSize:12];
    size = [_contetLbl.text size:font constrainedToSize:maxSize];
    x = 63;
    y = _nameLbl.frame.origin.y+_nameLbl.frame.size.height+12;
    width = size.width;
    heigh = size.height;
    _contetLbl.frame = CGRectMake(x,y, width, heigh);
    _contetLbl.textColor = kUIColorFromRGB(color_8);
    _contetLbl.numberOfLines = 0;
    [_contetLbl setFont:font];
    _cellHeight = 49+size.height;
    
}


-(void)setCellData:(NSDictionary *)dataDic{
    _contetLbl.text = dataDic[@"content"];
    _goodNumLbl.text = dataDic[@"like"];
    if ([_goodNumLbl.text intValue] == 0) {
        [_goodImageView setImage:[UIImage imageNamed:@"icon_zang_nor"]];
        [_goodNumLbl setTextColor:kUIColorFromRGB(color_6)];
    }else{
        [_goodImageView setImage:[UIImage imageNamed:@"icon_zang_sel"]];
        [_goodNumLbl setTextColor:kUIColorFromRGB(color_3)];

    }
    NSString *name = dataDic[@"name"];
    _headerImageView.image = [UIImage imageNamed:@"defaultHead"];
    BUImageRes *imgR = dataDic[@"headImage"];
    int type = [dataDic[@"type"] intValue];
    if (type == 1) {
        NSString *str1 = [name substringToIndex:3];
        NSString *str2 = [name substringFromIndex:7];
        name = [NSString stringWithFormat:@"%@****%@",str1,str2];
    }
    
    _nameLbl.text = name;
    
    if (imgR.isCached) {
        UIImage *im =  [UIImage imageWithContentsOfFile:imgR.cacheFile];
        if (im) {
            _headerImageView.image = im;
        }
        
    }else{
        [imgR download:self callback:@selector(resDownloadNotification:) extraInfo:@{@"imageView":_headerImageView}];
    }
    
}

-(void) resDownloadNotification:(BSNotification *) noti
{
    if (noti.error.code ==0) {
        BURes *res = (BURes *) noti.target;
        UIImageView * imageView = (UIImageView *)[ noti.extraInfo objectForKey:@"imageView"];
        imageView.image = [UIImage imageWithContentsOfFile:res.cacheFile];
    }
}


@end
