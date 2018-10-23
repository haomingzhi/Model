//
//  TitleAndTextBtnTableViewCell.m
//  lovecommunity
//
//  Created by air on 16/6/24.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "TitleAndTextBtnTableViewCell.h"
#import "HyperlinksButton.h"
@implementation TitleAndTextBtnTableViewCell
{
    IBOutlet UILabel *_titleLb;
    IBOutlet HyperlinksButton *_btn;
    NSInteger _style;
    NSInteger _time;
    NSTimer *_timer;
   
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    [_btn setColor:kUIColorFromRGB(color_1)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _style = [dataDic[@"style"] integerValue];
    _titleLb.text = dataDic[@"title"];
    [_btn setTitle:dataDic[@"detail"] forState:UIControlStateNormal];
   CGSize size = [dataDic[@"title"] size:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(100, 14)];
    _btn.x = size.width + 5 + _titleLb.x;
   
}
- (IBAction)btnAction:(id)sender {
    if (self.handleAction) {
        self.handleAction(@{@"style":@(_style)});
    }
}





-(void)fitModeB
{
    CGSize size = [_titleLb.text size:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(240, 18)];
      _btn.x = size.width + 5 + _titleLb.x;
    _titleLb.textColor = kUIColorFromRGB(color_1);
}
-(void)fitMode
{
    self.height = 40;
    _titleLb.textColor = kUIColorFromRGB(color_5);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    CGSize size = [_btn.titleLabel.text size:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(240, 18)];
    _btn.width = size.width;
    [_btn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    _btn.x = __SCREEN_SIZE.width - 15 - _btn.width;
    [_btn setColor:[UIColor clearColor]];
    _btn.y = self.height/2.0 - _btn.height/2.0;
}

-(void)fitRegMode
{
    self.height = 36;
    _titleLb.font = [UIFont systemFontOfSize:13];
    _titleLb.height = 13;
    _btn.width = 200;
    _btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_btn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
    [_btn sizeToFit];
    CGSize size = [_titleLb.text size:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(240, 18)];
   
    _titleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
    _titleLb.y = 12;
    _btn.y = 12;
    _btn.height = 13;
    _titleLb.x = 15;
     _titleLb.height = 13;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.width = __SCREEN_SIZE.width;
    _btn.x = _titleLb.x;
    [_btn setColor:[UIColor clearColor]];
     _btn.width = _titleLb.width;
//    self.backgroundColor = kUIColorFromRGB(color_9);
//    self.contentView.backgroundColor = [UIColor clearColor];
}

-(void)fitRantInfoMode:(BOOL)upDown
{
    self.height = 44;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    _titleLb.x = 15;
    _titleLb.textColor = kUIColorFromRGB(color_6);
    _titleLb.font = [UIFont systemFontOfSize:15];
    [_btn setTitleColor:kUIColorFromRGB(color_1) forState:UIControlStateNormal];
    _btn.titleLabel.font = [UIFont systemFontOfSize:15];
    _btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_btn sizeToFit];
    _btn.width += 20;
    
    _btn.x = __SCREEN_SIZE.width - 15 - _btn.width;
    
    _btn.y = self.height/2.0 - _btn.height/2.0;
    UIImageView *imgv = [_btn viewWithTag:973];
    if (!imgv) {
        imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 5)];
        imgv.tag = 973;
        
        imgv.y = 14;
        
        
    }
    imgv.x = _btn.width - 14;
    if (upDown) {
        imgv.image = [UIImage imageContentWithFileName:@"up"];
    }
    else
    {
        imgv.image = [UIImage imageContentWithFileName:@"down"];
    }
    [_btn addSubview:imgv];
       [_btn setColor:[UIColor clearColor]];
}

-(NSString *)getData:(NSString *)key
{
    if ([key isEqualToString:@"detail"]) {
        return _btn.titleLabel.text;
    }
    return _titleLb.text;
}

