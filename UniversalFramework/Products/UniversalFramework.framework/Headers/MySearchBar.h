//
//  MySearchBar.h
//  MiniClient
//
//  Created by Apple on 14-10-17.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum
{
    MiniSearchType_3GNumber,//查找3G号码
    MiniSearchType_2GNumber,//查找2G号码
    MiniSearchType_2G_Pac,  //查找2G套餐
    MiniSearchType_Mobile,
}MiniSearchType;

@interface MySearchBar : UISearchBar


@property (nonatomic) NSMutableArray *searchResults;
@property (nonatomic) MiniSearchType miniSearchType;


-(void)addSearchRecord:(NSString *)searchKey;
-(NSArray *) filterForKey:(NSString *)key;
-(NSArray *) filterForKey:(NSString *)key MaxCount:(NSInteger) count;
@end
