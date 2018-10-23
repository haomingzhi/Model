
//  GrayPageControl.m
//  deliciousfood
//
//  Created by air on 2017/2/25.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "GrayPageControl.h"

@implementation GrayPageControl
{
    
    UIImageView* activeImage;
    
    UIImageView* inactiveImage;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id) initWithFrame:(CGRect)frame

{
    
    self = [super initWithFrame:frame];
    
    
    activeImage = [UIImageView new];
    activeImage.width = 16;
    activeImage.height = 2;
    activeImage.backgroundColor = kUIColorFromRGB(color_0xeb4b31);
    activeImage.layer.cornerRadius = 1;
    activeImage.layer.masksToBounds = YES;
//    activeImage.layer.borderColor = kUIColorFromRGB(color_2).CGColor;
//    activeImage.layer.borderWidth = 0.5;
//    inactiveImage = [UIImage imageNamed:@"BluePoint.png"];
    inactiveImage = [UIImageView new];
    inactiveImage.width = 16;
    inactiveImage.height = 2;
    inactiveImage.backgroundColor = kUIColorFromRGB(color_0xb5b5b5);
    inactiveImage.layer.cornerRadius = 1;
    inactiveImage.layer.masksToBounds = YES;
     [self updateDots];
    return self;
    
}


-(void) updateDots

{
     CGFloat x = self.width/2.0 - ((15+16)*self.subviews.count-15)/2.0;
    for (int i=0; i<[self.subviews count]; i++) {
        
        UIImageView* dot = [self.subviews objectAtIndex:i];
        
        CGSize size;
        
        size.height = 2;     //自定义圆点的大小
        
        size.width = 16;      //自定义圆点的大小
         
        [dot setFrame:CGRectMake(x+31*i, 9, size.width, size.height)];
         NSLog(@"%f",dot.x);

        if (i==self.currentPage)
        {
//            dot.image = activeImage;
//            dot.width = 16;
//            dot.height = 2;
            dot.backgroundColor = kUIColorFromRGB(color_0xb5b5b5);
            dot.layer.cornerRadius = 1;
            dot.layer.masksToBounds = YES;
//            dot.layer.borderColor = kUIColorFromRGB(color_2).CGColor;
//             dot.layer.borderWidth = 0.0;
//            dot.layer.borderWidth = 0.5;
        }
        else
        {
//            dot.image = inactiveImage;
//            dot.width = 16;
//            dot.height = 2;
            dot.backgroundColor = kUIColorFromRGB(color_0xe4e3e3);
//             dot.layer.borderColor = kUIColorFromRGB(color_2).CGColor;
//             dot.layer.borderWidth = 0.0;
            dot.layer.cornerRadius = 1;
            dot.layer.masksToBounds = YES;
        }
    }
    
}

//-(void)drawRect:(CGRect)rect
//{
////     [super drawRect:rect];
//
//}

-(void)layoutSubviews
{
     [self updateDots];
//     self.backgroundColor = kUIColorFromRGB(color_2);
}

-(void) setCurrentPage:(NSInteger)page

{
    
    [super setCurrentPage:page];
    
    [self updateDots];
    
}
@end