-(void)fitPublishMode:(NSInteger)state
{
    self.height = 40;
    _titleLb.text = @"最多100字";
    _titleLb.textColor = kUIColorFromRGB(color_6);
    _titleLb.font = [UIFont systemFontOfSize:15];
    [_titleLb sizeToFit];
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
  
    if (state == 0) {
        _btn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
        _btn.layer.borderWidth = 0.5;
        _btn.layer.cornerRadius = 3;
        _btn.layer.masksToBounds = YES;
         _btn.backgroundColor = kUIColorFromRGB(color_2);
        [_btn setTitle:@"" forState:UIControlStateNormal];
        _btn.width = 150;
        _btn.height = 30;
        _titleLb.x = __SCREEN_SIZE.width - 10- 15 - _btn.width - _titleLb.width;
        _btn.x = __SCREEN_SIZE.width - 15 - _btn.width;
        _btn.userInfo = @{@"state":@900};
        [_btn removeTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_btn addTarget:self action:@selector(extroHandle:) forControlEvents:UIControlEventTouchUpInside];
            [_btn addTarget:self action:@selector(extroHandleB:) forControlEvents:UIControlEventTouchDown];
          [_btn addTarget:self action:@selector(extroHandleC:) forControlEvents:UIControlEventTouchUpOutside];
        UIButton *scBtn = [_btn viewWithTag:7443];
        scBtn.hidden = YES;
        UIView *line = [_btn viewWithTag:8765];
        line.hidden = YES;
        UIImageView *imgV = [_btn viewWithTag:4231];
        if (!imgV) {
           imgV = [[UIImageView alloc] initWithFrame:CGRectMake(21, 8, 12, 20)];
            imgV.tag = 4231;
        }
        imgV.hidden = NO;
        imgV.x = 21;
        imgV.y = 5;
        imgV.image = [UIImage imageContentWithFileName:@"p_rec"];
        [_btn addSubview:imgV];
        
        UILabel *txtLb = [_btn viewWithTag:8211];
        if (!txtLb) {
            txtLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
            txtLb.tag = 8211;
           
           
        }
         txtLb.textAlignment = NSTextAlignmentCenter;
        txtLb.textColor = kUIColorFromRGB(color_3);
        txtLb.font = [UIFont systemFontOfSize:15];
        txtLb.text = @"按住说话";
        txtLb.x = 40;
        txtLb.width = 100;
        [_btn addSubview:txtLb];
        
    }
    else if(state == 1)
    {
        _btn.layer.cornerRadius = 3;
        _btn.layer.masksToBounds = YES;
        [_btn setTitle:@"" forState:UIControlStateNormal];
        _btn.backgroundColor = kUIColorFromRGB(color_3);
        UIButton *scBtn = [_btn viewWithTag:7443];
        if (!scBtn) {
            scBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 0, 50, 30)];
            scBtn.tag = 7443;
            scBtn.titleLabel.font = [UIFont systemFontOfSize:15];
          
         
            
        }
        [scBtn addTarget:self action:@selector(extroHandle:) forControlEvents:UIControlEventTouchUpInside];
           [scBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          [scBtn setTitle:@"删除" forState:UIControlStateNormal];
        scBtn.hidden = NO;
        [_btn addSubview:scBtn];
        UIView *line = [_btn viewWithTag:8765];
        if (!line) {
            line = [[UIView alloc] initWithFrame:CGRectMake(100, 3, 0.5, 24)];
            line.tag = 8765;
           
        }
        line.hidden = NO;
         line.backgroundColor = kUIColorFromRGB(color_2);
        [_btn addSubview:line];
        _btn.width = 150;
        _btn.height = 30;
        _titleLb.x = __SCREEN_SIZE.width - 10- 15 - _btn.width - _titleLb.width;
        _btn.x = __SCREEN_SIZE.width - 15 - _btn.width;
        
        UILabel *txtLb = [_btn viewWithTag:8211];
        if (!txtLb) {
           txtLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
            txtLb.tag = 8211;
            
           
        }
        txtLb.textAlignment = NSTextAlignmentCenter;
        txtLb.textColor = kUIColorFromRGB(color_2);
        txtLb.font = [UIFont systemFontOfSize:15];
        txtLb.text = @"播放语音录音";
        txtLb.x = 0;
        txtLb.width = 100;
        [_btn addSubview:txtLb];
        [_btn removeTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
         [_btn addTarget:self action:@selector(extroHandle:) forControlEvents:UIControlEventTouchUpInside];
      _btn.userInfo = @{@"state":@901};
        
        UIImageView *imgV = [_btn viewWithTag:4231];
        if (!imgV) {
            imgV = [[UIImageView alloc] initWithFrame:CGRectMake(21, 8, 12, 20)];
            imgV.tag = 4231;
        }
        imgV.hidden = YES;
        
           }
    else
    {
//        _btn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
//        _btn.layer.borderWidth = 0.5;
        _btn.layer.cornerRadius = 3;
        _btn.layer.masksToBounds = YES;
        [_btn setTitle:@"" forState:UIControlStateNormal];
            _btn.backgroundColor = kUIColorFromRGB(color_3);
        _btn.width = 120;
        _btn.height = 30;
        _titleLb.x = __SCREEN_SIZE.width - 10- 15 - _btn.width - _titleLb.width;
        _btn.x = __SCREEN_SIZE.width - 15 - _btn.width;
        _btn.userInfo = @{@"state":@902};
        [_btn removeTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_btn addTarget:self action:@selector(extroHandle:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *scBtn = [_btn viewWithTag:7443];
        scBtn.hidden = YES;
        UIView *line = [_btn viewWithTag:8765];
        line.hidden = YES;
           UILabel *txtLb = [_btn viewWithTag:8211];
        if (!txtLb) {
            txtLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
            txtLb.tag = 8211;
            txtLb.textAlignment = NSTextAlignmentCenter;
           
        }
        txtLb.textColor = kUIColorFromRGB(color_2);
        txtLb.font = [UIFont systemFontOfSize:15];
        txtLb.textAlignment = NSTextAlignmentLeft;
        txtLb.x = 40;
        txtLb.text = @"松开停止";
         txtLb.width = 100;
        UIImageView *imgV = [_btn viewWithTag:4231];
        if (!imgV) {
            imgV = [[UIImageView alloc] initWithFrame:CGRectMake(21, 8, 12, 20)];
            imgV.tag = 4231;
        }
        imgV.hidden = NO;
        imgV.x = 21;
        imgV.y = 5;
        imgV.image = [UIImage imageContentWithFileName:@"p_rec2"];
        [_btn addSubview:imgV];
        
      _btn.userInfo = @{@"state":@902};
    }
      _btn.y = self.height/2.0 - _btn.height/2.0;
}
-(void)extroHandleC:(UIButton *)btn
{
    NSInteger st = [_btn.userInfo[@"state"] integerValue] - 900;
    if (_extroHandle) {
        _extroHandle(@{@"obj":btn,@"state":@(st),@"event":@2,@"time":@([NSDate new].timeIntervalSince1970)});
    }
}
-(void)extroHandleB:(UIButton *)btn
{
 NSInteger st = [_btn.userInfo[@"state"] integerValue] - 900;
    if (_extroHandle) {
        _extroHandle(@{@"obj":btn,@"state":@(st),@"event":@1,@"time":@([NSDate new].timeIntervalSince1970)});
    }
}

-(void)extroHandle:(UIButton *)btn
{
    if (btn == _btn) {
       NSInteger st = [_btn.userInfo[@"state"] integerValue] - 900;
        if (st == 0) {
//            NSLog(@"ss:%lu",(unsigned long)btn.allControlEvents);
        }
        else if (st == 1)
        {
           
            _time = _initTime + 1;
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeHandle) userInfo:nil repeats:YES];
            [self timeHandle];
;
        }
        else
        {
//            _time = 60;
//            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeHandle) userInfo:nil repeats:YES];
//            [self timeHandle];
        }
        if (_extroHandle) {
            _extroHandle(@{@"obj":btn,@"state":@(st),@"event":@0,@"time":@([NSDate new].timeIntervalSince1970)});
        }
        return ;
    }
    else
    {
        if (_extroHandle) {
           BOOL b = _extroHandle(@{@"obj":btn});
            if (b) {
                return;
            }
        }
        
    }
}

