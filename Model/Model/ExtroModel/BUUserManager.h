//
//  BUUserManager.h
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/12.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BULCManager.h"
#import "BUAgent.h"
#import "BUShopManager.h"


@interface BUCart : BUBase
@property(strong,nonatomic) NSArray *invalidGoodsList;
@property(strong,nonatomic) NSArray *shopList;
@end


@interface BUCartShopInfo : BUBase
@property(strong,nonatomic) NSString *shopName;
@property(strong,nonatomic) NSString *shopId;
@property(strong,nonatomic) NSArray *goodsList;
@property(strong,nonatomic) NSString *address;//地址
@property(strong,nonatomic) NSString *telephone;//电话
@property(nonatomic) CGFloat expressFee;
@property(nonatomic) CGFloat sumPrice;
@property(nonatomic) BOOL isAllSelected;
-(void)setAllSel;
-(NSDictionary *)getDic:(NSInteger)index;
@end


@interface BUCartShopGoods : BUBase
@property(strong,nonatomic) BUImageRes *imagePath;
@property(nonatomic) NSInteger count;
@property(strong,nonatomic) NSString *waterId;
@property(nonatomic) NSInteger stock;
@property(nonatomic) NSInteger goodsState;
@property(nonatomic) CGFloat salePrice;
@property(nonatomic) NSInteger shopState;
@property(strong,nonatomic) NSString *shopId;
@property(strong,nonatomic) NSString *goodsSpec;
@property(strong,nonatomic) NSString *shopName;
@property(strong,nonatomic) NSString *goodsId;
@property(strong,nonatomic) NSString *name;
@property(nonatomic) BOOL isSelected;
-(NSDictionary *)getDic:(NSInteger)index;
-(void) setData:(BUGoodsInfo *)goodsInfo;
@end


@interface BUUserManager : BULCManager
//添加购物车
-(BOOL)addUserCart:(NSString *)goodsId count:(NSInteger)count   observer:(id)observer callback:(SEL)callback;
-(BOOL)addUserCart:(NSString *)goodsId count:(NSInteger)count    observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//添加收藏
-(BOOL)addGoodsCollect:(NSString *)goodsId productType:(NSString *)productType   observer:(id)observer callback:(SEL)callback;
-(BOOL)addGoodsCollect:(NSString *)goodsId productType:(NSString *)productType    observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//获取跑腿师傅详情
@property (nonatomic,strong) BUCourier *courier;
-(BOOL)getCourierInfo:(NSString *)ID  observer:(id)observer callback:(SEL)callback;
-(BOOL)getCourierInfo:(NSString *)ID  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//获取购物车列表
@property (nonatomic,strong) BUCart  *cartInfo;
-(BOOL)getShoppingCartList:(NSString *)userId   observer:(id)observer callback:(SEL)callback;
-(BOOL)getShoppingCartList:(NSString *)userId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

@property (nonatomic,assign) NSInteger cartCount;
-(BOOL)getUserCartCount:(NSString *)userId   observer:(id)observer callback:(SEL)callback;
-(BOOL)getUserCartCount:(NSString *)userId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

@end
