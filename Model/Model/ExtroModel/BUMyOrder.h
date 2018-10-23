//
//  BUMyOrder.h
//  JiXie
//
//  Created by ORANLLC_IOS1 on 15/6/25.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//


#import "BUImageRes.h"
//#import "BUTradeOrder.h"


@interface BUMyOrder : BUBase
@property(strong,nonatomic) NSString *orderId;      //订单号
@property(strong,nonatomic) NSString *status;       //订单状态状态（0：代付款1：代发货2：已发货3:已完成4：已关闭）
@property(strong,nonatomic) NSString *posttime;     //时间
@property(nonatomic) NSArray *img;                  //图片
@property(strong,nonatomic) NSString *unit_fee;     //单价
@property(strong,nonatomic) NSString *amount;       //数量
@property(strong,nonatomic) NSString *title;        //标题
@property(strong,nonatomic) NSString *total_fee;    //总价
@property(strong,nonatomic) NSString *username;     //发布者昵称
@property(strong,nonatomic) BUImageRes *avatar;     //用户缩略图
@property(strong,nonatomic) NSString *post_fee;     //邮费
@property(nonatomic) NSString *orderSn;             //订单编号
@property(nonatomic) NSString *logistic_sn;         //快递单号
@property(nonatomic) NSString *logistic_company;    //快递公司
@property(nonatomic) NSString *receiver;
@property(nonatomic) NSString *address;
@property(nonatomic) NSString *mobile;
@property(nonatomic) NSString *remark;
@property(nonatomic) NSInteger payMethod;           //支付方式（1:支付宝支付 2:微信支付）
@property(nonatomic) NSString *payInfo;             //支付信息
//@property(nonatomic,readonly) NSString *orderStatusDescript;
//
//@property(nonatomic,readonly) BUImageRes *image;


//支付完成回调
//-(BOOL) paySucessed:(NSString *) resultStr observer:(id)observer callback:(SEL) callback ;

//请求支付
-(BOOL) requestPay:(NSString *)num withPayWay:(NSString *)payway withType:(NSString *)theType withArea:(NSString *)areaId observer:(id)observer callback:(SEL) callback;

//取消订单
-(BOOL) cancelOrder:(id)observer callback:(SEL) callback ;
//提醒发车
-(BOOL) noticeficationSeller :(id)observer callback:(SEL) callback ;

//确认收货
-(BOOL) confirmOrder:(id)observer callback:(SEL) callback ;
//删除订单
-(BOOL) deleteOrder:(id)observer callback:(SEL) callback ;


@end
