//
//  JYQueueView.h
//  
//
//  Created by air on 15/12/16.
//
//

#import <UIKit/UIKit.h>

@interface JYQueueView : UIView
@property(nonatomic)float paddingX;
@property(nonatomic)float paddingLeft;
@property(nonatomic)bool isToRight;//是否向右靠齐
-(void)addViewToList:(UIView *)v;
-(void)removeViewFromListView:(UIView *)v;
//-(void)removeViewFromListView:(n)
-(void)removeViewFromListViewWithTag:(NSInteger)tag;
-(void)reloadView;
-(void)addViewToListView:(NSInteger )tag;
-(void)addViewToListView:(NSInteger )tag withImgName:(NSString *)imgName;
-(void)removeAllView;
@end
