//
//  TwoTabsTableViewCell.m
//  ulife
//
//  Created by air on 15/12/17.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "TwoTabsTableViewCell.h"

@implementation TwoTabsTableViewCell
{
    
    IBOutlet UILabel *_selectLb;
    IBOutlet UIButton *_secondBtn;
    IBOutlet UIButton *_firstBtn;
    UIButton *_curBtn;
    UIColor *_selectcLineColor;
    UIColor *_selectTitleColor;
    UIColor *_normalTitleColor;
     NSDictionary *_dataDic;
}

- (void)awakeFromNib {
    // Initialization code
    _selectLb.y = 37;
    _selectLb.x = 0;
    _selectLb.backgroundColor = kUIColorFromRGB(color_1);
    _selectLb.width = 50;//__SCREEN_SIZE.width/2.0;
    _curBtn = _firstBtn;
    [self addObserver:self forKeyPath:@"height" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"height"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"height"]) {
        _selectLb.y = self.height - 1;
    }
    
}
-(void)setLineHidden:(BOOL)b
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)setSelectLineHidden:(BOOL)b
{
    _selectLb.hidden = b;
}
-(void)setCellData:(NSDictionary *)dataDic
{
     _dataDic = dataDic;
    [_firstBtn setTitle:[NSString stringWithFormat:@"%@",dataDic[@"tab1"]] forState:UIControlStateNormal];
    [_secondBtn setTitle:[NSString stringWithFormat:@"%@",dataDic[@"tab2"]] forState:UIControlStateNormal];
    _curIndexPath = dataDic[@"row"];
    NSInteger s = [dataDic[@"select"] integerValue];
    switch (s) {
        case 0:
        {
            [_firstBtn setTitleColor:_selectTitleColor?:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
            [_secondBtn setTitleColor:_normalTitleColor?:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
            _secondBtn.backgroundColor = _unSelectBgColor?:kUIColorFromRGB(color_2);
            _firstBtn.backgroundColor = _selectBgColor?:kUIColorFromRGB(color_2);
            [_firstBtn addSubview:_selectLb];
//            _selectLb.x = _firstBtn.x;
            _curBtn = _firstBtn;
            //            lb1.textColor = kUIColorFromRGB(color_0x303030);
            //            lb2.textColor = kUIColorFromRGB(color_0x999999);
        }
            break;
        case 1:
        {
            [_secondBtn setTitleColor:_selectTitleColor?:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
            [_firstBtn setTitleColor:_normalTitleColor?:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
            _firstBtn.backgroundColor = _unSelectBgColor?:kUIColorFromRGB(color_2);
            _secondBtn.backgroundColor = _selectBgColor?:kUIColorFromRGB(color_2);
            [_secondBtn addSubview:_selectLb];
//            _selectLb.x =  _secondBtn.width;
            _curBtn = _secondBtn;
            //            lb1.textColor = kUIColorFromRGB(color_0x999999);
            //            lb2.textColor = kUIColorFromRGB(color_0x303030);
        }
            break;
        default:
            break;
    }
}
- (IBAction)tabOneHandle:(id)sender {
   
    if (_tabOneCallBack) {
         __weak TwoTabsTableViewCell *ws = self;
        UIButton *btn = sender;
        btn.userInfo = @{@"row":ws.curIndexPath?:[NSNull new]};
        _tabOneCallBack(sender);
    }
}


- (IBAction)tabTwoHandle:(id)sender {
    if (_tabTwoCallBack) {
         __weak TwoTabsTableViewCell *ws = self;
        UIButton *btn = sender;
         btn.userInfo = @{@"row":ws.curIndexPath?:[NSNull new]};
        _tabTwoCallBack(sender);
    }
}

-(NSInteger)curIndex
{
    return _curBtn.tag - 100;
}

-(void)setCurBtnIndex:(NSInteger)curBtnIndex
{
    UIButton *btn = (UIButton *)[self viewWithTag:curBtnIndex + 100];
    //    if (btn == _curBtn&&!_canClickAgain) {
    //        return ;
    //    }
    if (btn.tag != 103) {
        [_curBtn setTitleColor:kUIColorFromRGB(color_6) forState:UIControlStateNormal];
        _curBtn.backgroundColor = _unSelectBgColor?:kUIColorFromRGB(color_2);
        [btn addSubview:_selectLb];
        [btn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
        btn.backgroundColor = _selectBgColor?:kUIColorFromRGB(color_2);
        _curBtn  = btn;
    }
}

-(void)fitMyfavMode
{
    _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
    _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
   
    _firstBtn.width = 60;
    _firstBtn.height = 44;
     _firstBtn.x = (__SCREEN_SIZE.width - 90)/2.0 - _firstBtn.width - 5;
    _firstBtn.y = 0;
    _secondBtn.x = (__SCREEN_SIZE.width - 90)/2.0 + 5;
    _secondBtn.y = 0;
    _secondBtn.height = 44;
    [_firstBtn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
      [_secondBtn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    _secondBtn.width = 50;
    _selectLb.height = 2;
    _selectLb.text = @"";
    _selectLb.backgroundColor = kUIColorFromRGB(color_5);
    _selectLb.hidden = YES;

}

-(void)fitFreshRecMode
{
     _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     
     _firstBtn.width = 60;
     _firstBtn.height = 44;
     _firstBtn.x = (__SCREEN_SIZE.width - 90)/2.0 - _firstBtn.width - 5;
     _firstBtn.y = 0;
     _secondBtn.x = (__SCREEN_SIZE.width - 90)/2.0 + 5;
     _secondBtn.y = 0;
     _secondBtn.height = 44;
     [_firstBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     [_secondBtn setTitleColor:kUIColorFromRGB(color_0xff6b38) forState:UIControlStateNormal];
//     _secondBtn.width = 50;
//     _selectLb.height = 2;
//     _selectLb.text = @"";
//     _selectLb.backgroundColor = kUIColorFromRGB(color_5);
     _selectLb.hidden = YES;
     UIView *v = [self.contentView viewWithTag:4081];
         if (!v) {
             v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
             v.tag = 4081;
             v.backgroundColor = kUIColorFromRGB(color_3);
             v.x = 0;
         }
     v.layer.cornerRadius = 6;
     v.layer.masksToBounds = YES;
     [v addSubview:_firstBtn];
     [v addSubview:_secondBtn];
     _normalTitleColor = kUIColorFromRGB(color_0xff6b38);
     _selectTitleColor = kUIColorFromRGB(color_2);
     _firstBtn.x = 0;
     _firstBtn.y = 0;
     _firstBtn.width = 60;
     _firstBtn.height = 30;
     
     _secondBtn.x = 60;
     _secondBtn.y = 0;
     _secondBtn.width = 60;
     _secondBtn.height = 30;
     v.y = 6;
     [self.contentView addSubview:v];
}

-(void)fitPersonInfoSettingMode
{
    _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
    _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
    
    _firstBtn.width = 96;
    _firstBtn.height = 44;
    _firstBtn.x = (__SCREEN_SIZE.width - 90)/2.0 - _firstBtn.width - 5;
    _firstBtn.y = 0;
    _secondBtn.x = (__SCREEN_SIZE.width - 90)/2.0 + 5;
    _secondBtn.y = 0;
    _secondBtn.height = 44;
    [_firstBtn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    [_secondBtn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    _secondBtn.width = 96;
    _selectLb.height = 2;
    _selectLb.width = 96;
    _selectLb.text = @"";
    _selectLb.backgroundColor = kUIColorFromRGB(color_5);
    _selectLb.hidden = NO;
    UIView *line = [self.contentView viewWithTag:4081];
    //    if (!line) {
    //        line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 44)];
    //        line.tag = 4081;
    //        line.backgroundColor = kUIColorFromRGB(color_lineColor);
    //        line.x = __SCREEN_SIZE.width / 2.0;
    //    }
    line.hidden = YES;
    [self.contentView addSubview:line];
}



-(void)fitMyActivityMode
{
    _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
    _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
    _firstBtn.x = 0;
    _firstBtn.width = __SCREEN_SIZE.width/2.0;
    _firstBtn.height = 44;
    _firstBtn.y = 0;
    _secondBtn.x = __SCREEN_SIZE.width/2.0;
    _secondBtn.y = 0;
    _secondBtn.height = 44;
    _secondBtn.width = __SCREEN_SIZE.width/2.0;
    _selectLb.height = 2;
    _selectLb.text = @"";
    _selectLb.backgroundColor = kUIColorFromRGB(color_3);
    UIView *line = [self.contentView viewWithTag:4081];
    if (!line) {
        line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 44)];
        line.tag = 4081;
        line.backgroundColor = kUIColorFromRGB(color_lineColor);
        line.x = __SCREEN_SIZE.width / 2.0;
    }
    [self.contentView addSubview:line];
}

-(void)fitCerMode
{
    self.height = 44;
    _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
    _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
    UIView *line = [self.contentView viewWithTag:4089];
    if (!line) {
        line = [[UIView alloc] initWithFrame:CGRectMake(0, 0,__SCREEN_SIZE.width, 0.5)];
        line.tag = 4089;
        line.backgroundColor = kUIColorFromRGB(color_lineColor);
    }
    [self.contentView addSubview:line];
    
    _firstBtn.x = 0;
    _firstBtn.width = __SCREEN_SIZE.width/2.0;
    _firstBtn.height = 44;
    _firstBtn.y = 0;
    _secondBtn.x = __SCREEN_SIZE.width/2.0;
    _secondBtn.y = 0;
    _secondBtn.height = 44;
    _secondBtn.width = __SCREEN_SIZE.width/2.0;
    _selectLb.hidden = YES;
    
    [_firstBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
    _firstBtn.backgroundColor = kUIColorFromRGB(color_2);
    
    [_secondBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
    _secondBtn.backgroundColor = kUIColorFromRGB(color_3);
}

-(void)fitHeadMode
{
    self.height = 55;
    _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
    _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
    UIView *line = [self.contentView viewWithTag:4089];
    if (!line) {
        line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 55)];
        line.tag = 4089;
        line.backgroundColor = kUIColorFromRGB(color_lineColor);
        line.x = __SCREEN_SIZE.width / 2.0;
    }
    [self.contentView addSubview:line];
    
    _firstBtn.x = 0;
    _firstBtn.width = __SCREEN_SIZE.width/2.0;
    _firstBtn.height = 55;
    _firstBtn.y = 0;
    _secondBtn.x = __SCREEN_SIZE.width/2.0;
    _secondBtn.y = 0;
    _secondBtn.height = 55;
    _secondBtn.width = __SCREEN_SIZE.width/2.0;
    _selectLb.hidden = YES;
    
    [_firstBtn setTitle:@"" forState:UIControlStateNormal];
    [_secondBtn setTitle:@"" forState:UIControlStateNormal];
    UILabel *tx = [_firstBtn viewWithTag:2844];
    if (!tx) {
        tx = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        tx.textColor = kUIColorFromRGB(color_1);
        tx.font = [UIFont systemFontOfSize:15];
        tx.text = @"活动";
        tx.y = _firstBtn.height/2.0 - tx.height/2.0;
        tx.x = _firstBtn.width/2.0 + 4;
        tx.tag = 2844;
    }
    [_firstBtn addSubview:tx];
    
    UIImageView *timg = [_firstBtn viewWithTag:2855];
    if (!timg) {
        timg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 27, 27)];
        timg.image = [UIImage imageContentWithFileName:@"h_activity"];
        timg.y = _firstBtn.height/2.0 - timg.height/2.0;
        timg.x = _firstBtn.width/2.0 - timg.width - 4;
        timg.tag = 2855;
    }
    [_firstBtn addSubview:timg];
    
    UILabel *tx2 = [_secondBtn viewWithTag:2846];
    if (!tx2) {
        tx2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 64, 32)];
        tx2.textColor = kUIColorFromRGB(color_1);
        tx2.font = [UIFont systemFontOfSize:15];
        tx2.text = @"政务中心";
        
        tx2.tag = 2846;
    }
    tx2.y = _secondBtn.height/2.0 - tx2.height/2.0;
    tx2.x = _secondBtn.width/2.0 - 14;
    [_secondBtn addSubview:tx2];
    
    UIImageView *timg2 = [_secondBtn viewWithTag:2856];
    if (!timg2) {
        timg2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 27, 27)];
        timg2.image = [UIImage imageContentWithFileName:@"h_center"];
        
        timg2.tag = 2856;
    }
    timg2.y = _secondBtn.height/2.0 - timg2.height/2.0;
    timg2.x = _secondBtn.width/2.0 - timg2.width - 20;
    [_secondBtn addSubview:timg2];
    _firstBtn.hidden = NO;
      line.hidden = NO;
}
-(void)fitVipCenterMode
{
     self.height = 81;
     _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;

     _firstBtn.width = 156;
     _firstBtn.height = 71;
     _firstBtn.y = 10;
     _secondBtn.height = 71;
     _secondBtn.width = 156;

     _secondBtn.x = __SCREEN_SIZE.width - 15 - _secondBtn.width;
     _secondBtn.y = 10;
     _firstBtn.x = 15;
     _selectLb.height = 2;
     _selectLb.text = @"";
     _selectLb.backgroundColor = kUIColorFromRGB(color_3);
     _selectLb.hidden = YES;

     self.backgroundColor =  kUIColorFromRGB(color_4);

     _firstBtn.backgroundColor = kUIColorFromRGB(color_2);

     _secondBtn.backgroundColor = kUIColorFromRGB(color_2);
     _firstBtn.layer.cornerRadius = 6;
     _firstBtn.layer.masksToBounds = YES;
     _firstBtn.layer.borderWidth = 1;
     if ([_dataDic[@"select"] integerValue] == 0) {
          _firstBtn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
     }
     else
          _firstBtn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     [_firstBtn fitImgAndTitleMode];
     _firstBtn.customImgV.x = 0;
     _firstBtn.customImgV.y = 0;
     _firstBtn.customImgV.width = 55;
     _firstBtn.customImgV.height = 55;
     if(_dataDic[@"aimg"])
     {
     _firstBtn.customImgV.image = [UIImage imageContentWithFileName:_dataDic[@"aimg"]];
     }
     _firstBtn.customTitleLb.text = _dataDic[@"aTitle"];
     _firstBtn.customTitleLb.font = [UIFont systemFontOfSize:18];
     _firstBtn.customTitleLb.textColor = kUIColorFromRGB(color_1);
     _firstBtn.customTitleLb.height = 18;
     _firstBtn.customTitleLb.width = _firstBtn.width;
     _firstBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     _firstBtn.customTitleLb.x = 0;
     _firstBtn.customTitleLb.y = 15;

     _firstBtn.customDetailLb.textAlignment = NSTextAlignmentCenter;
     _firstBtn.customDetailLb.textColor = kUIColorFromRGB(color_3);
     _firstBtn.customDetailLb.font = [UIFont systemFontOfSize:18];
     _firstBtn.customDetailLb.width = _firstBtn.width;
     _firstBtn.customDetailLb.x = 0;
     _firstBtn.customDetailLb.height = 18;
     _firstBtn.customDetailLb.y = _firstBtn.customTitleLb.y + _firstBtn.customTitleLb.height + 10;
 _firstBtn.customDetailLb.text = _dataDic[@"aDetail"];

     _secondBtn.layer.cornerRadius = 6;
     _secondBtn.layer.masksToBounds = YES;
     _secondBtn.layer.borderWidth = 1;
     if ([_dataDic[@"select"] integerValue] == 1) {
          _secondBtn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
     }
     else
     _secondBtn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     [_secondBtn fitImgAndTitleMode];
     _secondBtn.customImgV.x = 0;
     _secondBtn.customImgV.y = 0;
     _secondBtn.customImgV.width = 55;
     _secondBtn.customImgV.height = 55;
     if (_dataDic[@"bimg"]) {
           _secondBtn.customImgV.image = [UIImage imageContentWithFileName:_dataDic[@"bimg"]];
     }

     _secondBtn.customTitleLb.text = _dataDic[@"bTitle"];
     _secondBtn.customTitleLb.font = [UIFont systemFontOfSize:18];
     _secondBtn.customTitleLb.textColor = kUIColorFromRGB(color_1);
     _secondBtn.customTitleLb.height = 18;
     _secondBtn.customTitleLb.width = _secondBtn.width;
     _secondBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     _secondBtn.customTitleLb.x = 0;
     _secondBtn.customTitleLb.y = 15;

     _secondBtn.customDetailLb.textAlignment = NSTextAlignmentCenter;
     _secondBtn.customDetailLb.textColor = kUIColorFromRGB(color_3);
     _secondBtn.customDetailLb.font = [UIFont systemFontOfSize:18];
     _secondBtn.customDetailLb.width = _firstBtn.width;
     _secondBtn.customDetailLb.x = 0;
     _secondBtn.customDetailLb.height = 18;
     _secondBtn.customDetailLb.y = _secondBtn.customTitleLb.y + _secondBtn.customTitleLb.height + 10;
     _secondBtn.customDetailLb.text = _dataDic[@"bDetail"];
}

-(void)fitVipCenterModeB
{
     self.height = 46;
     _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;

     _firstBtn.width = 118;
     _firstBtn.height = 31;
     _firstBtn.y = 7;
     _secondBtn.height = 31;
     _secondBtn.width = 118;

     _secondBtn.x = __SCREEN_SIZE.width - _secondBtn.width - 29;
     _secondBtn.y = 7;
     _firstBtn.x = 29;
     _selectLb.height = 2;
     _selectLb.text = @"";
     _selectLb.backgroundColor = kUIColorFromRGB(color_3);
     _selectLb.hidden = YES;

     self.backgroundColor =  kUIColorFromRGB(color_2);
     _secondBtn.backgroundColor = kUIColorFromRGB(color_3);
     _firstBtn.backgroundColor = kUIColorFromRGB(color_3);
     [_firstBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     [_secondBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     _firstBtn.titleLabel.font = [UIFont systemFontOfSize:15];
     _secondBtn.titleLabel.font = [UIFont systemFontOfSize:15];

     _firstBtn.layer.cornerRadius = 6;
     _firstBtn.layer.masksToBounds = YES;
     
     _secondBtn.layer.cornerRadius = 6;
     _secondBtn.layer.masksToBounds = YES;

}
-(void)fitHeadModeB
{
    self.height = 55;
    _firstBtn.hidden = YES;
//    _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
    _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
    UIView *line = [self.contentView viewWithTag:4089];
    if (!line) {
        line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 55)];
        line.tag = 4089;
        line.backgroundColor = kUIColorFromRGB(color_lineColor);
        line.x = __SCREEN_SIZE.width / 2.0;
    }
    [self.contentView addSubview:line];
    line.hidden = YES;
//    _firstBtn.x = 0;
//    _firstBtn.width = __SCREEN_SIZE.width/2.0;
//    _firstBtn.height = 55;
//    _firstBtn.y = 0;
    _secondBtn.x = 0;
    _secondBtn.y = 0;
    _secondBtn.height = 55;
    _secondBtn.width = __SCREEN_SIZE.width;
    _selectLb.hidden = YES;
    
//    [_firstBtn setTitle:@"" forState:UIControlStateNormal];
    [_secondBtn setTitle:@"" forState:UIControlStateNormal];
//    UILabel *tx = [_firstBtn viewWithTag:2844];
//    if (!tx) {
//        tx = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
//        tx.textColor = kUIColorFromRGB(color_1);
//        tx.font = [UIFont systemFontOfSize:15];
//        tx.text = @"活动";
//        tx.y = _firstBtn.height/2.0 - tx.height/2.0;
//        tx.x = _firstBtn.width/2.0 + 4;
//        tx.tag = 2844;
//    }
//    [_firstBtn addSubview:tx];
    
//    UIImageView *timg = [_firstBtn viewWithTag:2855];
//    if (!timg) {
//        timg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 27, 27)];
//        timg.image = [UIImage imageContentWithFileName:@"h_activity"];
//        timg.y = _firstBtn.height/2.0 - timg.height/2.0;
//        timg.x = _firstBtn.width/2.0 - timg.width - 4;
//        timg.tag = 2855;
//    }
//    [_firstBtn addSubview:timg];
    
    UILabel *tx2 = [_secondBtn viewWithTag:2846];
    if (!tx2) {
        tx2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 64, 32)];
        tx2.textColor = kUIColorFromRGB(color_1);
        tx2.font = [UIFont systemFontOfSize:15];
       
        tx2.tag = 2846;
    }
    tx2.text = @"政务中心";
    tx2.y = _secondBtn.height/2.0 - tx2.height/2.0;
    tx2.x = _secondBtn.width/2.0 - 14;
    [_secondBtn addSubview:tx2];
    
    UIImageView *timg2 = [_secondBtn viewWithTag:2856];
    if (!timg2) {
        timg2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 27, 27)];
        timg2.image = [UIImage imageContentWithFileName:@"h_center"];
       
        timg2.tag = 2856;
    }
    timg2.y = _secondBtn.height/2.0 - timg2.height/2.0;
    timg2.x = _secondBtn.width/2.0 - timg2.width - 20;
    [_secondBtn addSubview:timg2];
    
}


