//
//  ZJMenuWithImgView.m
//  compassionpark
//
//  Created by Steve on 2017/2/6.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ZJMenuWithImgView.h"

@implementation ZJMenuWithImgView

-(void)awakeFromNib{
    [super awakeFromNib];
    
}



-(void)setMenuData:(NSArray *)arr{
    _normalColor = kUIColorFromRGB(color_8);
    _selectedColor = kUIColorFromRGB(color_3);
    _selectedImage = [UIImage imageNamed:@"icon_arrow_down"];
    _NormalImage = [UIImage imageNamed:@"arrow_down_gray"];
    self.backgroundColor = kUIColorFromRGB(color_2);
    CGFloat i = 0.0;
    CGFloat width = self.frame.size.width/(float)arr.count;
    _sumIndex = arr.count;
    _viewsArr = [NSMutableArray new];
    for (NSString *str in arr) {
        UILabel *title = [[UILabel alloc]init];
        title.text = str;
        title.font = [UIFont systemFontOfSize:15];
        [title sizeToFit];
        title.y = self.height/2.0 - title.height/2.0;
        title.textColor = kUIColorFromRGB(color_8);
        [self addSubview:title];
        
        UIImageView *imageView  = [[UIImageView alloc]initWithImage:_NormalImage];
        imageView.y = self.height/2.0 - imageView.height/2.0;
        [self addSubview:imageView];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(width*i, 0, self.frame.size.width, self.frame.size.height)];
        btn.tag = 10000+i;
        btn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
        btn.layer.borderWidth = 0.5;
        [btn addTarget:self  action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
//        if (i==0.0) {
//            title.textColor =  _selectedColor;
//            imageView.image = _selectedImage;
//        }
        
        NSDictionary *data = @{@"label":title,@"image":imageView,@"btn":btn};
        [self.viewsArr addObject:data];
        [self setMiddle:title imageView:imageView withIndex:i];
        i++;
    }
    
//    _lineImv = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
//    _lineImv.backgroundColor = kUIColorFromRGB(color_3);
//    [self addSubview:_lineImv];
    
}

- (void)setMiddle:(UILabel *)label imageView:(UIImageView *)imageView  withIndex:(CGFloat)index{
    CGFloat width = self.frame.size.width/(float)_sumIndex;
    CGSize size = [label.text size:label.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width/2.0 - 20, 44)];
    label.width = size.width;
    label.x = width/2.0 - (label.width + imageView.width +10)/2.0 + width*index;
    imageView.x = label.x + label.width + 10;
}


-(void)btnAction:(UIButton *)sender{
    if (_callBack) {
        _callBack(@{@"index":@(sender.tag)});
    }
     
     UILabel *title = _viewsArr[_curIndex][@"label"];
     UIImageView *imageView = _viewsArr[_curIndex][@"image"];
     title.textColor =  _normalColor;
     imageView.image = _NormalImage;
     
     title = _viewsArr[sender.tag -10000][@"label"];
     imageView = _viewsArr[sender.tag-10000][@"image"];
     title.textColor =  _selectedColor;
     imageView.image = _selectedImage;
      _curIndex = sender.tag - 10000;
     
//    if (_curIndex != sender.tag - 10000) {
//        UILabel *title = _viewsArr[_curIndex][@"label"];
//        UIImageView *imageView = _viewsArr[_curIndex][@"image"];
//        title.textColor =  _normalColor;
//        imageView.image = _NormalImage;
//
//        title = _viewsArr[sender.tag -10000][@"label"];
//        imageView = _viewsArr[sender.tag-10000][@"image"];
//        title.textColor =  _selectedColor;
//        imageView.image = _selectedImage;
//        _isShow = YES;
//         _curIndex = sender.tag - 10000;
//    }else{
//        if (_isShow) {
//            UILabel *title = _viewsArr[_curIndex][@"label"];
//            UIImageView *imageView = _viewsArr[_curIndex][@"image"];
//            title.textColor =  _normalColor;
//            imageView.image = _NormalImage;
//            _isShow = NO;
//        }else{
//            UILabel *title = _viewsArr[_curIndex][@"label"];
//            UIImageView *imageView = _viewsArr[_curIndex][@"image"];
//            title.textColor =  _selectedColor;
//            imageView.image = _selectedImage;
//            _isShow = YES;
//        }
//    }
    
}

-(void)setTitle:(NSString *)title index:(NSInteger)index isSelect:(BOOL)isSelected{
    
    UILabel * titleLb = _viewsArr[_curIndex][@"label"];
    UIImageView * imageView = _viewsArr[_curIndex][@"image"];
    titleLb.textColor =  _normalColor;
    imageView.image = _NormalImage;
    
    
    titleLb = self.viewsArr[index][@"label"];
    imageView = _viewsArr[index][@"image"];
//     imageView.image = _selectedImage;
     titleLb.text = title;
     
    if (isSelected) {
        imageView.image = _selectedImage;
         titleLb.textColor = _selectedColor;
    }else{
        imageView.image = _NormalImage;
         titleLb.textColor = _normalColor;
    }
//    if (title.length != 0) {
//        titleLb.text = title;
//        titleLb.textColor = _selectedColor;
//    }
    [self setMiddle:titleLb imageView:imageView withIndex:index];
    _curIndex = index;
}


 /*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
