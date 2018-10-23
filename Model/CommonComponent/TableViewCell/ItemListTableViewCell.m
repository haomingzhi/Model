//
//  ItemListTableViewCell.m
//  yihui
//
//  Created by air on 15/9/30.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "ItemListTableViewCell.h"
#import "BUImageRes.h"
#import "BUSystem.h"
@implementation ItemListTableViewCell
{
    
//    UIButton *_curSelectedBtn;
//    SelectBtnMode _mode;
    NSMutableArray *_selImgArr;
    NSMutableArray *_imgArr;
    IBOutlet UIButton *_personBtn1;
    IBOutlet UILabel *_nameLb1;
    IBOutlet UIImageView *_headImgV1;
    
    IBOutlet UILabel *_nameLb2;
    IBOutlet UIImageView *_headImgV2;
    IBOutlet UIButton *_personBtn2;
    
    
    IBOutlet UIButton *_personBtn3;
    IBOutlet UILabel *_nameLb3;
    IBOutlet UIImageView *_headImgV3;
    
    IBOutlet UILabel *_nameLb4;
    IBOutlet UIImageView *_headImgV4;
    IBOutlet UIButton *_personBtn4;
    IBOutlet UILabel *_nameLb5;
    IBOutlet UIImageView *_headImgV5;
    IBOutlet UIButton *_personBtn5;
    NSInteger _objRow;
}

- (void)awakeFromNib {
    // Initialization code
    
    [self layoutBtn:_personBtn1 withLb:_nameLb1 withImg:_headImgV1];
    [self layoutBtn:_personBtn2 withLb:_nameLb2 withImg:_headImgV2];
    [self layoutBtn:_personBtn3 withLb:_nameLb3 withImg:_headImgV3];
    [self layoutBtn:_personBtn4 withLb:_nameLb4 withImg:_headImgV4];
    [self layoutBtn:_personBtn5 withLb:_nameLb5 withImg:_headImgV5];
//    _headImgV1.layer.cornerRadius = _headImgV1.height/2.0;
//    _headImgV1.layer.masksToBounds = YES;
//    _headImgV2.layer.cornerRadius = _headImgV2.height/2.0;
//    _headImgV2.layer.masksToBounds = YES;
//    _headImgV3.layer.cornerRadius = _headImgV3.height/2.0;
//    _headImgV3.layer.masksToBounds = YES;
//    _headImgV4.layer.cornerRadius = _headImgV4.height/2.0;
//    _headImgV4.layer.masksToBounds = YES;
//    _headImgV5.layer.cornerRadius = _headImgV5.height/2.0;
//    _headImgV5.layer.masksToBounds = YES;
//    _curSelectedBtn = _personBtn1;
    _selImgArr = [NSMutableArray array];
    _imgArr = [NSMutableArray array];
}

