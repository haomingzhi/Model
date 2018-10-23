

#import "SortMenuVer.h"
#import <objc/runtime.h>
#import "colors.h"

#import <Foundation/Foundation.h>

@interface SortMenuVer()
{
    NSArray *myTitles;
    id myTarget;
    SEL myAction;
    UIColor *myNormalColor,*mySelectedColor,*myMarkerColor;
}
@end

@implementation SortMenuVer
{
    CGFloat specifyHeight;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self construct];
    
}

-(id) initWithFrameAndTitles:(CGRect)frame titles:(NSArray *)titles height:(CGFloat) height target:(id)target action:(SEL)action;
{
    
    return [self initWithFrameAndTitles:frame titles:titles height:height target:target action:action titleNormalColor:[UIColor blackColor] titleSelectedColor:[UIColor blackColor] markerColor:[UIColor blackColor]];
    
}

-(id) initWithFrameAndTitles:(CGRect)frame titles:(NSArray *) titles height:(CGFloat)height target:(id)target action:(SEL)action titleNormalColor:(UIColor *) normalColor titleSelectedColor:(UIColor *) selectedColor markerColor:(UIColor *)markerColor
{
    self = [super initWithFrame:frame];
    if (self) {
        specifyHeight = height;
        myTitles = [[NSArray alloc] initWithArray:titles];
        myTarget = target;
        myAction = action;
        myNormalColor = normalColor;
        mySelectedColor = selectedColor;
        myMarkerColor = markerColor;
        [self construct];
    }
    return self;
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self construct];
    }
    return self;
}



-(void) construct
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth ;
    NSInteger edgeInsets = self.contentInset.top + self.contentInset.bottom;
    NSInteger xOffset =self.contentInset.left;   //
    NSInteger yOffset = self.contentInset.top;   //开始位置
    NSInteger height = specifyHeight <0.000001 ?  ((self.frame.size.height -edgeInsets ) /myTitles.count) : specifyHeight;
    for (int i =0; i < myTitles.count; i++) {
        UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(xOffset, yOffset,  self.frame.size.width,height)];
        b.tag = i +1;
        b.titleLabel.font = FontWithBody(FONTS_H4);
        [b setTitleColor:myNormalColor forState:UIControlStateNormal];
        [b setTitle:myTitles[i] forState:UIControlStateNormal];
        [b setTitleColor:mySelectedColor forState:UIControlStateSelected];
        b.backgroundColor = kUIColorFromRGB(color_control);
        //分割线
        
        [b setBackgroundImage:[UIImage imageWithSeparatorLine:UISeparatorLineTypeLeft lineColor:myMarkerColor withBounds:CGRectMake(0, 0, b.frame.size.width, b.frame.size.height) lineWidth:10 ]forState:UIControlStateSelected];
        
        [b addTarget:self action:@selector(handleSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:b];
        yOffset += height;
        if (i ==0) {
            b.selected = YES;
            b.backgroundColor = [UIColor whiteColor];
            b.userInteractionEnabled = !b.isSelected;
        }
    }
    self.selectedIndex =0;
}

-(void) layoutSubviews
{
    NSInteger edgeInsets = self.contentInset.top + self.contentInset.bottom;
    NSInteger xOffset =self.contentInset.left;   //
    NSInteger yOffset = self.contentInset.top;   //开始位置
    NSInteger height = specifyHeight <0.000001 ?  ((self.frame.size.height -edgeInsets ) /myTitles.count) : specifyHeight;
    for (int i =0; i < myTitles.count; i++) {
        UIView *b = [self viewWithTag:i +1];
        b.frame = CGRectMake(xOffset, yOffset,  self.frame.size.width,height);
        yOffset += height;
        
    }
}

-(void) setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    UIButton *selectedButton = (UIButton *)[self viewWithTag:selectedIndex];
    if (selectedButton ) {
        [self handleSelected:selectedButton];
    }
    //    char actionName[128];
    //    sprintf(actionName, "tab%ld:", _selectedIndex);
    //    SEL action = sel_registerName(actionName);
    //    id sender = [self valueForKey:[NSString stringWithFormat:@"_tabButton%ld",selectedIndex]];
    //    if (action != NULL) {
    //        [self performSelector:action withObject:sender];
    //    }
}

-(void) handleSelected:(id)sender
{
    UIButton *selectedButton = NULL;
    NSInteger tag = ((UIButton *) sender).tag;
    for (int i =0; i < self.subviews.count; i++) {
        UIView *subView = self.subviews[i];
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *b = (UIButton *)subView;
            if (b.tag >0) {
                if (b.tag != tag) {
                    b.selected = NO;
                    b.backgroundColor = kUIColorFromRGB(color_control);
                }
                else
                {
                    b.selected = YES;
                    selectedButton = b;
                    b.backgroundColor = [UIColor whiteColor];
                }
                b.userInteractionEnabled = !b.isSelected;
            }
        }
    }
    if ([myTarget respondsToSelector:myAction]) {
        SuppressPerformSelectorLeakWarning(
                                           [myTarget performSelector:myAction withObject:selectedButton]
                                           );
    }
}



@end
