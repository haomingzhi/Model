//
//  UIImage+ImageEffects_h.h
//  UniversalFramework
//
//  Created by ORANLLC_IOS1 on 15/10/26.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageEffects_h)
- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;
@end
