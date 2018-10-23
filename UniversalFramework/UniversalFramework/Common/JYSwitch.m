//
//  JYSwitch.m
//  com.meiliwan.emall.app
//
//  Created by air on 15/5/15.
//  Copyright (c) 2015年 air. All rights reserved.
//

#import "JYSwitch.h"

@implementation JYSwitch
{
    UIColor *_thumbTintColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    _thumbTintColor = self.thumbTintColor;
    if (self.on) {
        self.layer.borderColor = _thumbTintColor.CGColor;
    }
    else
    {
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 15.5;
    self.layer.masksToBounds = YES;
    
    [self addTarget:self action:@selector(changeStatus) forControlEvents:UIControlEventValueChanged];
}


-(void)changeStatus
{
  if(self.on)
  {
//          self.tintColor = [UIColor greenColor];
          // 定义ON状态下的颜色
          self.onTintColor = [UIColor whiteColor];
          // 定义圆形按钮的颜色
          self.thumbTintColor = _thumbTintColor;
       self.layer.borderColor = self.thumbTintColor.CGColor;
  }
    else
    {
        self.onTintColor = [UIColor whiteColor];
        // 定义圆形按钮的颜色
        self.thumbTintColor = [UIColor grayColor];
        self.layer.borderColor = self.thumbTintColor.CGColor;
    }
}
@end
