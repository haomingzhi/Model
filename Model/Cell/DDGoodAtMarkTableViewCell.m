//
//  DDGoodAtMarkTableViewCell.m
//  NIM
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "DDGoodAtMarkTableViewCell.h"
#import "UIView+NTES.h"
@interface DDGoodAtMarkTableViewCell()
@property(nonatomic,strong)NSMutableArray *marks;
@end

@implementation DDGoodAtMarkTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.marks = [NSMutableArray new];
    }
    return self;
}
-(void)refresh:(NSDictionary *)dic
{
    
    [self genMarks:dic[@"arr"]];
    
    [self setNeedsLayout];
}

-(void)genMarks:(NSArray *)arr
{
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < self.marks.count ) {
            UILabel *lb = self.marks[idx];
            lb.text = obj;
        }
        else
        {
            UILabel *lb = [UILabel new];
            lb.tag = 100 + idx;
            lb.width = 69;
            lb.height = 21;
            lb.layer.cornerRadius = lb.height/2.0;
            lb.layer.masksToBounds = YES;
            lb.layer.borderColor = UIColorFromRGB(0x20A0FF).CGColor;
            lb.layer.borderWidth = 0.5;
            lb.textColor = UIColorFromRGB(0x20A0FF);
            lb.font = [UIFont systemFontOfSize:14];
            lb.text = obj;
            lb.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:lb];
            [self.marks addObject:lb];
        }
    }];
    if (self.marks.count > arr.count) {
        NSInteger n = self.marks.count - arr.count;
        for (NSInteger i = 0; i < n; i ++) {
            UILabel *lb = self.marks[arr.count + i];
            [lb removeFromSuperview];
        }
        [self.marks removeObjectsInRange:NSMakeRange(arr.count, self.marks.count - arr.count)];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.marks enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *lb = obj;
        lb.top = 27 + idx / 4 *(lb.height + 12);
        NSInteger sp = (self.width - 36 - lb.width * 4)/3.0;
        lb.left  = 18 + idx % 4 * (lb.width + sp);
    }];
    UILabel *lb = self.marks.lastObject;
    self.height = MAX(lb.height + lb.top  + 19, 58);
}

@end