-(void)refreshMode
{
    UILabel *txtLb = [_btn viewWithTag:8211];
    txtLb.text = [NSString stringWithFormat:@"%@",@"播放语音录音"];
    _time = _initTime + 1;
    [_timer invalidate];
    [self fitPublishMode:0];
}

-(void)timeHandle
{
    _time--;
    UILabel *txtLb = [_btn viewWithTag:8211];
    if (_time == 0) {
         txtLb.text = [NSString stringWithFormat:@"%@",@"播放语音录音"];
        _time = _initTime + 1;
           [_timer invalidate];
        if (_extroHandle) {
            _extroHandle(@{@"obj":_btn,@"state":@(1),@"event":@1});
        }
        return;
    }
    
    txtLb.text = [NSString stringWithFormat:@"%lds",_time];
}

-(UIButton *)getBtn
{
    return _btn;
}

-(void)fitMyAccountMode:(BOOL)isShowUnBind
{
    self.height = 40;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.width = __SCREEN_SIZE.width - 120;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.x = 15;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _btn.hidden = !isShowUnBind;
    _btn.width = 80;
    _btn.y = self.height/2.0 - _btn.height/2.0;
    _btn.x = __SCREEN_SIZE.width - 15 - _btn.width;
    _btn.contentHorizontalAlignment = UIViewContentModeRight;
    _btn.contentEdgeInsets = UIEdgeInsetsMake(0, 44, 0, 0);
    [_btn setTitleColor:kUIColorFromRGB(color_1) forState:UIControlStateNormal];
    _btn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.backgroundColor = kUIColorFromRGB(color_4);
}

