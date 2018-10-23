//
//  MySearchBar.m
//  MiniClient
//
//  Created by Apple on 14-10-17.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "MySearchBar.h"

@implementation MySearchBar
{
    NSMutableArray* searchHistorys;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}



-(NSString *)getKey:(SearchType)searchType
{
    return [NSString stringWithFormat:@"searchHistory%d",searchType];
}

-(void)setSearchType:(SearchType)searchType
{
    if (searchHistorys == nil) {
        searchHistorys =[[NSMutableArray alloc]init];
    }
    if (_searchResults == nil) {
        _searchResults = [[NSMutableArray alloc]init];
    }
    NSString * searchHistoryString =[BSUtility getDefault:[self getKey:searchType]];
    NSArray * searchHistoryStrs =  searchHistoryString.length >0 ?   [searchHistoryString componentsSeparatedByString:@"|"] : NULL;
    for (int i =0; i < searchHistoryStrs.count; i++) {
        [searchHistorys addObject:[searchHistoryStrs objectAtIndex:i ]];
    }
    _searchType = searchType;
    for (int i =0; i < searchHistorys.count && i <15;i++) {
        [_searchResults addObject:[searchHistorys objectAtIndex:i]];
    }
}

-(BOOL)isExists:(NSString *)searchKey
{
    for (int i=0; i < searchHistorys.count; i++) {
        if ([[searchHistorys objectAtIndex:i] isEqualToString:searchKey]) {
            return TRUE;
        }
    }
    return FALSE;
}

-(void)clean
{
    [searchHistorys removeAllObjects];
    [self.searchResults removeAllObjects];
    [BSUtility saveDefault:[self getKey:self.searchType] AndValue:@""];
}

-(void)addSearchRecord:(NSString *)searchKey
{
    if (![self isExists:searchKey]) {
        NSString * searchHistoryString =[BSUtility getDefault:[self getKey:self.searchType]];
        if (searchHistoryString == nil) {
            searchHistoryString = @"";
        }
        searchHistoryString  = [NSString stringWithFormat: [BSUtility isNullId:searchHistoryString] ? @"%@%@":@"%@|%@",searchKey,searchHistoryString];
        [BSUtility saveDefault:[self getKey:self.searchType] AndValue:searchHistoryString];
        [searchHistorys removeAllObjects];
        
        [searchHistorys addObjectsFromArray:[searchHistoryString componentsSeparatedByString:@"|"]];
        if (_maxCount > 0) {
            if (searchHistorys.count > _maxCount) {
                NSInteger c = (searchHistorys.count - _maxCount);
                for (NSInteger i = 0; i < c; i ++) {
                    [searchHistorys removeLastObject];
                }
            }
        }
    }
}

-(NSArray *)historyData
{
    return searchHistorys;
}
-(NSArray *) filterForKey:(NSString *)key
{
    return [self filterForKey:key MaxCount:0];
}
-(NSArray *) filterForKey:(NSString *)key MaxCount:(NSInteger) count
{
    [_searchResults removeAllObjects]; // First clear the filtered array.
    for (NSString *record in searchHistorys)
	{
        NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
        NSRange recordRange = NSMakeRange(0, record.length);
        NSRange foundRange = [record rangeOfString:key options:searchOptions range:recordRange];
        if (foundRange.length > 0 || key.length ==0)
        {
            if (count !=0 && _searchResults.count == count) {
                break;
            }
            [_searchResults addObject:record];
        }
	}
    return _searchResults;
}

@end
