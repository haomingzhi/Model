//
//  UILabel+Autosize.m
//  ZhongGengGroup
//  通过计算text值，自动变大
//  Created by luolc's macBook air on 15/4/12.


#import "UILabel+Autosize.h"

@implementation UILabel (Autosize)

-(NSInteger)autoRelayout
{
    return [self autoRelayout:CGSizeMake(self.frame.size.width, MAXFLOAT)];
}

-(void) autoRelayout_width    //单行
{
     [self autoRelayout:CGSizeMake(MAXFLOAT,self.frame.size.height)];
}
-(NSInteger)autoRelayout:(CGSize) maxSize;
{
    if (self.text.length ==0) {
        return 0;
    }
    //self.lineBreakMode = NSLineBreakByWordWrapping;
    self.numberOfLines = 0;
    CGRect orgRect=self.frame;
    CGSize size = [self.text size:self.font constrainedToSize:CGSizeMake(maxSize.width,maxSize.height) ];
    NSInteger result = size.height - orgRect.size.height;
    orgRect.size.width = size.width+10;
    orgRect.size.height = size.height > maxSize.height +10 ? maxSize.height : size.height;
    self.frame = orgRect;
    return result;
}

-(void) topAlign:(NSInteger) maxLine text:(NSString *)text;
{
    self.text = text;
    CGSize labelSize = [self.text size:self.font constrainedToSize:CGSizeMake(self.frame.size.width, MAXFLOAT)];
    CGSize s = [@"高" size:self.font constrainedToSize:CGSizeMake(self.frame.size.width, MAXFLOAT)];
    while (labelSize.height < s.height * maxLine)
    {
        self.text =  [NSString stringWithFormat:@"%@\r\n ",self.text ];
        labelSize = [self.text size:self.font constrainedToSize:CGSizeMake(self.frame.size.width, MAXFLOAT)];
    }
}
@end