-(void)layoutBtn:(UIButton *)btn withLb:(UILabel *)lb withImg:(UIImageView *)imgV
{
    [btn addSubview:lb];
    [btn addSubview:imgV];
    UIImageView *markImgV = [[UIImageView alloc] initWithFrame:CGRectMake(44, 12, 16, 16)];
    [btn addSubview:markImgV];
    [markImgV addWidthConstraint:JYLayoutRelationEqual width:16];
    [markImgV addHeightConstraint:JYLayoutRelationEqual width:16];
     [markImgV addTopConstraint:4];
    [markImgV addLeftConstraint:40];
    markImgV.layer.cornerRadius = 8;
    markImgV.image = [UIImage imageNamed:@"icon_Choose_people_sel"];
    markImgV.tag = 99;
    [lb addWidthConstraint:JYLayoutRelationGreaterThanOrEqual width:30];
    [lb addHeightConstraint:JYLayoutRelationGreaterThanOrEqual width:18];
    [lb addTopConstraint:50];
    [lb addHorizontalConstraint];
   
//    markImgV.backgroundColor = [UIColor blueColor];
    markImgV.hidden = YES;
    [imgV addWidthConstraint:JYLayoutRelationEqual width:48];
    [imgV addHeightConstraint:JYLayoutRelationEqual width:48];
    [imgV addTopConstraint:0];
    [imgV addHorizontalConstraint];
    imgV.layer.cornerRadius = 48/2.0;
    imgV.layer.masksToBounds = YES;
    btn.hidden = YES;
    lb.tag = 200;
    imgV.tag = 300;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
    NSArray *arr = dataDic[@"arr"];
    for (int i = 0; i < arr.count; i++) {
        NSDictionary *dic = arr[i];
        UIButton *btn = (UIButton *)[self viewWithTag:100 + i];
        btn.hidden = NO;
        UILabel *lb = (UILabel *)[btn viewWithTag:200];
        if (dic[@"textColor"]) {
            lb.textColor = dic[@"textColor"];
        }
        //        NSLog(@"xx:%@",NSStringFromClass([dataDic[@"img"] class]));
        UIImageView *imgV = (UIImageView *)[btn viewWithTag:300];
        imgV.image = [UIImage imageNamed:@"bg_logo_default"];
        if ([dic[@"img"] isKindOfClass:[UIImage class]]) {
//            if (i ==  _curSelectedBtn.tag - 100) {
//                imgV.image = dic[@"selImg"];
//                lb.textColor = [UIColor blackColor];
//            }
//            else
//            {
                imgV.image = dic[@"img"];
//            }
            [_imgArr addObject:dic[@"img"]];
            [_selImgArr addObject:dic[@"selImg"]];
        }
        else if([dic[@"img"] isKindOfClass:[NSString class]])
        {
//            if (i ==  _curSelectedBtn.tag - 100) {
//                imgV.image = [UIImage imageNamed:dic[@"selImg"]];
//                lb.textColor = [UIColor blackColor];
//            }
//            else
//            {
                imgV.image = [UIImage imageNamed:dic[@"img"]];
//            }
            
            
            [_imgArr addObject:[UIImage imageNamed:dic[@"img"]]];
            [_selImgArr addObject:[UIImage imageNamed:dic[@"selImg"]]];
        }
        else if([dic[@"img"] isKindOfClass:[BUImageRes class]])
        {
          BUImageRes *img =  dic[@"img"];
            if (img.isCached) {
                imgV.image =  [UIImage imageWithContentsOfFile:img.cacheThumbFile];
                //         self.height = [self heightOfCellWithImg:_imgV.image];
            }
            else {
                [img download:self callback:@selector(getImgNotification:) extraInfo:@{@"obj":imgV}];
            }
        }
        lb.text = dic[@"name"];
        UIImageView *markImgv = (UIImageView *)[imgV viewWithTag:99];
        markImgv.hidden = ![dic[@"isChecked"] boolValue];
        //        imgV.image
    }
//    if ([dataDic[@"mode"] integerValue]) {
//        _mode = (SelectBtnMode)[dataDic[@"mode"] integerValue];
//    }
    
}

-(void)getImgNotification:(BSNotification *)noti
{
    if (noti.error == 0) {
        ISTOLOGIN;
      BUImageRes *img = noti.target;
      UIImageView *imgv = noti.extraInfo[@"obj"];
        imgv.image =  [UIImage imageWithContentsOfFile:img.cacheThumbFile];
    }
    
}

- (IBAction)handleAction:(UIButton *)btn {
    
    if (self.handleAction) {
        self.handleAction(@{@"sender":btn,@"ObjRow":@(_objRow),@"method":@"personList"});
//        if (_mode == SelectBtnModeSingle && btn.enabled) {
//            [self selectBtn:btn];
//        }
//        else{
//            btn.enabled = YES;
//        }
//        
//    }
//    else
//    {
//        if (_mode == SelectBtnModeSingle && btn.enabled) {
//            [self selectBtn:btn];
//        }
//        else{
//            btn.enabled = YES;
//        }
    }
}

//-(void)selectBtn:(UIButton *)btn
//{
//    NSInteger index = _curSelectedBtn.tag - 100;
//    UILabel *lb = (UILabel *)[_curSelectedBtn viewWithTag:200];
//    lb.textColor = [UIColor lightGrayColor];
//    UIImageView *imgV = (UIImageView *)[_curSelectedBtn viewWithTag:300];
//    imgV.image = _imgArr[index];
//    UILabel *lb2 = (UILabel *)[btn viewWithTag:200];
//    lb2.textColor = [UIColor blackColor];
//    UIImageView *imgV2 = (UIImageView *)[btn viewWithTag:300];
//    _curSelectedBtn = btn;
//    NSInteger index2 = _curSelectedBtn.tag - 100;
//    imgV2.image = _selImgArr[index2];
//}


@end
