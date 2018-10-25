//
//  DDTextView.h
//  NIM
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDTextView : UIView
@property(nonatomic,strong)void (^textChangeCallBack)(NSDictionary *dic);
@property(nonatomic,assign)NSInteger limitCount;
@property(nonatomic,assign)BOOL isHiddenLimt;
@property(nonatomic,strong)UILabel *placeholderLb;
@property(nonatomic,strong)NSString *text;
@end
