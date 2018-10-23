//
//  JYAbstractTableViewCell.m
//  TestTableView
//
//  Created by wujiayuan on 15/8/29.
//  Copyright (c) 2015年 wujyapp. All rights reserved.
//

#import "JYAbstractTableViewCell.h"

@implementation JYAbstractTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)setCellData:(NSDictionary *)dataDic
{
    NSValue *v = dataDic[@"separatorInset"];
    UIEdgeInsets s;
    [v getValue:&s];
    if (v) {
        self.separatorInset = s;
    }
    if (dataDic[@"height"]) {
        self.height = [dataDic[@"height"] floatValue];
    }
    
}

-(id)heightOfCell
{
    return @(self.height);
}

-(void)showSeparatorView
{
    [self showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
}

-(void)hiddenSeparatorView
{
    [self.subviews enumerateObjectsUsingBlock:^( UIView *  obj, NSUInteger idx, BOOL *  stop) {
        if ([NSStringFromClass([obj class]) isEqualToString:@"UITableViewCellContentView"])
        {
            
        }
        else if([NSStringFromClass([obj class]) isEqualToString:@"_UITableViewCellSeparatorView"])
        {
            obj.hidden = YES;
            //            UIView *v  = obj;
            //            v.backgroundColor = color;
            //            v.x = insets.left;
            //            v.y = self.height - 0.5;
            //            v.width = __SCREEN_SIZE.width - insets.left - insets.right;
            //            v.height = 0.5;
        }
    }];
}

-(void)hiddenCustomSeparatorView
{
    UIView *v = [self.contentView viewWithTag:11111];
    v.hidden = YES;

}
-(void)showCustomSeparatorView
{
    [self showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
}
-(void)showCustomSeparatorView:(UIColor *)color withInsets:(UIEdgeInsets)insets
{
    [self hiddenSeparatorView];
    UIView *v = [self.contentView viewWithTag:11111];
    if (!v) {
        v = [[UIView alloc] init];
        v.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
        v.backgroundColor = color;
       
        v.tag = 11111;
    }
    v.hidden = NO;
    v.x = insets.left;
    v.y = insets.top - 0.25 * [UIScreen mainScreen].scale;
    v.width = __SCREEN_SIZE.width - insets.left - insets.right;
    v.height = 0.25 * [UIScreen mainScreen].scale;
    [self.contentView addSubview:v];
}

-(void)showSeparatorView:(UIColor *)color withInsets:(UIEdgeInsets)insets
{
    [self.subviews enumerateObjectsUsingBlock:^( UIView *  obj, NSUInteger idx, BOOL *  stop) {
        if ([NSStringFromClass([obj class]) isEqualToString:@"UITableViewCellContentView"])
        {
            
        }
        else if ([NSStringFromClass([obj class]) isEqualToString:@"UITableViewCellEditControl"])
        {
            
        }
        else if([NSStringFromClass([obj class]) isEqualToString:@"_UITableViewCellSeparatorView"])
        {
            obj.hidden = NO;
            UIView *v  = obj;
            v.backgroundColor = color;
            v.x = insets.left;
            v.y = self.height - 0.25 * [UIScreen mainScreen].scale;
            v.width = __SCREEN_SIZE.width - insets.left - insets.right;
            v.height = 0.25 * [UIScreen mainScreen].scale;
        }
    }];
}
-(void)fitContentSize:(UIView *)view
{
    //    view.width = __SCREEN_SIZE.width - 10 - view.x;
    //_titleLb.text = content;
    [view sizeToFit];
    view.height = MAX(view.height, 20);
    self.height = view.height + 4 + view.y;
}

-(void)fitContentSize:(UIView *)view withPadding:(UIEdgeInsets)inset
{
    //        view.width = __SCREEN_SIZE.width - 10 - view.x;
    //_titleLb.text = content;
    [view sizeToFit];
    view.height = MAX(view.height, 20);
    self.height = view.height + inset.bottom + view.y;
}

+(id)createTableViewCell
{
    JYAbstractTableViewCell *  cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
//    cell.contentView.backgroundColor = kUIColorFromRGB(color_4);
    return cell;
}
+(void)registerTableViewCell:(UITableView *)tableView
{
     return [[self class] registerTableViewCell:tableView withTag:NSStringFromClass([self class])];
}
+(void)registerTableViewCell:(UITableView *)tableView  withTag:(NSString*)tag
{
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] forCellReuseIdentifier:tag];
}

+(id)dequeueReusableCell:(UITableView *)tableView
{
     return [[self class] dequeueReusableCell:tableView withTag:NSStringFromClass([self class])];
}
+(id)dequeueReusableCell:(UITableView *)tableView  withTag:(NSString*)tag
{
    return  [tableView dequeueReusableCellWithIdentifier:tag];
}

-(CGFloat)getCellHeight
{
    return self.height;
}

-(void)modifiDeleteBtn{
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
            subView.backgroundColor= kUIColorFromRGB(color_mainTheme);
            for (UIButton *btn in subView.subviews) {
                if ([btn isKindOfClass:[UIButton class]]) {
                    btn.backgroundColor = kUIColorFromRGB(color_mainTheme);
                    [btn setTitle:@"" forState:UIControlStateNormal];
                    [btn setImage:[UIImage imageContentWithFileName:@"iconfontdel"] forState:UIControlStateNormal];
                }
            }
        }
    }
}
@end