-(void)fitRepairsMode{
    _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
    _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
    _firstBtn.x = 0;
    _firstBtn.width = __SCREEN_SIZE.width/2.0;
    _firstBtn.height = 44;
    _firstBtn.y = 0;
    _secondBtn.x = __SCREEN_SIZE.width/2.0;
    _secondBtn.y = 0;
    _secondBtn.height = 44;
    _secondBtn.width = __SCREEN_SIZE.width/2.0;
    
    _selectLb.backgroundColor = kUIColorFromRGB(color_3);
    UIView *line = [self.contentView viewWithTag:4081];
    if (!line) {
        line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 44)];
        line.tag = 4081;
        line.backgroundColor = kUIColorFromRGB(color_lineColor);
        line.x = __SCREEN_SIZE.width / 2.0;
    }
    [self.contentView addSubview:line];
    _selectLb.height = 1.5;
    _selectLb.y = 42.5;
}

-(void)fitOrderMode
{
    self.height = 50;
    _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
    _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
   
    _firstBtn.width = 90;
    _firstBtn.height = 34;
    _firstBtn.y = 6;
    _secondBtn.height = 34;
    _secondBtn.width = 90;
    _secondBtn.x = __SCREEN_SIZE.width - 15 - _secondBtn.width;
    _secondBtn.y = 6;
     _firstBtn.x = __SCREEN_SIZE.width - _secondBtn.width - 30 - _firstBtn.width;
    _selectLb.height = 2;
    _selectLb.text = @"";
    _selectLb.backgroundColor = kUIColorFromRGB(color_3);
    _selectLb.hidden = YES;
    UIView *line = [self.contentView viewWithTag:4081];
    //    if (!line) {
    //        line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 44)];
    //        line.tag = 4081;
    //        line.backgroundColor = kUIColorFromRGB(color_lineColor);
    //        line.x = __SCREEN_SIZE.width / 2.0;
    //    }
    line.hidden = YES;
    [self.contentView addSubview:line];
    self.backgroundColor =  kUIColorFromRGB(color_4);
    [_firstBtn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    _firstBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _firstBtn.backgroundColor = kUIColorFromRGB(color_4);
    [_secondBtn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    _secondBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _secondBtn.backgroundColor = kUIColorFromRGB(color_4);
    _firstBtn.layer.cornerRadius = 3;
    _firstBtn.layer.masksToBounds = YES;
    _firstBtn.layer.borderWidth = 0.5;
    _firstBtn.layer.borderColor = kUIColorFromRGB(color_5).CGColor;
    
    _secondBtn.layer.cornerRadius = 3;
    _secondBtn.layer.masksToBounds = YES;
    _secondBtn.layer.borderWidth = 0.5;
        _secondBtn.layer.borderColor = kUIColorFromRGB(color_5).CGColor;
}

-(void)fitClassRegOrderMode
{
    [self fitOrderMode];
    _firstBtn.hidden = YES;
//    _secon dBtn.x = __SCREEN_SIZE.width - 15 - _secondBtn.width;
}

-(void)fitMyAccountMode
{
    self.height = 75;
    self.backgroundColor = kUIColorFromRGB(color_4);
    _firstBtn.height = 30;
    _firstBtn.width = 80;
    _firstBtn.layer.borderColor = kUIColorFromRGB(color_5).CGColor;
    [_firstBtn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    _firstBtn.layer.cornerRadius = 3;
    _firstBtn.layer.masksToBounds = YES;
    _firstBtn.layer.borderWidth = 0.5;
    _firstBtn.x = (__SCREEN_SIZE.width)/2.0 - _firstBtn.width - 5;
    _firstBtn.y = 25;
    _firstBtn.backgroundColor = kUIColorFromRGB(color_4);
    _selectLb.width = 50;
    _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
    _secondBtn.y = _firstBtn.y;
    [_secondBtn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    _secondBtn.backgroundColor = kUIColorFromRGB(color_mainTheme) ;
    _secondBtn.height = 30;
    _secondBtn.width = 80;
    _secondBtn.layer.cornerRadius = 3;
    _secondBtn.layer.masksToBounds = YES;
    _secondBtn.x = _firstBtn.x + _firstBtn.width + 10;
//    _secondBtn.layer.borderWidth = 0.5;
    
    
}

-(void)fitMyInviteMode
{
    self.height = 40;
    self.backgroundColor = kUIColorFromRGB(color_4);
    _firstBtn.height = 39;
    _firstBtn.width = __SCREEN_SIZE.width/2.0;
//    _firstBtn.layer.borderColor = kUIColorFromRGB(color_5).CGColor;
    [_firstBtn setTitleColor:kUIColorFromRGB(color_mainTheme) forState:UIControlStateNormal];
//    _firstBtn.layer.cornerRadius = 3;
//    _firstBtn.layer.masksToBounds = YES;
//    _firstBtn.layer.borderWidth = 0.5;
    _firstBtn.x = 0;//(__SCREEN_SIZE.width - 60)/2.0 - _firstBtn.width - 5;
    _firstBtn.y = 0;
    _selectLb.width = __SCREEN_SIZE.width/2.0;
    _selectLb.height = 2;
    _selectLb.text = @"";
    _selectLb.y = 38;
    _selectLb.backgroundColor = kUIColorFromRGB(color_mainTheme);
    _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
    _secondBtn.y = _firstBtn.y;
    [_secondBtn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    _selectTitleColor = kUIColorFromRGB(color_mainTheme);
    _unSelectBgColor = kUIColorFromRGB(color_4);
    _selectBgColor = kUIColorFromRGB(color_4);
    _secondBtn.backgroundColor = _unSelectBgColor;
    _firstBtn.backgroundColor = _unSelectBgColor;
//    _secondBtn.backgroundColor = kUIColorFromRGB(color_mainTheme) ;
    _secondBtn.height = _firstBtn.height;
    _secondBtn.width = _firstBtn.width;
//    _secondBtn.layer.cornerRadius = 3;
//    _secondBtn.layer.masksToBounds = YES;
    _secondBtn.x = _firstBtn.x + _firstBtn.width;
    //    _secondBtn.layer.borderWidth = 0.5;
    
    
}
-(void)fitCheckAddressMode:(BOOL)isCheck
{
    self.height = 30;
//    self.backgroundColor = kUIColorFromRGB(color_4);
    _firstBtn.height = 30;
    _firstBtn.width = 100;
    //    _firstBtn.layer.borderColor = kUIColorFromRGB(color_5).CGColor;
    [_firstBtn setTitleColor:kUIColorFromRGB(color_mainTheme) forState:UIControlStateNormal];
    //    _firstBtn.layer.cornerRadius = 3;
    //    _firstBtn.layer.masksToBounds = YES;
    //    _firstBtn.layer.borderWidth = 0.5;
    _firstBtn.x = 15;//(__SCREEN_SIZE.width - 60)/2.0 - _firstBtn.width - 5;
    _firstBtn.y = 0;
    _selectLb.hidden = YES;
    _firstBtn.customTitleLb.font = [UIFont systemFontOfSize:13];
    [_firstBtn fitImgAndTitleMode];
    _firstBtn.customImgV.height = 19.5;
    _firstBtn.customImgV.width = 19.5;
    _firstBtn.customImgV.x = 0;
    _firstBtn.customImgV.y = 5;
    _firstBtn.customTitleLb.x = 30;
    _firstBtn.customTitleLb.y = _firstBtn.height/2.0 - _firstBtn.customTitleLb.height/2.0;
    _firstBtn.customTitleLb.textAlignment = NSTextAlignmentLeft;
    
    _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
    _secondBtn.height = _firstBtn.height;
    _secondBtn.width = 70;
    _secondBtn.y = 0;
     [_secondBtn fitImgAndTitleMode];
    _secondBtn.customImgV.height = 19.5;
    _secondBtn.customImgV.width = 19.5;
    _secondBtn.customImgV.x = 10;
    _secondBtn.customImgV.y = 5;
    _secondBtn.customImgV.image = [UIImage imageContentWithFileName:@"iconfontdel"];
     _secondBtn.customTitleLb.x = _secondBtn.width - _secondBtn.customTitleLb.width;
     _secondBtn.customTitleLb.font = [UIFont systemFontOfSize:13];
    _secondBtn.customTitleLb.y = _firstBtn.height/2.0 - _firstBtn.customTitleLb.height/2.0;
    _secondBtn.customTitleLb.textAlignment = NSTextAlignmentRight;
    _secondBtn.x = __SCREEN_SIZE.width - 15 - _secondBtn.width;
       _secondBtn.customTitleLb.y = _secondBtn.height/2.0 - _secondBtn.customTitleLb.height/2.0;
    if (isCheck) {
        _secondBtn.customTitleLb.textColor = kUIColorFromRGB(color_8);
        _firstBtn.customImgV.image = [UIImage imageContentWithFileName:@"checked"];
    }
    else
    {
     _secondBtn.customTitleLb.textColor = kUIColorFromRGB(color_1);
         _firstBtn.customImgV.image = [UIImage imageContentWithFileName:@"unCheck"];
    }
    _selectTitleColor = kUIColorFromRGB(color_1);
    _unSelectBgColor =  [UIColor clearColor];
    _selectBgColor =  [UIColor clearColor];
    _normalTitleColor = kUIColorFromRGB(color_1);
    _secondBtn.backgroundColor = [UIColor clearColor];
    _firstBtn.backgroundColor =  [UIColor clearColor];
    //    _secondBtn.backgroundColor = kUIColorFromRGB(color_mainTheme) ;

    //    _secondBtn.layer.cornerRadius = 3;
    //    _secondBtn.layer.masksToBounds = YES;
//    _secondBtn.x = _firstBtn.x + _firstBtn.width;

}

-(void)fitOrderInfoForTeacherModeB
{
    [self fitOrderMode];
    if ([_secondBtn.titleLabel.text isEqualToString:@"订单处理"]) {
        [_secondBtn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
        _secondBtn.layer.borderWidth = 0;
        _secondBtn.backgroundColor = kUIColorFromRGB(color_mainTheme);
    }
  
}

-(void)fitOrderInfoForTeacherMode
{
     [self fitOrderMode];
    _firstBtn.hidden = YES;
}

-(void)fitTaskCenterMode
{
     self.height = 45;
     _firstBtn.height = 44;
     _firstBtn.width = __SCREEN_SIZE.width/2.0;
     _secondBtn.width =  _firstBtn.width;
//     [_firstBtn setTitleColor:kUIColorFromRGB(color_mainTheme) forState:UIControlStateNormal];
         _firstBtn.x = 0;//(__SCREEN_SIZE.width - 60)/2.0 - _firstBtn.width - 5;
     _firstBtn.y = 0;
     _selectLb.hidden = YES;
     _firstBtn.customTitleLb.font = [UIFont systemFontOfSize:13];
     [_firstBtn fitImgAndTitleMode];
     [self setBtnFitMode:_firstBtn withDetail:_dataDic[@"aDetail"]];
    
     
     
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _secondBtn.height = _firstBtn.height;
//     _secondBtn.width = 70;
     _secondBtn.y = 0;
     [_secondBtn fitImgAndTitleMode];
  [self setBtnFitMode:_secondBtn withDetail:_dataDic[@"bDetail"]];
     _secondBtn.x = __SCREEN_SIZE.width/2.0;
     UIView *line = [self.contentView viewWithTag:4081];
     if (!line) {
          line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 45)];
          line.tag = 4081;
          line.backgroundColor = kUIColorFromRGB(color_lineColor);
          line.x = __SCREEN_SIZE.width / 2.0;
     }
     [self.contentView addSubview:line];
          _selectTitleColor = kUIColorFromRGB(color_5);
     _unSelectBgColor =  [UIColor clearColor];
     _selectBgColor =  [UIColor clearColor];
     _normalTitleColor = kUIColorFromRGB(color_5);
     _secondBtn.backgroundColor = kUIColorFromRGB(color_2);
     _firstBtn.backgroundColor =  kUIColorFromRGB(color_2);
     
}
-(void)setBtnFitMode:(UIButton *)btn withDetail:(NSString *)detail
{
     btn.customTitleLb.x = btn.width/2.0 - btn.customTitleLb.width/2.0;
     btn.customTitleLb.y = 7;
     btn.customTitleLb.font = [UIFont systemFontOfSize:13];
     btn.customTitleLb.textColor = kUIColorFromRGB(color_1);
     btn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     
     btn.customDetailLb.text = detail;
     btn.customDetailLb.x = btn.width/2.0 - btn.customDetailLb.width/2.0;
     btn.customDetailLb.y = 29;
     btn.customDetailLb.font = [UIFont systemFontOfSize:13];
     btn.customDetailLb.textColor = kUIColorFromRGB(color_3);
     btn.customDetailLb.height = 13;
       btn.customDetailLb.textAlignment = NSTextAlignmentCenter;
}

-(void)fitModiPhoneMode:(NSInteger)index
{
     self.height = 40;
     _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _firstBtn.x = 0;
     _firstBtn.width = __SCREEN_SIZE.width/2.0;
     _firstBtn.height = 30;
     _firstBtn.y = 0;
     _secondBtn.x = __SCREEN_SIZE.width/2.0;
     _secondBtn.y = 0;
     _secondBtn.height = 30;
     _secondBtn.width = __SCREEN_SIZE.width/2.0;
     if (index == 0) {
          [_firstBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
           [_secondBtn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
                 [_firstBtn addSubview:_selectLb];
     }
     else
     {
            [_firstBtn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
      [_secondBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
          [_secondBtn addSubview:_selectLb];
     }
     _selectLb.backgroundColor = kUIColorFromRGB(color_3);
     _selectLb.width = __SCREEN_SIZE.width/2.0 - 56;
//     UIView *line = [self.contentView viewWithTag:4081];
//     if (!line) {
//          line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 44)];
//          line.tag = 4081;
//          line.backgroundColor = kUIColorFromRGB(color_lineColor);
//          line.x = __SCREEN_SIZE.width / 2.0;
//     }
//     [self.contentView addSubview:line];
     _selectLb.height = 1.5;
     _selectLb.y = 29.5;
     _selectLb.x = 28;
     _firstBtn.backgroundColor = kUIColorFromRGB(color_2);
     _secondBtn.backgroundColor = kUIColorFromRGB(color_2);
     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
}

-(void)fitSeverCenterMode
{
     self.height = 60;
     _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _firstBtn.height = 35;
     _firstBtn.width = (__SCREEN_SIZE.width - 120)/2.0;//120;// __SCREEN_SIZE.width/2.0;
     _secondBtn.width =  _firstBtn.width;
          [_firstBtn setTitleColor:kUIColorFromRGB(color_0xf82D45) forState:UIControlStateNormal];
     _firstBtn.x = 45;
     _firstBtn.y = 15;
     _selectLb.hidden = YES;
//     _firstBtn.customTitleLb.font = [UIFont systemFontOfSize:13];
//     [_firstBtn fitImgAndTitleMode];
//     [self setBtnFitMode:_firstBtn withImg:_dataDic[@"aimg"]];
     _firstBtn.layer.cornerRadius = 6;
     _firstBtn.layer.borderWidth = 0.5;
     _firstBtn.layer.borderColor = kUIColorFromRGB(color_0xf82D45).CGColor;

     
     
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _secondBtn.height = _firstBtn.height;
          _secondBtn.width = 120;
     _secondBtn.y = 15;
     _secondBtn.backgroundColor = kUIColorFromRGB(color_0xf74056);
    [_secondBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     _secondBtn.layer.cornerRadius = 6;
//     [_secondBtn fitImgAndTitleMode];
//     [self setBtnFitMode:_secondBtn withImg:_dataDic[@"bimg"]];
     _secondBtn.x = __SCREEN_SIZE.width/2.0 + 15;
//     UIView *line = [self.contentView viewWithTag:4081];
//     if (!line) {
//          line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 60)];
//          line.tag = 4081;
//          line.backgroundColor = kUIColorFromRGB(color_lineColor);
//          line.x = __SCREEN_SIZE.width / 2.0;
//     }
//     [self.contentView addSubview:line];
     _selectTitleColor = kUIColorFromRGB(color_1);
     _unSelectBgColor =  [UIColor clearColor];
     _selectBgColor =  [UIColor clearColor];
     _normalTitleColor = kUIColorFromRGB(color_1);
//     _secondBtn.backgroundColor = kUIColorFromRGB(color_2);
     _firstBtn.backgroundColor =  kUIColorFromRGB(color_2);
}

-(void)setBtnFitMode:(UIButton *)btn withImg:(NSString *)img
{
     btn.height = 60;
     btn.customTitleLb.x = btn.width/2.0 - btn.customTitleLb.width/2.0;
     btn.customTitleLb.y = 38;
     btn.customTitleLb.height = 13;
     btn.customTitleLb.font = [UIFont systemFontOfSize:13];
     btn.customTitleLb.textColor = kUIColorFromRGB(color_1);
     btn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     
     btn.customImgV.image = [UIImage imageContentWithFileName:img];
     btn.customImgV.height = 22;
     btn.customImgV.width = 22;
     btn.customImgV.x = btn.width/2.0 - btn.customImgV.width/2.0;
     btn.customImgV.y = 10;
   }

-(void)fitSignMode
{
     self.height = 116;
     _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     UIImageView *imgv2 = [self.contentView viewWithTag:974];
     if (!imgv2) {
          imgv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, self.height)];
          imgv2.tag = 974;
          
          imgv2.y = 0;
     }
     
     //    if (upDown) {
     imgv2.image = [UIImage imageContentWithFileName:_dataDic[@"bgImg"]];
     [self.contentView insertSubview:imgv2 atIndex:0];
     [_firstBtn setBackgroundColor:[UIColor clearColor]];
     [_secondBtn setBackgroundColor:[UIColor clearColor]];
     _firstBtn.height = 61;
     _firstBtn.width = 61;
     _firstBtn.x = __SCREEN_SIZE.width/2.0 - _firstBtn.width/2.0;
     _firstBtn.y = 15;
     [_firstBtn fitImgAndTitleMode];
     _firstBtn.customImgV.y = 0;
     _firstBtn.customImgV.width = 61;
     _firstBtn.customImgV.height = 61;
     _firstBtn.customImgV.x = _firstBtn.width/2.0 - _firstBtn.customImgV.width/2.0;
     _firstBtn.customImgV.image = [UIImage imageContentWithFileName:_dataDic[@"img"]];
     
     [_firstBtn sendSubviewToBack:_firstBtn.customImgV];
     _firstBtn.customTitleLb.y = 37;
     _firstBtn.customTitleLb.width = 45;
     _firstBtn.customTitleLb.height = 10;
     _firstBtn.customTitleLb.text = _dataDic[@"tab1"];
     _firstBtn.customTitleLb.font = [UIFont systemFontOfSize:10];
     _firstBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     _firstBtn.customTitleLb.x = _firstBtn.width/2.0 - _firstBtn.customTitleLb.width/2.0;
     _firstBtn.customTitleLb.textColor = kUIColorFromRGB(color_3);

     _secondBtn.width = __SCREEN_SIZE.width;
     _secondBtn.height = 12;
     _secondBtn.titleLabel.font = [UIFont systemFontOfSize:12];
     [_secondBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     _secondBtn.x = 0;
     _secondBtn.y = _firstBtn.y + _firstBtn.height + 11;
     _selectLb.hidden = YES;
}

-(void)fitAwardDetailMode
{
     _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     
     [self setBtnFitModeD:_firstBtn withImg:_dataDic[@"aimg"] withTitle:_dataDic[@"tab1"] withDetail:_dataDic[@"aDetail"]];
     [self setBtnFitModeD:_secondBtn withImg:_dataDic[@"bimg"] withTitle:_dataDic[@"tab2"] withDetail:_dataDic[@"bDetail"]];
     _firstBtn.y = 0;
     _secondBtn.y = 0;
     _firstBtn.x = __SCREEN_SIZE.width/4.0 - _firstBtn.width/2.0;
     
     _secondBtn.x = __SCREEN_SIZE.width/2.0 + _firstBtn.x;
     
     _selectLb.hidden = YES;
     self.height = 41;
}

-(void)fitInvGetGiftMode
{
     _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;

     [self setBtnFitModeD:_firstBtn withImg:_dataDic[@"aimg"] withTitle:_dataDic[@"tab1"] withDetail:_dataDic[@"aDetail"]];
     [self setBtnFitModeD:_secondBtn withImg:_dataDic[@"bimg"] withTitle:_dataDic[@"tab2"] withDetail:_dataDic[@"bDetail"]];
     _firstBtn.y = 0;
     _secondBtn.y = 0;
     _firstBtn.x = __SCREEN_SIZE.width/4.0 - _firstBtn.width/2.0;
     
     _secondBtn.x = __SCREEN_SIZE.width/2.0 + _firstBtn.x;
     
     _selectLb.hidden = YES;
     _secondBtn.userInteractionEnabled = NO;
     _firstBtn.userInteractionEnabled = NO;
}

-(void)setBtnFitModeD:(UIButton *)btn withImg:(NSString *)img withTitle:(NSString *)title withDetail:(NSString *)detail
{
     
     [btn fitImgAndTitleMode];
     btn.height = 41;
     btn.width = 90;//__SCREEN_SIZE.width/2.0;
     btn.customTitleLb.x = 31;//btn.width/2.0 - btn.customTitleLb.width/2.0;
     btn.customTitleLb.y = 8;
     btn.customTitleLb.height = 13;
     btn.customTitleLb.font = [UIFont systemFontOfSize:13];
     btn.customTitleLb.textColor = kUIColorFromRGB(color_5);
     btn.customTitleLb.textAlignment = NSTextAlignmentLeft;
     btn.customTitleLb.width = 54;
     
     btn.customImgV.image = [UIImage imageContentWithFileName:img];
     btn.customImgV.height = 18;
     btn.customImgV.width = 17;
     btn.customImgV.x = 0;
     btn.customImgV.y = 12;
     btn.customImgV.contentMode = UIViewContentModeCenter;
     
     btn.customDetailLb.width = 68;
     btn.customDetailLb.height = 13;
     btn.customDetailLb.font = [UIFont systemFontOfSize:13];
     btn.customDetailLb.textColor = kUIColorFromRGB(color_3);
     btn.customDetailLb.text = detail;
     if ([btn.customDetailLb.text containsString:@"人"]) {
          btn.customDetailLb.attributedText = [btn.customDetailLb richText:[UIFont systemFontOfSize:13] text:@"人" color:kUIColorFromRGB(color_5)];

     }
     else if ([btn.customDetailLb.text containsString:@"元"]) {
        btn.customDetailLb.attributedText = [btn.customDetailLb richText:[UIFont systemFontOfSize:13] text:@"元" color:kUIColorFromRGB(color_5)];
     }
     btn.customDetailLb.x = 31;//btn.width/2.0 - btn.customTitleLb.width/2.0;
     btn.customDetailLb.y = 24;
     btn.customDetailLb.textAlignment = NSTextAlignmentLeft;
     
}
-(void)fitVIPHelpMode
{
     _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     
     _firstBtn.width = 83;
     _firstBtn.height = 44;
     _firstBtn.x = (__SCREEN_SIZE.width - 90)/2.0 - _firstBtn.width - 5;
     _firstBtn.y = 0;
     _secondBtn.x = (__SCREEN_SIZE.width - 90)/2.0 + 5;
     _secondBtn.y = 0;
     _secondBtn.height = 44;
     [_firstBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     _firstBtn.titleLabel.font = [UIFont systemFontOfSize:15];
_secondBtn.titleLabel.font = [UIFont systemFontOfSize:15];
     [_secondBtn setTitleColor:kUIColorFromRGB(color_0xff6b38) forState:UIControlStateNormal];
     //     _secondBtn.width = 50;
     //     _selectLb.height = 2;
     //     _selectLb.text = @"";
     //     _selectLb.backgroundColor = kUIColorFromRGB(color_5);
     _selectLb.hidden = YES;
     UIView *v = [self.contentView viewWithTag:4081];
     if (!v) {
          v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 166, 30)];
          v.tag = 4081;
          v.backgroundColor = kUIColorFromRGB(color_3);
          v.x = 0;
     }
     v.layer.cornerRadius = 6;
     v.layer.masksToBounds = YES;
     [v addSubview:_firstBtn];
     [v addSubview:_secondBtn];
     _normalTitleColor = kUIColorFromRGB(color_0xff6b38);
     _selectTitleColor = kUIColorFromRGB(color_2);
     _firstBtn.x = 0;
     _firstBtn.y = 0;
     _firstBtn.width = 83;
     _firstBtn.height = 30;
     
     _secondBtn.x = 83;
     _secondBtn.y = 0;
     _secondBtn.width = 83;
     _secondBtn.height = 30;
     v.y = 6;
     [self.contentView addSubview:v];
}
-(void)fitMySecHandDealMode
{
     self.height = 86;
     _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;

     _firstBtn.width = 131;
     _firstBtn.height = 71;
     _firstBtn.y = 7;
     _secondBtn.height = 71;
     _secondBtn.width = 131;

     _secondBtn.x = __SCREEN_SIZE.width - 35 - _secondBtn.width;
     _firstBtn.x = 35;
     if(__SCREEN_SIZE.width == 320)
     {
          _secondBtn.x = __SCREEN_SIZE.width - 20 - _secondBtn.width;
          _firstBtn.x = 20;
     }
     _secondBtn.y = 7;

     _selectLb.height = 2;
     _selectLb.text = @"";
     _selectLb.backgroundColor = kUIColorFromRGB(color_3);
     _selectLb.hidden = YES;

     self.backgroundColor =  kUIColorFromRGB(color_2);

     _firstBtn.backgroundColor = kUIColorFromRGB(color_2);

     _secondBtn.backgroundColor = kUIColorFromRGB(color_2);
     _firstBtn.layer.cornerRadius = 6;
     _firstBtn.layer.masksToBounds = YES;


     [_firstBtn fitImgAndTitleMode];
     _firstBtn.customImgV.x = 0;
     _firstBtn.customImgV.y = 0;
     _firstBtn.customImgV.width = _firstBtn.width;
     _firstBtn.customImgV.height = _firstBtn.height;

     _firstBtn.customImgV.image = [UIImage imageContentWithFileName:_dataDic[@"aimg"]];

     _firstBtn.customTitleLb.text = _dataDic[@"aTitle"];
     _firstBtn.customTitleLb.font = [UIFont systemFontOfSize:15];
     _firstBtn.customTitleLb.textColor = kUIColorFromRGB(color_2);
     _firstBtn.customTitleLb.height = 18;
     _firstBtn.customTitleLb.width = _firstBtn.width;
     _firstBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     _firstBtn.customTitleLb.x = 0;
     _firstBtn.customTitleLb.y = 48;
  [_firstBtn bringSubviewToFront:_firstBtn.customTitleLb];


     _secondBtn.layer.cornerRadius = 6;
     _secondBtn.layer.masksToBounds = YES;


     [_secondBtn fitImgAndTitleMode];
     _secondBtn.customImgV.x = 0;
     _secondBtn.customImgV.y = 0;
     _secondBtn.customImgV.width = _secondBtn.width;
     _secondBtn.customImgV.height = _secondBtn.height;

          _secondBtn.customImgV.image = [UIImage imageContentWithFileName:_dataDic[@"bimg"]];
   
     _secondBtn.customTitleLb.text = _dataDic[@"bTitle"];
     _secondBtn.customTitleLb.font = [UIFont systemFontOfSize:15];
     _secondBtn.customTitleLb.textColor = kUIColorFromRGB(color_2);
     _secondBtn.customTitleLb.height = 18;
     _secondBtn.customTitleLb.width = _secondBtn.width;
     _secondBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     _secondBtn.customTitleLb.x = 0;
     _secondBtn.customTitleLb.y = 48;
     [_secondBtn bringSubviewToFront:_secondBtn.customTitleLb];

}
-(void)fitMySecHandDealModeB
{
     self.height = 27;
     _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _firstBtn.x = 15;
     _firstBtn.width = 100;
     _firstBtn.height = 27;
     _firstBtn.y = 5;
     _firstBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
     [_firstBtn setTitleColor:kUIColorFromRGB(color_1) forState:UIControlStateNormal];
     _firstBtn.titleLabel.font = [UIFont systemFontOfSize:15];

     _secondBtn.height = 27;
     _secondBtn.width = 100;
     _secondBtn.x = __SCREEN_SIZE.width -15 - _secondBtn.width;
     _secondBtn.y = 0;
     _secondBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
     [_secondBtn fitImgAndTitleMode];
     _secondBtn.customImgV.x =  _secondBtn.width - 15;
     _secondBtn.customImgV.y = 11;
     _secondBtn.customImgV.width = 15;
     _secondBtn.customImgV.height = 15;

     _secondBtn.customImgV.image = [UIImage imageContentWithFileName:_dataDic[@"img"]];

     _secondBtn.customTitleLb.text = _dataDic[@"tab2"];
     _secondBtn.customTitleLb.font = [UIFont systemFontOfSize:12];
     _secondBtn.customTitleLb.textColor = kUIColorFromRGB(color_1);
     _secondBtn.customTitleLb.height = 12;
     _secondBtn.customTitleLb.width = _secondBtn.width - 25;
     _secondBtn.customTitleLb.textAlignment = NSTextAlignmentRight;
     _secondBtn.customTitleLb.x = 0;
     _secondBtn.customTitleLb.y = 13;
     _selectLb.height = 2;
     _selectLb.text = @"";
     _selectLb.backgroundColor = kUIColorFromRGB(color_3);
     _selectLb.hidden = YES;
}
-(void)fitToDoorRecycleMode
{
     self.height = 51;
     _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;

     _firstBtn.width = 91;
     _firstBtn.height = 31;
     _firstBtn.x  = 92;
     _firstBtn.y = 10;

     _firstBtn.layer.cornerRadius = 6;
     _firstBtn.layer.masksToBounds = YES;
     _secondBtn.height = 31;
     _secondBtn.width = 91;
     _secondBtn.x = _firstBtn.x + _firstBtn.width  + 15;
     _secondBtn.y = 10;

     _secondBtn.layer.cornerRadius = 6;
     _secondBtn.layer.masksToBounds = YES;

     _selectLb.backgroundColor = kUIColorFromRGB(color_3);
     _selectLb.hidden = YES;

     if ([_dataDic[@"select"] integerValue] == 0) {
          [_firstBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          _firstBtn.layer.borderWidth = 0;
          _firstBtn.backgroundColor = kUIColorFromRGB(color_3);

          _secondBtn.backgroundColor = kUIColorFromRGB(color_2);
          _secondBtn.layer.borderColor = kUIColorFromRGB(color_8).CGColor;
       [_secondBtn setTitleColor:kUIColorFromRGB(color_8) forState:UIControlStateNormal];
                 _secondBtn.layer.borderWidth = 0.5;
     }
     else
     {
             [_secondBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
                 _secondBtn.layer.borderWidth = 0;
     _secondBtn.backgroundColor = kUIColorFromRGB(color_3);

          _firstBtn.backgroundColor = kUIColorFromRGB(color_2);
          _firstBtn.layer.borderColor = kUIColorFromRGB(color_8).CGColor;
          [_firstBtn setTitleColor:kUIColorFromRGB(color_8) forState:UIControlStateNormal];
          _firstBtn.layer.borderWidth = 0.5;
     }
     UILabel *vx = [self.contentView viewWithTag:2944];
     if (!vx) {
          vx = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 69, 20)];
          vx.textColor = kUIColorFromRGB(color_1);
          vx.font = [UIFont systemFontOfSize:15];
          vx.textAlignment = NSTextAlignmentLeft;
          vx.y = self.height/2.0 - vx.height/2.0;
          vx.x = 15;
          vx.tag = 2944;
     }
     vx.text = _dataDic[@"title"];
     [self.contentView addSubview:vx];
}

-(void)fitReplacementConfirmModeB
{
     [self fitPublishSecHandMode];
     self.height = 41;
     //      _firstBtn.y = 6;
     //      _secondBtn.y = 6;
     UILabel *vx = [self.contentView viewWithTag:2944];
     vx.y = self.height/2.0 - vx.height/2.0;

     UILabel *tx = [self.contentView viewWithTag:2844];
     tx.font = [UIFont systemFontOfSize:15];
     tx.height = 15;

     UILabel *gx = [self.contentView viewWithTag:2849];
     if (!gx) {
          gx = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 13)];
          gx.textColor = kUIColorFromRGB(color_7);
          gx.font = [UIFont systemFontOfSize:13];

          gx.tag = 2849;
          [self.contentView addSubview:gx];
     }
     gx.text = _dataDic[@"detail"];
     [gx sizeToFit];
//     gx.x= 15;
     gx.y = self.height/2.0 - gx.height/2.0;
          gx.x = __SCREEN_SIZE.width - 106 - gx.width;
          if (__SCREEN_SIZE.width == 320) {
                    gx.x = __SCREEN_SIZE.width - 78 - gx.width;
          }

     //
     //
     //          gx.y =  self.height/2.0 - gx.height/2.0;
     //          tx.y = self.height/2.0 - tx.height/2.0;

     _firstBtn.y = self.height/2.0 - _firstBtn.height/2.0;
     _secondBtn.y = self.height/2.0 - _secondBtn.height/2.0;
}

-(void)fitReplacementConfirmMode
{
     [self fitPublishSecHandMode];
      self.height = 60;
//      _firstBtn.y = 6;
//      _secondBtn.y = 6;
     UILabel *vx = [self.contentView viewWithTag:2944];
        vx.y = self.height/2.0 - vx.height/2.0;

     UILabel *tx = [self.contentView viewWithTag:2844];
     tx.font = [UIFont systemFontOfSize:15];
     tx.height = 15;

     UILabel *gx = [self.contentView viewWithTag:2849];
     if (!gx) {
          gx = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 13)];
          gx.textColor = kUIColorFromRGB(color_7);
          gx.font = [UIFont systemFontOfSize:13];

          gx.tag = 2849;
          [self.contentView addSubview:gx];
     }
     gx.text = _dataDic[@"detail"];
     [gx sizeToFit];
     gx.x = 15;
     gx.y = tx.y + tx.height +10;
//     gx.x = __SCREEN_SIZE.width - 106 - gx.width;
//     if (__SCREEN_SIZE.width == 320) {
//               gx.x = __SCREEN_SIZE.width - 78 - gx.width;
//     }
     
//
//
//          gx.y =  self.height/2.0 - gx.height/2.0;
//          tx.y = self.height/2.0 - tx.height/2.0;
     
     _firstBtn.y = self.height/2.0 - _firstBtn.height/2.0;
     _secondBtn.y = self.height/2.0 - _secondBtn.height/2.0;
}

-(void)fitReplacementOrderInfoMode
{
     self.height = 46;
     _selectLb.hidden = YES;
     _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _firstBtn.width = 86;
     _firstBtn.height = 30;
     _firstBtn.layer.borderColor = kUIColorFromRGB(color_8).CGColor;
     _firstBtn.layer.cornerRadius = 6;
     _firstBtn.layer.borderWidth = 0.5;
     [_firstBtn setTitleColor:kUIColorFromRGB(color_8) forState:UIControlStateNormal];
 _firstBtn.y = 8;

     _secondBtn.width = 86;
     _secondBtn.height = 30;
     _secondBtn.layer.borderColor = kUIColorFromRGB(color_8).CGColor;
     _secondBtn.layer.cornerRadius = 6;
     _secondBtn.layer.borderWidth = 0.5;
     [_secondBtn setTitleColor:kUIColorFromRGB(color_8) forState:UIControlStateNormal];
     _secondBtn.y = 8;
     _secondBtn.x = __SCREEN_SIZE.width - 15 - _secondBtn.width;
     _firstBtn.x = _secondBtn.x - 10 - _firstBtn.width;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
}

-(void)fitPublishSecHandMode
{
     self.height = 46;
     _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;

     _firstBtn.width = 27;
     _firstBtn.height = 27;
        _firstBtn.x  = __SCREEN_SIZE.width - 55 - _firstBtn.width;
     _firstBtn.y = 9;
     [_firstBtn setImage:[UIImage imageContentWithFileName:@"v_reduce"] forState:UIControlStateNormal];

     _secondBtn.height = 27;
     _secondBtn.width = 27;
     _secondBtn.x = __SCREEN_SIZE.width - 10 - _secondBtn.width;
     _secondBtn.y = 9;
    [_secondBtn setImage:[UIImage imageContentWithFileName:@"v_add"] forState:UIControlStateNormal];


     _selectLb.backgroundColor = kUIColorFromRGB(color_3);
     _selectLb.hidden = YES;

     UILabel *vx = [self.contentView viewWithTag:2944];
     if (!vx) {
          vx = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
          vx.textColor = kUIColorFromRGB(color_8);
          vx.font = [UIFont systemFontOfSize:15];
          vx.textAlignment = NSTextAlignmentCenter;
          vx.y = self.height/2.0 - vx.height/2.0;

          vx.tag = 2944;
     }
     vx.text = _dataDic[@"value"];
     [vx sizeToFit];
     [self.contentView addSubview:vx];
 vx.x = _secondBtn.x  - 5 - vx.width;
 _firstBtn.x  = vx.x - 5 - _firstBtn.width;
     UILabel *tx = [self.contentView viewWithTag:2844];
     if (!tx) {
          tx = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 32)];
          tx.textColor = kUIColorFromRGB(color_1);
          tx.font = [UIFont systemFontOfSize:15];

          tx.y = self.height/2.0 - tx.height/2.0;
          tx.x = 15;
          tx.tag = 2844;
     }
       tx.text = _dataDic[@"title"];
     [self.contentView addSubview:tx];
}

-(void)fitToDoorRecycleModeB
{
     self.height = 46;
     _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;

     _firstBtn.width = 27;
     _firstBtn.height = 27;
     _firstBtn.x  = __SCREEN_SIZE.width - 75 - _firstBtn.width;
     _firstBtn.y = 9;
     [_firstBtn setImage:[UIImage imageContentWithFileName:@"v_reduce"] forState:UIControlStateNormal];

     _secondBtn.height = 27;
     _secondBtn.width = 27;
     _secondBtn.x = __SCREEN_SIZE.width - 32 - _secondBtn.width;
     _secondBtn.y = 9;
     [_secondBtn setImage:[UIImage imageContentWithFileName:@"v_add"] forState:UIControlStateNormal];


     _selectLb.backgroundColor = kUIColorFromRGB(color_3);
     _selectLb.hidden = YES;
     UILabel *hx = [self.contentView viewWithTag:2914];
     if (!hx) {
          hx = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 17)];
          hx.textColor = kUIColorFromRGB(color_8);
          hx.font = [UIFont systemFontOfSize:15];
          hx.textAlignment = NSTextAlignmentCenter;
          hx.y = self.height/2.0 - hx.height/2.0;
          hx.x = __SCREEN_SIZE.width - 15 - hx.width;
          hx.tag = 2914;
     }
     hx.text = _dataDic[@"unit"];
     [self.contentView addSubview:hx];

     UILabel *vx = [self.contentView viewWithTag:2944];
     if (!vx) {
          vx = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
          vx.textColor = kUIColorFromRGB(color_8);
          vx.font = [UIFont systemFontOfSize:15];
          vx.textAlignment = NSTextAlignmentCenter;
          vx.y = self.height/2.0 - vx.height/2.0;
//          vx.x = _firstBtn.x + _firstBtn.width  - 2;
          vx.tag = 2944;
     }
     vx.text = _dataDic[@"value"];
     [vx sizeToFit];
     [self.contentView addSubview:vx];
     vx.x = _secondBtn.x  - 5 - vx.width;
     _firstBtn.x  = vx.x - 5 - _firstBtn.width;


     UILabel *tx = [self.contentView viewWithTag:2844];
     if (!tx) {
          tx = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 32)];
          tx.textColor = kUIColorFromRGB(color_1);
          tx.font = [UIFont systemFontOfSize:15];

          tx.y = self.height/2.0 - tx.height/2.0;
          tx.x = 15;
          tx.tag = 2844;
     }
     tx.text = _dataDic[@"title"];
     [self.contentView addSubview:tx];
}

