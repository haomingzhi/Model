//
//  SelectedGoodsTypeViewController.m
//  oranllcshoping
//
//  Created by Steve on 2017/7/25.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "SelectedGoodsTypeViewController.h"
#import "JYCommonTool.h"

@interface SelectedGoodsTypeViewController ()

@end

@implementation SelectedGoodsTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.viewsArr = [NSMutableArray new];
     self.curBtnsArr = [NSMutableArray new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) resDownloadNotification:(BSNotification *) noti
{
     if (noti.error.code ==0) {
          BURes *res = (BURes *) noti.target;
//          UIImageView * imageView = (UIImageView *)[ noti.extraInfo objectForKey:@"imageView"];
          _imgV.contentMode = UIViewContentModeScaleToFill;
          _imgV.image = [UIImage imageWithContentsOfFile:res.cacheFile];
     }
}

-(void)fitCellMode{
     
     self.view.width = __SCREEN_SIZE.width;
     self.view.height = __SCREEN_SIZE.height - 150;
     
     _imgV.layer.cornerRadius = 6.0;
     _imgV.layer.masksToBounds = YES;
     _imgV.image = [UIImage imageNamed:@"default"];
     _imgV.backgroundColor = kUIColorFromRGB(color_f8f8f8);
     _imgV.contentMode = UIViewContentModeCenter;
     
     _bottomView.y = self.view.height - TABBARNONEHEIGHT - _bottomView.height;
     _bottomView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _bottomView.layer.borderWidth = 0.5;
     
     
     if (__SCREEN_SIZE.width  == 320) {
          _imgV.width = 70;
          _imgV.height = 70;
          UIFont *font = [UIFont systemFontOfSize:11];
          _sumPriceLb.font = font;
          _sumPriceTitleLb.font = font;
          _priceTitlleLb.font = font;
          _priceLb.font = font;
          _insuranceTitleLb.font = font;
          _insurancePriceLb.font = font;
     }
     
     NSString *type = [_dataDic[@"type"] integerValue] == 0?@"元/月":@"元/天";
     
     _sumPriceTitleLb.text = [_dataDic[@"type"] integerValue] == 0?@"首付仅需":@"总计金额";
     _sumPriceLb.text = [NSString stringWithFormat:@"%.2f元",[_dataDic[@"sumPrice"] floatValue]];
     _sumPriceLb.attributedText = [_sumPriceLb richText:_sumPriceLb.font text:@"元" color:kUIColorFromRGB(color_0xb0b0b0)];
     
     _priceLb.text = [NSString stringWithFormat:@"%.2f%@",[_dataDic[@"rentPrice"] floatValue],type];
     _priceLb.attributedText = [_priceLb richText:_priceLb.font text:type color:kUIColorFromRGB(color_0xb0b0b0)];
     
     NSDate *date = _dataDic[@"startDate"];
     [_startDateBtn setTitle:[JYCommonTool stringForDate:date withDateFormat:@"yyyy-MM-dd"] forState:UIControlStateNormal];
     date = _dataDic[@"endDate"];
     [_endDateBtn setTitle:[JYCommonTool stringForDate:date withDateFormat:@"yyyy-MM-dd"] forState:UIControlStateNormal];
     
     
     
     CGFloat insurancePrice = [_dataDic[@"insurancePrice"] floatValue];
     [_insuranceTitleLb sizeToFit];
//     _insurancePriceLb.textAlignment = NSTextAlignmentCenter;
     if (insurancePrice <= 0) {
          _insurancePriceLb.text = @"--";
//          _insuranceWarnLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
          _serverView.hidden = YES;
          _serverView.userInteractionEnabled = NO;
//          _insurancePriceLb.width = _insuranceTitleLb.width;
//          _insurancePriceLb.textAlignment = NSTextAlignmentCenter;
     }else{
          _insurancePriceLb.text = [NSString stringWithFormat:@"%.2f元",insurancePrice];
          _insurancePriceLb.attributedText = [_insurancePriceLb richText:_insurancePriceLb.font text:@"元" color:kUIColorFromRGB(color_0xb0b0b0)];
          _serverView.hidden = NO;
          _serverView.userInteractionEnabled = YES;
          _insuranceWarnLb.text = [NSString stringWithFormat:@"意外保险 ￥%.2f（必选）",insurancePrice];
//          _insurancePriceLb.textAlignment = NSTextAlignmentLeft;
//          [_insurancePriceLb sizeToFit];
     }
     
     
//     if (__SCREEN_SIZE.width == 320) {
//          _insurancePriceLb.x = _priceLb.x;
//          _insurancePriceLb.y = 52;
//          _insuranceTitleLb.x = _priceLb.x;
//          _insuranceTitleLb.y = 70;
//     }else{
//          _insurancePriceLb.x = 284;
//          _insurancePriceLb.y = _priceLb.y;
//          _insuranceTitleLb.x = _insurancePriceLb.x;
//          _insuranceTitleLb.y = 28;
//     }
     
     _sumPriceLb.x = _imgV.x +_imgV.width ;
     _sumPriceTitleLb.x= _sumPriceLb.x;
     
     CGFloat with =(__SCREEN_SIZE.width - _sumPriceLb.x)/3.0;
     _sumPriceLb.width = with-5;
     _sumPriceTitleLb.width = with-5;
     
     _lineImgV.x = _sumPriceTitleLb.x +_sumPriceTitleLb.width;
     
     _priceLb.width = with+10;
     _priceTitlleLb.width = with+10;
     _priceLb.x = _lineImgV.x +_lineImgV.width;
     _priceTitlleLb.x = _priceLb.x;
     
     _insurancePriceLb.width = with-5;
     _insuranceTitleLb.width = with-5;
     _insurancePriceLb.x = _priceLb.x +_priceLb.width;
     _insuranceTitleLb.x = _insurancePriceLb.x;
     
//     _depositLb.text = [NSString stringWithFormat:@"可退押金：%.2f",[_dataDic[@"credit"] floatValue]];
     
     
     BUImageRes *img = _dataDic[@"img"];
     if ([img isKindOfClass:[BUImageRes class]]) {
          [img download:self callback:@selector(resDownloadNotification:) extraInfo:nil];
//          [img displayRemoteImage:_imgV imageName:@"default"];
     }
     else  if ([img isKindOfClass:[UIImage class]]) {
          _imgV.contentMode = UIViewContentModeScaleToFill;
          _imgV.image = (UIImage *)img;
     }
     else  if ([img isKindOfClass:[NSString class]]) {
          NSString *imgStr = (NSString *)img;
          if (imgStr.length != 0) {
               _imgV.contentMode = UIViewContentModeScaleToFill;
               _imgV.image = [UIImage imageNamed:(NSString *)img];
          }
          
     }
     NSInteger width = self.view.width;
     
     _scrollView.x = 0;
     _scrollView.y = 65;
     _scrollView.height = self.view.height - 65-53 -TABBARNONEHEIGHT;
     _scrollView.width = width;
     _scrollView.bounces = NO;
     
//     _confirmBtn.x = 50;
//     _confirmBtn.y = 396;
//     _confirmBtn.width = width -100;
//     _confirmBtn.height = 40;
     _confirmBtn.backgroundColor = kUIColorFromRGB(color_0xf74056);
     [_confirmBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     _confirmBtn.layer.cornerRadius = _confirmBtn.height/2.0;
//     _confirmBtn.layer.masksToBounds = YES;
     _confirmBtn.layer.shadowColor = kUIColorFromRGB(color_0xf74056).CGColor;
     _confirmBtn.layer.shadowOffset = CGSizeMake(0, 0);
     _confirmBtn.layer.shadowRadius = 8;
     _confirmBtn.layer.shadowOpacity = 0.43;
     
     //移除原先view
     [_viewsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          NSDictionary *dic = obj;
          UIView *v = dic[@"title"];
          [v removeFromSuperview];
          UIImageView *imgV = dic[@"line"];
          [imgV removeFromSuperview];
          NSArray *arr =  dic[@"arr"];
          [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               UIView *v = obj;
               [v removeFromSuperview];
          }];
     }];
     
     self.viewsArr = [NSMutableArray new];
     self.curBtnsArr = [NSMutableArray new];
     
     //新加view
     __block int y = 25;
     for (int i = 0; i<_dataArr.count; i++) {
          NSDictionary *dic = _dataArr[i];
          NSMutableDictionary *viewsDic = [NSMutableDictionary new];
          NSArray *arr = dic[@"arr"];
          UILabel *lb = [UILabel new];
          lb.x = 15;
          lb.y = y;
          lb.height = 15;
          lb.width = width-30;
          lb.textColor = kUIColorFromRGB(color_5);
          lb.text = dic[@"title"];
          lb.font = [UIFont systemFontOfSize:15];
          [_scrollView addSubview:lb];
          lb.textAlignment = NSTextAlignmentLeft;
          [viewsDic setObject:lb forKey:@"title"];
          
          NSMutableArray *btnsArr = [NSMutableArray new];
          y = y + lb.height +15;
          __block int x = 15;
          __block BOOL hasSelected = NO;
          [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               NSDictionary *dic = obj;
               NSString *name = dic[@"title"];
               NSInteger state = [dic[@"state"] integerValue];
               UIButton *btn = [[UIButton alloc]init];
               btn.width = 65;
               btn.height = 25;
               
               if (x + btn.width +15 >width) {
                    x = 15;
                    y = y+btn.height +15;
                    btn.x = x;
                    btn.y = y;
               }else{
                    btn.x = x;
                    btn.y = y;
                    x = x + btn.width+15;
               }
               
               if (state == 1) {//已选
                    [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
                    btn.backgroundColor = kUIColorFromRGB(color_0xf82D45);
                    [_curBtnsArr addObject:btn];
                    hasSelected = YES;
                    btn.userInteractionEnabled = YES;
               }
               else if (state == 0){//正常
                    [btn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
                    btn.backgroundColor = kUIColorFromRGB(color_f8f8f8);
                    btn.userInteractionEnabled = YES;
               }
               else if (state == 2){//不可选
                    [btn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
                    btn.backgroundColor = kUIColorFromRGB(color_2);
                    btn.userInteractionEnabled = NO;
               }
               
               btn.layer.cornerRadius = btn.height/2.0;
               btn.layer.masksToBounds = YES;
               btn.titleLabel.font = [UIFont systemFontOfSize:12];
               
               [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
               btn.tag = i*100 +idx;
               [btn setTitle:name forState:UIControlStateNormal];
               [_scrollView addSubview:btn];
               [btnsArr addObject:btn];
          }];
        
          UIImageView *lineImgV = [[UIImageView alloc]initWithFrame:CGRectMake(15, y+50, __SCREEN_SIZE.width-30, 1)];
          lineImgV.backgroundColor = kUIColorFromRGB(color_lineColor);
          [_scrollView addSubview:lineImgV];
          
          
          y = y+ 75;
          
          if (!hasSelected) {
               UIButton *btn = [UIButton new];
               btn.tag = -1;
//               btn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
//               [btn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
               [_curBtnsArr addObject:btn];
          }
          
          [self.viewsArr addObject:@{@"title":lb,@"arr":btnsArr,@"line":lineImgV}];
     }
     
     __block NSString *str = @"";
     [_curBtnsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          UIButton *btn = obj;
          if (btn.tag >=0) {
               if (str.length == 0) {
                    str =  btn.currentTitle;
               }else{
                    str = [NSString stringWithFormat:@"%@/%@",str,btn.currentTitle];
               }
          }
          
     }];
     _typeLb.text = str;
     
     if ([_dataDic[@"selectDate"] boolValue]) {
          _selectDateView.y = y-25;
          _selectDateView.hidden = NO;
          _selectDateView.userInteractionEnabled = YES;
          _serverView.y = _selectDateView.y + _selectDateView.height;
     }else{
          _serverView.y = y-25;
          _selectDateView.hidden = YES;
          _selectDateView.userInteractionEnabled = NO;
     }
     
     if (insurancePrice <=0) {
          _scrollView.contentSize = CGSizeMake(width, _serverView.y);
     }else
          _scrollView.contentSize = CGSizeMake(width, _serverView.y +_serverView.height);
     
     _scrollView.showsVerticalScrollIndicator = NO;
}

-(void)btnAction:(UIButton *)sender{
     NSInteger row  = sender.tag /100;
     NSInteger column = sender.tag % 100;
     UIButton *curBtn = _curBtnsArr[row];
     if (sender != curBtn) {
          [sender setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          sender.backgroundColor = kUIColorFromRGB(color_0xf82D45);
          if (curBtn != nil) {
               [curBtn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
               curBtn.backgroundColor = kUIColorFromRGB(color_f8f8f8);
          }
          
          [_curBtnsArr replaceObjectAtIndex:row withObject:sender];
          __block NSString *str = @"";
          [_curBtnsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               UIButton *btn = obj;
               if (btn.tag >=0) {
                    if (str.length == 0) {
                         str =  btn.currentTitle;
                    }else{
                         str = [NSString stringWithFormat:@"%@/%@",str,btn.currentTitle];
                    }
               }
               
          }];
          _typeLb.text = str;
          if (self.handleGoBack) {
               self.handleGoBack(@{@"arr":_curBtnsArr,@"state":@"3",@"title":str});
          }
     }else{
          [curBtn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
          curBtn.backgroundColor = kUIColorFromRGB(color_f8f8f8);
          UIButton *btn = [UIButton new];
          btn.tag = -1;
          [_curBtnsArr replaceObjectAtIndex:row withObject:btn];
          __block NSString *str = @"";
          [_curBtnsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               UIButton *btn = obj;
               if (btn.tag >=0) {
                    if (str.length == 0) {
                         str =  btn.currentTitle;
                    }else{
                         str = [NSString stringWithFormat:@"%@/%@",str,btn.currentTitle];
                    }
               }
               
          }];
          _typeLb.text = str;
          if (self.handleGoBack) {
               self.handleGoBack(@{@"arr":_curBtnsArr,@"state":@"3",@"title":str});
          }
     }
     
}


- (IBAction)confirmAction:(UIButton *)sender {
     __block BOOL hasAllSelected = YES;
     [_curBtnsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          UIButton *btn = obj;
          if (btn.tag <0) {
               hasAllSelected = NO;
          }
     }];
     if (!hasAllSelected) {
//          TOASTSHOW(@"请选择全商品规格");
//          HUDCRY(@"请选择全商品规格", 2);
          return;
     }
     
     
     [self.parentDialog dismiss];
     if (self.handleGoBack) {
          self.handleGoBack(@{@"state":@(0),@"arr":_curBtnsArr});
     }
}

-(void)setData:(NSDictionary*)dic{
     _dataDic = dic;
     _dataArr = dic[@"arr"];
}


-(void)setStartAndEndDate:(NSDictionary*)dic{
     NSDate *date = dic[@"startDate"];
     [_startDateBtn setTitle:[JYCommonTool stringForDate:date withDateFormat:@"yyyy-MM-dd"] forState:UIControlStateNormal];
     date = dic[@"endDate"];
     [_endDateBtn setTitle:[JYCommonTool stringForDate:date withDateFormat:@"yyyy-MM-dd"] forState:UIControlStateNormal];
}


static  SelectedGoodsTypeViewController *dealvc;
+(SelectedGoodsTypeViewController *) createVC:(NSDictionary *)dic
{
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
          dealvc = [[SelectedGoodsTypeViewController alloc] init];
          dealvc.view.width = __SCREEN_SIZE.width;
          dealvc.view.x = 0;
     });
     
     //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
     MyDialog *myDialog = [[MyDialog alloc] initWithViewController:dealvc];
     dealvc.view.width = __SCREEN_SIZE.width;
   __weak  MyDialog *weakD = myDialog;
 
     [dealvc setData:dic];
     [dealvc fitCellMode];
     myDialog.mydelegate = dealvc;
     myDialog.bgColor = kUIColorFromRGBWithAlpha(color_12, 0.5);
     myDialog.isDownAnimate = YES;
//     [myDialog show];
     [myDialog showAtPosition:CGPointMake(0,__SCREEN_SIZE.height-dealvc.view.height) animated:YES];
     myDialog.dismissOnTouchOutside = YES;
     
     
     return dealvc;
     
}
- (IBAction)selectBeginDateAction:(UIButton *)sender {
     if (self.handleGoBack) {
          self.handleGoBack(@{@"state":@(1),@"data":_dataDic,@"arr":_curBtnsArr});
     }
}

- (IBAction)selectEndDateAction:(UIButton *)sender {
     if (self.handleGoBack) {
          self.handleGoBack(@{@"state":@(2),@"data":_dataDic,@"arr":_curBtnsArr});
     }
}
- (IBAction)showAgreementAction:(UIButton *)sender {
     if (self.handleGoBack) {
          [self.parentDialog dismiss];
          self.handleGoBack(@{@"state":@(4)});
     }
}
@end
