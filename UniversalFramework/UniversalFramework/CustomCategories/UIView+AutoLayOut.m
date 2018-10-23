//
//  UIView+AutoLayOut.m
//  UniversalFramework
//
//  Created by air on 15/8/27.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "UIView+AutoLayOut.h"

@implementation UIView (AutoLayOut)
-(void)alignViewCenterWithLeftView:(UIView *)v1 right:(UIView*)v2
{
    UIView *parentView = self;
    [v2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [v1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *sizeConstraint =[NSLayoutConstraint constraintWithItem:v2 attribute:NSLayoutAttributeWidth relatedBy: NSLayoutRelationEqual
                                                                        toItem:nil attribute:NSLayoutAttributeNotAnAttribute  multiplier:0.0f constant:15];
    NSLayoutConstraint *sizeConstraint2 =[NSLayoutConstraint constraintWithItem:v2 attribute:NSLayoutAttributeHeight relatedBy: NSLayoutRelationEqual
                                                                         toItem:nil attribute:NSLayoutAttributeNotAnAttribute  multiplier:0.0f constant:15];
    [v2 addConstraint:sizeConstraint];
    [v2 addConstraint:sizeConstraint2];
    
    NSLayoutConstraint *vconstraint = [NSLayoutConstraint constraintWithItem:v2 attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual toItem:parentView
                                                                   attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f];
    [parentView addConstraint:vconstraint];
    NSLayoutConstraint *hconstraint = [NSLayoutConstraint constraintWithItem:v2 attribute:NSLayoutAttributeLeft
                                                                   relatedBy:NSLayoutRelationEqual toItem:v1
                                                                   attribute:NSLayoutAttributeRight multiplier:1.0f constant:4];
    [parentView addConstraint:hconstraint];
    NSLayoutConstraint *hconstraint2 = [NSLayoutConstraint constraintWithItem:v1 attribute:NSLayoutAttributeCenterX
                                                                    relatedBy:NSLayoutRelationEqual toItem:v1.superview
                                                                    attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:- 8];
    [parentView addConstraint:hconstraint2];
    
    NSLayoutConstraint *vconstraint2 = [NSLayoutConstraint constraintWithItem:v1 attribute:NSLayoutAttributeCenterY
                                                                    relatedBy:NSLayoutRelationEqual toItem:parentView
                                                                    attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f];
    [parentView addConstraint:vconstraint2];
    
    NSLayoutConstraint *sizeConstraint22=[NSLayoutConstraint constraintWithItem:v1 attribute:NSLayoutAttributeHeight relatedBy: NSLayoutRelationEqual
                                                                         toItem:nil attribute:NSLayoutAttributeNotAnAttribute  multiplier:0.0f constant:22];
    [v1 addConstraint:sizeConstraint22];
    NSLayoutConstraint *sizeConstraint223=[NSLayoutConstraint constraintWithItem:v1 attribute:NSLayoutAttributeWidth relatedBy: NSLayoutRelationGreaterThanOrEqual
                                                                          toItem:nil attribute:NSLayoutAttributeNotAnAttribute  multiplier:0.0f constant:30];
    [v1 addConstraint:sizeConstraint223];
}

-(void)alignViewCenter//水平垂直居中
{
    [self addHorizontalConstraint];
    [self addVerticalConstraint];
}

-(void)alignViewHCenter:(CGFloat)theTop//水平居中
{
    [self addHorizontalConstraint];
    [self addTopConstraint:theTop];
}

-(void)alignViewVCenter:(CGFloat)theLeft//垂直居中
{
    [self addVerticalConstraint];
    [self addLeftConstraint:theLeft];
}

-(void)toLeftOnConstraint:(UIView *)v withEx:(CGFloat)y//向左靠
{
    [self baseToWhatOn:v onPosition:JYLayoutToOnLeft withEx:y];
}

-(void)toRightOnConstraint:(UIView *)v withEx:(CGFloat)y
{
    [self baseToWhatOn:v onPosition:JYLayoutToOnRight withEx:y];
}

-(void)toTopOnConstraint:(UIView *)v withEx:(CGFloat)x
{
    [self baseToWhatOn:v onPosition:JYLayoutToOnTop withEx:x];
}

-(void)toBottomOnConstraint:(UIView *)v withEx:(CGFloat)x
{
    [self baseToWhatOn:v onPosition:JYLayoutToOnBottom withEx:x];
}

-(void)baseToWhatOn:(UIView *)v onPosition:(JYLayoutToOn)theOn withEx:(CGFloat)otherSize
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutAttribute on1;
    NSLayoutAttribute on2;
    switch (theOn) {
        case JYLayoutToOnLeft:
        {
            on1 = NSLayoutAttributeLeft;
            on2 = NSLayoutAttributeRight;
        }
            break;
        case JYLayoutToOnRight:
        {
            on1 = NSLayoutAttributeRight;
            on2 = NSLayoutAttributeLeft;
        }
            break;
        case JYLayoutToOnTop:
        {
            on1 = NSLayoutAttributeTop;
            on2 = NSLayoutAttributeBottom;
        }
            break;
        case JYLayoutToOnBottom:
        {
            on1 = NSLayoutAttributeBottom;
            on2 = NSLayoutAttributeTop;
        }
            break;
        default:
            break;
    }
    NSLayoutConstraint *toOnconstraint = [NSLayoutConstraint constraintWithItem:self
                                                                      attribute:on1
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:v
                                                                      attribute:on2
                                                                     multiplier:1.0f
                                                                       constant:otherSize];
    [self.superview addConstraint:toOnconstraint];
}

-(void)addTopConstraint:(CGFloat)theTop
{
    //    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self
    //                                                                     attribute:NSLayoutAttributeTop
    //                                                                     relatedBy:NSLayoutRelationEqual
    //                                                                        toItem:self.superview
    //                                                                     attribute:NSLayoutAttributeTop
    //                                                                    multiplier:1.0f constant:theTop];
    //    [self addConstraint:topConstraint];
    [self basePositionConstraint:JYLayoutPositionTop with:theTop];
}

-(void)addLeftConstraint:(CGFloat)theLeft
{
    [self basePositionConstraint:JYLayoutPositionLeft with:theLeft];
}

-(void)basePositionConstraint:(JYLayoutPosition)thePosition with:(CGFloat)theSize
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *positionConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                          attribute:(NSLayoutAttribute)thePosition
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.superview
                                                                          attribute:(NSLayoutAttribute)thePosition
                                                                         multiplier:1.0f
                                                                           constant:theSize];
    [self.superview addConstraint:positionConstraint];
}

