//
//  ReceiverAddressViewController.h
//  JiXie
//
//  Created by ORANLLC_IOS1 on 15/5/25.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//



@interface ReceiverAddressViewController : JYBaseViewController

//@property(nonatomic) NSString *order_receiver;          //收货人
//@property(nonatomic) NSString *order_mobile;            //收货手机号
//@property(nonatomic) NSString *order_address;           //收货地址
//@property(nonatomic) NSString *order_detailaddress;     //收货详细地址

@property (weak, nonatomic) IBOutlet MyInputView *inputVieworder_receiver;

@property (weak, nonatomic) IBOutlet MyInputView *inputViewdorder_mobile;


@property (weak, nonatomic) IBOutlet MyInputView *inputVieworder_address;

@property (weak, nonatomic) IBOutlet MyInputView *inputVieworder_detailaddress;


- (IBAction)handleTextFieldReturn:(id)sender;

@property(nonatomic,strong) void (^doneCallBack)();
@end
