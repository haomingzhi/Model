//
//  UIButton+Pop.m
//  MeiliWan
//
//  Created by ORANLLC_IOS1 on 15/4/30.
//  Copyright (c) 2015年 oranllc. All rights reserved.
//

#import "UIButton+Pop.h"
#import <objc/runtime.h>

@implementation UIButton (Pop)

static NSArray *mypops;

-(NSArray *) popArray
{
    return objc_getAssociatedObject(self, &mypops);
}

-(void) setPopArray:(NSArray *)popArray
{
    objc_setAssociatedObject(self, &mypops, popArray, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void) setPopAttribute:(NSArray *)popArray completed:(void(^)(NSInteger selected))completed
{
    self.popArray = popArray;
    [self addTarget:self action:@selector(handleSelect:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void) handleSelect:(id)sender
{
    NSString *selectedItem = [self titleForState:UIControlStateNormal];
    NSInteger index = [self.popArray indexOfObject:selectedItem];
    index = index == NSNotFound ? 0 : index;
    MyPopoverController *myPop =[MyPopoverController popoverWithArray:self.popArray selectedIndex:index];
    [myPop setContentSize:CGSizeMake(self.frame.size.width, self.popArray.count *50 > 250 ? 250 : self.popArray.count *50)];
    [myPop showUnderView:self offset:CGPointZero completed:^(NSInteger select){
        
        if (select != NSNotFound)
        {
            NSString *buttonTitle = [NSString stringWithFormat:@"%@",[self.popArray objectAtIndex:select]];
            CGSize size = [buttonTitle size:self.titleLabel.font constrainedToSize:CGSizeMake(self.frame.size.width, 2000)];//计算显示需要的高度于宽度
            self.imageEdgeInsets = UIEdgeInsetsMake(0, size.width +120, 0, 0);
            [self setTitle:buttonTitle forState:UIControlStateNormal];
            
        }
        
    }];
}
@end