-(void)addHorizontalConstraint
{
    [self addHorizontalConstraint:0];
}

-(void)addHorizontalConstraint:(CGFloat)x
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *Hconstraint = [NSLayoutConstraint constraintWithItem:self
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.superview
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1.0f
                                                                    constant:x];
    [self.superview addConstraint:Hconstraint];
}

-(void)addVerticalConstraint
{
    [self addVerticalConstraint:0];
}

-(void)addVerticalConstraint:(CGFloat) y
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *Vconstraint = [NSLayoutConstraint constraintWithItem:self
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.superview
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.0f
                                                                    constant:y];
    [self.superview addConstraint:Vconstraint];
}

-(void)addWidthConstraint:(JYLayoutRelation)related width:(CGFloat)theWidth
{
    //    NSLayoutConstraint *widthConstraint =[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy: (NSLayoutRelation)related
    //                                                                        toItem:nil attribute:NSLayoutAttributeNotAnAttribute  multiplier:0.0f constant:theWidth];
    //    [self addConstraint:widthConstraint];
    [self baseSizeConstrain:self layoutSize:JYLayoutSizeWidth related:related size:theWidth];
}

-(void)addHeightConstraint:(JYLayoutRelation)related width:(CGFloat)theHeight
{
    [self baseSizeConstrain:self layoutSize:JYLayoutSizeHeight related:related size:theHeight];
}

-(void)baseSizeConstrain:(UIView *)v layoutSize:(JYLayoutSize)hOrw related:(JYLayoutRelation)theRelated size:(CGFloat)theSize
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *sizeConstraint = [NSLayoutConstraint constraintWithItem:v
                                                                      attribute:(NSLayoutAttribute)hOrw
                                                                      relatedBy:(NSLayoutRelation)theRelated
                                                                         toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                     multiplier:0.0f
                                                                       constant:theSize];
    [v addConstraint:sizeConstraint];
}

//-(void)addHeightWithChildViewConstrain:(UIView *)v
//{
//    NSLayoutConstraint *hSize = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:v attribute:<#(NSLayoutAttribute)#> multiplier:<#(CGFloat)#> constant:<#(CGFloat)#>];
//}

@end
