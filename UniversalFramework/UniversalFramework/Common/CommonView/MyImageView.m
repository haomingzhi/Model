//
//  MyImageView.m
//  JiXie
//
//  Created by ORANLLC_IOS1 on 15/7/7.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "MyImageView.h"


@implementation MyImageView
{
    UITapGestureRecognizer *tapGesture;
}
-(id) init
{
    self = [super init];
    if (self) {
         tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didtouch:)];
        //view.tag = index;
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

-(void)didtouch:(UITapGestureRecognizer *)tap
{
    [self handleDid:self];
}

-(void) handleDid:(id) sender
{
    
}
-(void) setImageRes:(BURes *)imageRes
{
    _imageRes = imageRes;
    [self displayRemoteImage:_imageRes imgView:self defaultImage:NULL];
}


-(void)displayRemoteImage:(BURes *) res  imgView:(UIImageView *) imageView defaultImage:(NSString *) defaultImage
{
    if (res.isCached) {
        imageView.image = [UIImage imageWithContentsOfFile:res.cacheFile];
    }
    else
    {
        if (defaultImage.length >0) {
            imageView.image = [UIImage imageNamed:defaultImage];
        }
        [res download:self callback:@selector(resDownloadNotification:) extraInfo:@{@"imageView":imageView}];
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

-(void)dealloc
{
    if (tapGesture != nil )
    {
        [self removeGestureRecognizer:tapGesture];
    }
}

@end
