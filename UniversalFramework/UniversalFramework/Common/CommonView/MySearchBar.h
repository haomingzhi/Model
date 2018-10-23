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
    SearchType_ProductName,
     SearchType_num1,
     SearchType_num2,
     SearchType_num3,
     SearchType_num4,
}SearchType;

@interface MySearchBar : UISearchBar

@property (nonatomic,weak)NSArray *historyData;
@property (nonatomic) NSMutableArray *searchResults;
//设置搜索类型，获取对应的搜索记录
@property (nonatomic) SearchType searchType;
@property (nonatomic)NSInteger maxCount;
-(void)addSearchRecord:(NSString *)searchKey;
-(void)clean;
-(NSArray *) filterForKey:(NSString *)key;
-(NSArray *) filterForKey:(NSString *)key MaxCount:(NSInteger) count;
@end