//-(void)fitCerManagerNextMode:(BOOL)show
//{
//    self.height = 44;
//    _titleLb.textColor = kUIColorFromRGB(color_1);
//    _titleLb.width = __SCREEN_SIZE.width - 120;
//    _titleLb.font = [UIFont systemFontOfSize:15];
//    _titleLb.x = 15;
//    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
//    UIButton *btn = [UIButton new];
//    btn.height = 44;
////    _btn = _btn;
//    if (show) {
//        [_btn setImage:[UIImage imageContentWithFileName:@"checked"] forState:UIControlStateNormal];
//    }
//    else
//    {
//        [_btn setImage:nil forState:UIControlStateNormal];
//
//    }
//    _btn.width = __SCREEN_SIZE.width - 15;
//    _btn.y = self.height/2.0 - _btn.height/2.0;
//    _btn.x = 0;//__SCREEN_SIZE.width - 15 - _btn.width;
////    _btn.contentHorizontalAlignment = UIViewContentModeRight;
////    [_btn setTitleColor:kUIColorFromRGB(color_1) forState:UIControlStateNormal];
////    _btn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [_btn setTitle:@"" forState:UIControlStateNormal];
//    [_btn setImageEdgeInsets:UIEdgeInsetsMake(0, _btn.width - 20, 0,0)];
//    self.backgroundColor = kUIColorFromRGB(color_4);
//}


-(void)fitRegMode:(BOOL)b withTarget:(id)obj withSEL:(SEL)sel
{
     self.height = 36;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     _btn.width = 200;
     _btn.titleLabel.font = [UIFont systemFontOfSize:13];
     [_btn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
     [_btn sizeToFit];
     CGSize size = [_titleLb.text size:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(240, 13)];
     
     _titleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _titleLb.y = 12;
     _titleLb.x = 70;
     _btn.y = 12;
     _btn.height = 13;
     _btn.x = size.width + 2 + _titleLb.x;
     [_btn setColor:[UIColor clearColor]];
//     self.backgroundColor = kUIColorFromRGB(color_4);
     
     UIImageView *imgv = [_btn viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
          imgv.tag = 973;
          
          imgv.y = 0;
          
          
     }
     imgv.x = 0;
     
     imgv.highlightedImage = [UIImage imageContentWithFileName:@"check"];
     
     imgv.image = [UIImage imageContentWithFileName:@"unCheck"];
     imgv.highlighted = b;
     UIButton *btn = [self.contentView viewWithTag:6544];
     if (!btn) {
          btn = [UIButton new];
          btn.tag = 6544;
          [btn addTarget:obj action:sel forControlEvents:UIControlEventTouchUpInside];
     }
     btn.width = _titleLb.width + 14;
     btn.height = 13;
     [btn addSubview:imgv];
     [self.contentView addSubview:btn];
     btn.x = 25;
//     if(__SCREEN_SIZE.width > 320)
//          btn.x = __SCREEN_SIZE.width/2.0 - (_btn.width + size.width + 27 + 46)/2.0;
//     else
//          btn.x = __SCREEN_SIZE.width/2.0 - (_btn.width + size.width + 27)/2.0;
//     _titleLb.x = btn.x + 17;
     btn.y = _titleLb.y;
     
}

-(void)fitModiPhoneMode
{
     _btn.hidden = YES;
      UIImageView *imgv = [self viewWithTag:973];
     imgv.hidden = YES;
     _titleLb.x = 15;
     _titleLb.y = 15;
     _titleLb.height = 33;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.numberOfLines = 2;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_0x757575);
     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
}

@end
