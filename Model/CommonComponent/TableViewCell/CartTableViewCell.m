//
//  CartTableViewCell.m
//  oranllcshoping
//
//  Created by Steve on 2017/7/24.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "CartTableViewCell.h"

@implementation CartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic{
     _numTextField.text = dataDic[@"num"];
     _titleLb.text = dataDic[@"title"];
     _typeLb.text = dataDic[@"type"];
     _priceLb.text = dataDic[@"price"];
     _imgV.image = [UIImage imageContentWithFileName:dataDic[@"default"]];
     //    _imgV.image = [UIImage imageContentWithFileName:dataDic[@"default"]];
     id imgObjc = dataDic[@"img"];
     if ([imgObjc isKindOfClass:[BUImageRes class]]) {
          BUImageRes *img = (BUImageRes *)imgObjc;
          if (img.isCached) {
               UIImage *im =  [UIImage imageWithContentsOfFile:img.cacheFile];
               if (im) {
                    _imgV.image = im;
               }
               
          }
          else {
               [img download:self callback:@selector(getImgNotification:) extraInfo:nil];
          }
     }
     else if([imgObjc isKindOfClass:[NSString class]])
     {
          if ([imgObjc isEqualToString:@""]) {
               return;
          }
          UIImage *im = [UIImage imageContentWithFileName:imgObjc];
          if (im) {
               _imgV.image = im;
          }
          
     }
     else if([imgObjc isKindOfClass:[UIImage class]])
     {
          _imgV.image = imgObjc;
     }
     
     
     
     
}

-(void)getImgNotification:(BSNotification *) noti
{
     if(noti.error.code ==0)
     {
          BUImageRes *res =(BUImageRes *) noti.target;
          if (res.isCached) {
               UIImage *im =  [UIImage imageWithContentsOfFile:res.cacheFile];
               if (im) {
                    _imgV.image = im;
               }
               
          }
     }
}

-(void)fitCellMode{
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
     
     _typeLb.textColor = kUIColorFromRGB(color_8);
     _typeLb.width = _titleLb.width;
     
     _priceLb.textColor = kUIColorFromRGB(color_0xec7e3b);
     _priceLb.width =  100;
     
     _numTextField.textColor = kUIColorFromRGB(color_8);
     
     _addBtn.x = __SCREEN_SIZE.width - 15 -_addBtn.width;
     _numTextField.x = _addBtn.x - _numTextField.width;
     _reduceBtn.x = _numTextField.x - _reduceBtn.width;
     
     _selectedtypeBtn.x = __SCREEN_SIZE.width - 15 - _selectedtypeBtn.width;
     
     [_selectedtypeBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
     _numTextField.delegate = self;
}

-(void)setIsSelect:(BOOL)isSelect isEdit:(BOOL)isEdit{
     if (isSelect) {
          _selectedImgV.image = [UIImage imageNamed:@"icon_selected"];
     }else{
           _selectedImgV.image = [UIImage imageNamed:@"icon_unselected"];
     }
     
     if (isEdit) {
          _selectedtypeBtn.hidden = NO;
          _selectedtypeBtn.userInteractionEnabled = YES;
     }else{
          _selectedtypeBtn.hidden = YES;
          _selectedtypeBtn.userInteractionEnabled = NO;
     }
}



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
     return NO;
}

//选择按钮
- (IBAction)selectedAction:(UIButton *)sender {
     if (self.handleAction) {
          self.handleAction(@{@"index":@"1"});
     }
}

//重选规格
- (IBAction)selectdTypeAction:(UIButton *)sender {
     if (self.handleAction) {
          self.handleAction(@{@"index":@"2"});
     }
}
- (IBAction)reduceAction:(UIButton *)sender {
     NSInteger num = [_numTextField.text integerValue];
     if (num <= 1) {
//          TOASTSHOW(@"商品数量不能小于1");
//          _numTextField.text = @"1";
          if (self.handleAction) {
               self.handleAction(@{@"index":@"3",@"num":@(0)});
          }
          return;
     }else{
          num --;
          _numTextField.text = [NSString stringWithFormat:@"%ld",(long)num];
     }
     if (self.handleAction) {
          self.handleAction(@{@"index":@"3",@"num":@(num)});
     }
     
}
- (IBAction)addAction:(UIButton *)sender {
     NSInteger num = [_numTextField.text integerValue];
     
     num ++;
     _numTextField.text = [NSString stringWithFormat:@"%ld",(long)num];
     if (self.handleAction) {
          self.handleAction(@{@"index":@"3",@"num":@(num)});
     }
}
@end
