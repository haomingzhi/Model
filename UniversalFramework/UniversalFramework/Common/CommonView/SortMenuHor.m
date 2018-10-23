

#import "SortMenuHor.h"
#import <objc/runtime.h>

#import <Foundation/Foundation.h>

@interface SortMenuHor()
{
    NSArray *myTitles;
    id myTarget;
    SEL myAction;
    UIColor *myNormalColor,*mySelectedColor,*myMarkerColor,*myNormalBgColor,*mySelectedBgColor;
    NSMutableArray *menuItems;
}
@end

@implementation SortMenuHor

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self construct];
    
}

-(id) initWithFrameAndTitles:(CGRect)frame titles:(NSArray *)titles target:(id)target action:(SEL)action;
{
    return [self initWithFrameAndTitles:frame titles:titles target:target action:action titleNormalColor:[UIColor blackColor] titleSelectedColor:[UIColor redColor] markerColor:[UIColor redColor]];
    
}

-(id) initWithFrameAndTitles:(CGRect)frame titles:(NSArray *) titles target:(id)target action:(SEL)action titleNormalColor:(UIColor *) normalColor titleSelectedColor:(UIColor *) selectedColor markerColor:(UIColor *)markerColor
{
    return [self initWithFrameAndTitles:frame titles:titles target:target action:action titleNormalColor:normalColor titleSelectedColor:selectedColor markerColor:markerColor normalBgColor:kUIColorFromRGB(color_control) selectedBgColor:[UIColor whiteColor]];
}

-(id) initWithFrameAndTitles:(CGRect)frame titles:(NSArray *) titles target:(id)target action:(SEL)action titleNormalColor:(UIColor *) normalColor titleSelectedColor:(UIColor *) selectedColor markerColor:(UIColor *)markerColor normalBgColor:(UIColor *) normalBgColor selectedBgColor:(UIColor *)selectedBgColor
{
    self = [super initWithFrame:frame];
    if (self) {
        myTitles = [[NSArray alloc] initWithArray:titles];
        myTarget = target;
        myAction = action;
        myNormalColor = normalColor;
        mySelectedColor = selectedColor;
        myMarkerColor = markerColor;
        myNormalBgColor = normalBgColor;
        mySelectedBgColor = selectedBgColor;
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
    NSInteger edgeInsets = self.contentInset.left + self.contentInset.right;
    NSInteger edge =10;
    NSInteger xStart =self.contentInset.left;   //
    NSInteger yStart = self.contentInset.top;   //开始位置
    NSInteger width = ((self.frame.size.width -edgeInsets - edge * (myTitles.count -1)) /myTitles.count);
    for (int i =0; i < myTitles.count; i++) {
        UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(xStart, yStart, width, self.frame.size.height - yStart-2)];
        b.tag = i +1;
        [b setTitleColor:myNormalColor forState:UIControlStateNormal];
        [b setTitle:myTitles[i] forState:UIControlStateNormal];
        [b setTitleColor:mySelectedColor forState:UIControlStateSelected];
        [b setBackgroundImage:[UIImage imageWithSeparatorLine:UISeparatorLineTypeBottom lineColor:myMarkerColor withBounds:CGRectMake(0, 0, b.frame.size.width, b.frame.size.height) ]forState:UIControlStateSelected];
        [b addTarget:self action:@selector(handleSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:b];
        xStart += edge + width;
    }
    UILabel *labelUnderLine = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height -2, self.frame.size.width, 2)];
    labelUnderLine.backgroundColor = [UIColor colorWithRed:0xd6/255.0 green:0xd6/255.0 blue:0xd6/255.0 alpha:1];
    labelUnderLine.tag = 999;
    [self addSubview:labelUnderLine];
}

-(void) layoutSubviews
{
    NSInteger edgeInsets = self.contentInset.left + self.contentInset.right;
    NSInteger edge =10;
    NSInteger xStart =self.contentInset.left;   //
    NSInteger yStart = self.contentInset.top;   //开始位置
    NSInteger width = ((self.frame.size.width -edgeInsets - (edge * myTitles.count -1)) /myTitles.count);
    for (int i =0; i < myTitles.count; i++) {
        UIView *b = [self viewWithTag:i +1];
        b.frame = CGRectMake(xStart, yStart, width, self.frame.size.height - yStart-2);
        xStart += edge + width;
    }
    UIView *labelUnderLine = [self viewWithTag:999];
    labelUnderLine.frame = CGRectMake(0, self.frame.size.height -2, self.frame.size.width, 2);
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
                }
                else
                {
                    b.selected = YES;
                    selectedButton = b;
                }
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
