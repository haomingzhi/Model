//
//  ZJMenuView.m
//  spokesman
//
//  Created by Steve on 2017/1/11.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ZJMenuView.h"
#define BTNWIDTH  70.0
#define SPACING  0

@implementation ZJMenuView{
    NSMutableArray *btnArr;
    UIImageView *lineImageView;
    NSInteger currentIndex;
    float btnWidth;
    UIButton *currentBtn;
     UIScrollView *_scrollView;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.height = 40;
    self.width = __SCREEN_SIZE.width;
    self.backgroundColor = [UIColor whiteColor];
    
}

-(void)setData:(NSArray *)arr{
     if (arr.count == 0) {
          [btnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               UIButton *btn = obj;
               [btn removeFromSuperview];
          }];
          return;
     }
    self.backgroundColor = kUIColorFromRGB(color_2);
     btnWidth = __SCREEN_SIZE.width/(float)arr.count;//BTNWIDTH
     if (!_scrollView) {
          _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
          _scrollView.bounces = YES;
          _scrollView.contentSize =  CGSizeMake((btnWidth + SPACING)*arr.count+SPACING,self.height);
          _scrollView.showsVerticalScrollIndicator = NO;
          _scrollView.showsHorizontalScrollIndicator = NO;
          [self addSubview:_scrollView];
     }
//     _scrollView.contentSize = CGSizeMake(40, (btnWidth + SPACING)*arr.count+SPACING);
     if (!btnArr) {
           btnArr = [NSMutableArray new];
     }else{
          [btnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               UIButton *btn = obj;
               [btn removeFromSuperview];
          }];
     }
   

    for (int i = 0;i<arr.count;i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*(btnWidth+SPACING)+SPACING,0, btnWidth, self.height)];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
//         btn.layer.cornerRadius = 6.0;
//         btn.layer.masksToBounds = YES;
//         btn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
//         btn.layer.borderWidth = 0.5;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.tag = i;
        btn.userInteractionEnabled = YES;
        btn.enabled = YES;
        btn.backgroundColor = kUIColorFromRGB(color_2);
        [btn addTarget:self action:@selector(choseAction:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:btn];
        [btnArr addObject:btn];
         
         if (i != arr.count-1) {
              UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(btn.x + btn.width,13, 1, 20)];
              bottomLine.backgroundColor = kUIColorFromRGB(color_lineColor);
              [self addSubview:bottomLine];
         }
         
    }
    lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(currentIndex*btnWidth + btnWidth/2.0 - 28, 43, 56, 2)];
    [lineImageView setBackgroundColor:kUIColorFromRGB(color_3)];
    [_scrollView addSubview:lineImageView];
     
     
//     UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0,self.height-0.5, __SCREEN_SIZE.width, 0.5)];
//     bottomLine.backgroundColor = kUIColorFromRGB(color_lineColor);
//     [self addSubview:bottomLine];
    
//    UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0,self.height-0.5, __SCREEN_SIZE.width, 0.5)];
//    bottomLine.backgroundColor = kUIColorFromRGB(color_lineColor);
//    [self addSubview:bottomLine];
    
    currentBtn = [btnArr firstObject];
    [currentBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
//     currentBtn.backgroundColor = kUIColorFromRGB(color_0xfdf2ea);
//     currentBtn.layer.borderColor = kUIColorFromRGB(color_0xec7e3b).CGColor;
}

-(void)choseAction:(UIButton *)sender{
    if (![sender isEqual:currentBtn]) {
         [currentBtn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
//         currentBtn.backgroundColor = kUIColorFromRGB(color_2);
//         currentBtn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
        currentBtn = sender;
         [currentBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
//         currentBtn.backgroundColor = kUIColorFromRGB(color_0xfdf2ea);
//         currentBtn.layer.borderColor = kUIColorFromRGB(color_0xec7e3b).CGColor;
        currentIndex = sender.tag;
        lineImageView.x = currentIndex * (btnWidth +SPACING)+SPACING + btnWidth/2.0 - lineImageView.width/2.0;
//         [_scrollView setContentOffset:currentBtn.center animated:NO];
        if (self.handle) {
            self.handle(currentBtn);
        }
    }
    
}

-(void)setCurrenItem:(NSInteger)index{
    UIButton *sender = btnArr[index];
    if (![sender isEqual:currentBtn]) {
         [currentBtn setTitleColor:kUIColorFromRGB(color_7) forState:UIControlStateNormal];
//         currentBtn.backgroundColor = kUIColorFromRGB(color_0xf5f5f5);
//         currentBtn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
         currentBtn = sender;
         [currentBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
//         currentBtn.backgroundColor = kUIColorFromRGB(color_0xfdf2ea);
//         currentBtn.layer.borderColor = kUIColorFromRGB(color_0xec7e3b).CGColor;
         currentIndex = sender.tag;
         lineImageView.x = currentIndex * (btnWidth +SPACING)+SPACING + btnWidth/2.0 - lineImageView.width/2.0;
//         [_scrollView setContentOffset:currentBtn.center animated:NO];
        /*
        if (self.handle) {
            self.handle(currentBtn);
        }
         */
    }
}


-(void)setCurrenItem:(NSInteger)index animated:(BOOL)animated{
     UIButton *sender = btnArr[index];
//     if (![sender isEqual:currentBtn]) {
          [currentBtn setTitleColor:kUIColorFromRGB(color_7) forState:UIControlStateNormal];
          currentBtn.backgroundColor = kUIColorFromRGB(color_0xf5f5f5);
//          currentBtn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
          currentBtn = sender;
          [currentBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
          currentBtn.backgroundColor = kUIColorFromRGB(color_0xfdf2ea);
//          currentBtn.layer.borderColor = kUIColorFromRGB(color_0xec7e3b).CGColor;
          currentIndex = sender.tag;
          lineImageView.x = currentIndex * (btnWidth +SPACING)+SPACING;
          [_scrollView setContentOffset:CGPointMake(currentBtn.x,0) animated:animated];
          /*
           if (self.handle) {
           self.handle(currentBtn);
           }
           */
//     }
}

@end
