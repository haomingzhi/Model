//
//  TSAssetsViewController.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 05.01.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class TSAssetsPickerController;

@protocol TSAssetsViewControllerDelegate;

@interface TSAssetsViewController :BaseViewController
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) UIBarButtonItem *selectButton;
@property (nonatomic, weak) id <TSAssetsViewControllerDelegate> delegate;
@property (nonatomic) TSAssetsPickerController *picker;

- (void)configureWithAlbumName:(NSString *)name;
@end



@protocol TSAssetsViewControllerDelegate <NSObject>
- (void)assetsViewController:(TSAssetsViewController *)assetsVC didFinishPickingAssets:(NSArray *)assets;
- (void)assetsViewController:(TSAssetsViewController *)albumsVC failedWithError:(NSError *)error;
-(NSInteger) numberOfItemsCanSelected;  //可选中图片张数
@end