-(void)fitMySecHandMode
{
     self.height = 45;
     //    self.backgroundColor = kUIColorFromRGB(color_4);
     _firstBtn.height = 45;
     _firstBtn.width = 70;
     //    _firstBtn.layer.borderColor = kUIColorFromRGB(color_5).CGColor;
     [_firstBtn setTitleColor:kUIColorFromRGB(color_8) forState:UIControlStateNormal];
     //    _firstBtn.layer.cornerRadius = 3;
     //    _firstBtn.layer.masksToBounds = YES;
     //    _firstBtn.layer.borderWidth = 0.5;
     _firstBtn.x = __SCREEN_SIZE.width - 75 - _firstBtn.width;//(__SCREEN_SIZE.width - 60)/2.0 - _firstBtn.width - 5;
     _firstBtn.y = 0;
     _selectLb.hidden = YES;
     _firstBtn.customTitleLb.font = [UIFont systemFontOfSize:13];
     [_firstBtn fitImgAndTitleMode];
     _firstBtn.customImgV.height = 18;
     _firstBtn.customImgV.width = 16;
     _firstBtn.customImgV.x = 4;
     _firstBtn.customImgV.y = 14;
      _firstBtn.customImgV.image = [UIImage imageContentWithFileName:@"adr_edit"];
     _firstBtn.customTitleLb.x = 30;
     _firstBtn.customTitleLb.y = _firstBtn.height/2.0 - _firstBtn.customTitleLb.height/2.0;
     _firstBtn.customTitleLb.textAlignment = NSTextAlignmentLeft;
     _firstBtn.customTitleLb.textColor = kUIColorFromRGB(color_8);
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _secondBtn.height = _firstBtn.height;
     _secondBtn.width = 70;
     _secondBtn.y = 0;
     [_secondBtn fitImgAndTitleMode];
     _secondBtn.customImgV.height = 17;
     _secondBtn.customImgV.width = 19;
     _secondBtn.customImgV.x = 15;
     _secondBtn.customImgV.y = 14;
     _secondBtn.customImgV.image = [UIImage imageContentWithFileName:@"adr_del"];
     _secondBtn.customTitleLb.x = _secondBtn.width - _secondBtn.customTitleLb.width;
     _secondBtn.customTitleLb.font = [UIFont systemFontOfSize:13];
     _secondBtn.customTitleLb.y = _firstBtn.height/2.0 - _firstBtn.customTitleLb.height/2.0;
     _secondBtn.customTitleLb.textAlignment = NSTextAlignmentRight;
     _secondBtn.customTitleLb.textColor = kUIColorFromRGB(color_8);
     _secondBtn.x = __SCREEN_SIZE.width - 15 - _secondBtn.width;
     _secondBtn.customTitleLb.y = _secondBtn.height/2.0 - _secondBtn.customTitleLb.height/2.0;
//     if (isCheck) {
//          _secondBtn.customTitleLb.textColor = kUIColorFromRGB(color_8);
//          _firstBtn.customImgV.image = [UIImage imageContentWithFileName:@"checked"];
//     }
//     else
//     {
//          _secondBtn.customTitleLb.textColor = kUIColorFromRGB(color_1);
//          _firstBtn.customImgV.image = [UIImage imageContentWithFileName:@"unCheck"];
//     }
     _selectTitleColor = kUIColorFromRGB(color_8);
     _unSelectBgColor =  [UIColor clearColor];
     _selectBgColor =  [UIColor clearColor];
     _normalTitleColor = kUIColorFromRGB(color_8);
     _secondBtn.backgroundColor = [UIColor clearColor];
     _firstBtn.backgroundColor =  [UIColor clearColor];
     //    _secondBtn.backgroundColor = kUIColorFromRGB(color_mainTheme) ;

     //    _secondBtn.layer.cornerRadius = 3;
     //    _secondBtn.layer.masksToBounds = YES;
     //    _secondBtn.x = _firstBtn.x + _firstBtn.width;
     if (!_dataDic[@"tab1"]||[_dataDic[@"tab1"] isEqualToString:@""]) {
          _firstBtn.hidden = YES;
     }
     else
     {
_firstBtn.hidden = NO;
     }

     if (!_dataDic[@"tab2"]||[_dataDic[@"tab2"] isEqualToString:@""]) {
          _secondBtn.hidden = YES;
     }
     else
     {
          _secondBtn.hidden = NO;
     }

}
@end
