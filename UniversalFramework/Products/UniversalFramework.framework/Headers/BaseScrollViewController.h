
#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "XHScrollMenu.h"

@interface BaseScrollViewController : BaseTableViewController
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) NSArray *scrollViewList;
@property (nonatomic) XHScrollMenu *scrollMenu;
- (void)menuSelectedIndex:(NSUInteger)index;
-(void) myViewDidLoad;
@end
