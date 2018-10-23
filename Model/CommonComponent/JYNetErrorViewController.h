//
//  JYNetErrorViewController.h
//  chenxiaoer
//
//  Created by air on 16/3/31.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYNetErrorViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *tipLb;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *tipBtn;
@property (nonatomic,strong) IBOutlet UIImageView *imgV;
@property (strong, nonatomic) IBOutlet UILabel *labelNoData;
-(void)fitModeY:(CGFloat)y;
-(void)fitModeBY:(CGFloat)y;
-(void)fitModeY:(CGFloat)y withImgVWidth:(CGFloat)w;
-(void)fitMode;
@property (strong, nonatomic) NSString *tip;
@end
