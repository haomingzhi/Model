//
//  DDTextFieldCodeTableViewCell.h
//  DDZX_js
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDTextFieldCodeTableViewCell : UITableViewCell
@property(nonatomic,strong)void (^codeCallBack)(NSDictionary *dic);
@property(nonatomic,strong)BOOL (^codeWillSendCallBack)(NSDictionary *dic);
@property(nonatomic,strong)NSString *text;
+(BOOL)phoneNumberIsTrue:(NSString *)phoneNumber;
-(void)refresh:(NSDictionary *)dic;
@end
