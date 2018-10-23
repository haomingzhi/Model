//垂直分类菜单

#import <UIKit/UIKit.h>

@interface SortMenuVer : UIView


//titles 菜单，target，action：点击回调
-(id) initWithFrameAndTitles:(CGRect)frame titles:(NSArray *) titles height:(CGFloat) height target:(id)target action:(SEL)action;
//titles 菜单，target，action：点击回调 normalColor：默认字体颜色，selectedColor：选中字体颜色 markerColor：选中标记颜色
-(id) initWithFrameAndTitles:(CGRect)frame titles:(NSArray *) titles  target:(id)target action:(SEL)action titleNormalColor:(UIColor *) normalColor titleSelectedColor:(UIColor *) selectedColor markerColor:(UIColor *)markerColor;
@property(nonatomic) NSInteger selectedIndex;
@property(nonatomic, assign) UIEdgeInsets contentInset;  //内容的缩进
@end
