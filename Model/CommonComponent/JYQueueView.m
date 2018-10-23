//
//  JYQueueView.m
//  
//
//  Created by air on 15/12/16.
//
//

#import "JYQueueView.h"

@implementation JYQueueView
{
    NSMutableArray *_arr;
}
-(id)init
{
    self = [super init];
    if (self) {
         _arr = [NSMutableArray array];
        _paddingLeft = 10;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)addViewToList:(UIView *)v
{
    [self addSubview: v];
    [_arr addObject:v];
}
-(void)addViewToListView:(NSInteger )tag
{
    [self addViewToListView:tag withImgName:@""];
}

-(void)addViewToListView:(NSInteger )tag withImgName:(NSString *)imgName
{
    UIImageView *imgV;
    if (_isToRight) {
      imgV = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - (_arr.count + 1) * ( self.bounds.size.height - 10) -(_arr.count)*_paddingLeft, 5, self.bounds.size.height - 10, self.bounds.size.height - 10)];
    }
    else
    {
   imgV = [[UIImageView alloc] initWithFrame:CGRectMake(_paddingX + _arr.count * (_paddingLeft + self.bounds.size.height  - 10), 5, self.bounds.size.height - 10, self.bounds.size.height - 10)];
    }
    imgV.tag = tag;
    [imgV setImage:[UIImage imageNamed:imgName]];
//    imgV.backgroundColor = [self getColor:tag];
    [self addSubview: imgV];
    [_arr addObject:imgV];
}

-(UIColor *)getColor:(NSInteger )tag
{
    switch (tag) {
        case 101:
        {
            return [UIColor redColor];
        }
            break;
        case 201:
        {
           return  [UIColor blueColor];
        }
            break;
        case 301:
        {
            return [UIColor blackColor];
        }
            break;
        default:
            break;
    }
    return [UIColor redColor];
}

-(void)removeViewFromListViewWithTag:(NSInteger)tag
{
  UIView *v = [self viewWithTag:tag];
    [self removeViewFromListView:v];
}

-(void)removeViewFromListView:(UIView *)v
{
    [v removeFromSuperview];
    [_arr removeObject:v];
    [self reloadView];
}
-(void)reloadView
{
    [_arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *v = obj;
        v.frame = CGRectMake(idx * (_paddingLeft + self.bounds.size.height  - 10) + _paddingX, 5, self.bounds.size.height - 10, self.bounds.size.height - 10);
    }];
}

-(void)removeAllView
{
    [_arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *v = obj;
        [v removeFromSuperview];
    }];
    [_arr removeAllObjects];
}
@end
