//
//  MenuOneBtnView.m
//  oranllcshoping
//
//  Created by air on 2017/7/28.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "MenuOneBtnView.h"

@implementation MenuOneBtnView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init
{
   return  [self initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 49)];
}

-(id)initWithFrame:(CGRect)frame
{
     self = [super initWithFrame:frame];
     self.btn = [UIButton new];
     self.btn.width = 80;
     self.btn.height = 30;
     self.btn.x = 15;
     self.btn.y = self.height/2.0 - self.btn.height/2.0;
     [self addSubview:self.btn];
   
         UILabel *lb = [UILabel new];
          lb.width = __SCREEN_SIZE.width;
          lb.height = 0.5;
     lb.backgroundColor = kUIColorFromRGB(color_lineColor);
     
     lb.x = 0;
     lb.y = self.height - 0.5;
     [self addSubview:lb];
     self.lineLb = lb;
     self.backgroundColor = kUIColorFromRGB(color_2);
     return self;
}

-(void)fitMode:(BOOL)isEdit
{
     if (isEdit) {
          self.btn.customImgV.hidden = NO;
          self.btn.customTitleLb.x = 47;
     }
     else
     {
          self.btn.customImgV.hidden = YES;
          self.btn.customTitleLb.x = 15;
     }
}
@end
