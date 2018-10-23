//
//  MyPopupViewController.m
//  MiniClient
//
//  Created by apple on 14-7-24.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "MyPopoverController.h"

/*泡泡框控制器，处理一些弹出单项列表选择的对话框*/
@interface MyPopoverController()<MyDialogDelegate>

@property(nonatomic) NSArray *items;
@property(nonatomic) NSInteger selectedIndex;
@property(nonatomic) CGSize contentSize;

@property(nonatomic, copy) void(^completed)(NSInteger selectedIndex);


@end



@interface MyPopoverViewController : UITableViewController

@property(nonatomic,strong) MyPopoverController *ctrl;

@end


@implementation MyPopoverViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self != nil)
    {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}

//-(id)initWith



- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    

}

-(void)viewDidAppear:(BOOL)animated
{
    //滚动到指定的位置。
        if (self.ctrl.selectedIndex != NSNotFound)
        {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.ctrl.selectedIndex inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return self.ctrl.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // Configure the cell...
    
    cell.textLabel.text = [self.ctrl.items objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    
    UIImageView * lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height -2, cell.frame.size.width, 2)];
    lineImg.image =[UIImage imageNamed:@"unityline"];
    lineImg.alpha = 0.2;
    [cell.contentView addSubview:lineImg];
    
    cell.accessoryType =  self.ctrl.selectedIndex == indexPath.row ?   UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.ctrl.selectedIndex = indexPath.row;
   // [self.parentDialog dismiss];
    [self.parentDialog performSelector:@selector(dismiss) withObject:nil afterDelay:0];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */


-(void)dealloc
{
    
}


@end






@implementation MyPopoverController

-(id)initWithArray:(NSArray*)items selectedIndex:(NSInteger)selectedIndex
{
    self = [ self init];
    if (self != nil)
    {
        _items = items;
        _selectedIndex = selectedIndex;
        _contentSize = CGSizeZero;
    }
    
    return self;
}

+(id)popoverWithArray:(NSArray*)items selectedIndex:(NSInteger)selectedIndex
{
   return [[MyPopoverController alloc] initWithArray:items selectedIndex:selectedIndex];
}

-(void)setContentSize:(CGSize)size
{
    _contentSize = size;
}

-(MyDialog *)createPopVC
{
    MyPopoverViewController *vc = [[MyPopoverViewController alloc] initWithStyle:UITableViewStylePlain];
    vc.ctrl = self;
    
    //如果是空则默认的高度是整个高度。
    if (CGSizeEqualToSize(self.contentSize, CGSizeZero))
    {
        UIFont *font = [UIFont systemFontOfSize:15];
        CGFloat maxWidth = 0;
        for (NSString*str in self.items) {
            
            CGSize sz = [str sizeWithAttributes:@{NSFontAttributeName: font}];
            if (sz.width > maxWidth)
                maxWidth = sz.width;
        }
        
        
        self.contentSize = CGSizeMake(maxWidth + 60,self.items.count * 44 + 10);
    }
    
    vc.view.bounds = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
    MyDialog *dlg = [[MyDialog alloc] initWithViewController:vc];
    dlg.dismissOnTouchOutside = YES;
    dlg.mydelegate = self;
    
    return dlg;
}

//居中显示
-(void)show:(void(^)(NSInteger selected))completed
{
    self.completed = completed;
    [[self createPopVC] show];
}

//在某个视图下显示对话框，yOffset是视图的垂直偏移。
-(void)showUnderView:(UIView*)underView offset:(CGPoint)offset completed:(void(^)(NSInteger selected))completed
{
     self.completed = completed;
    [[self createPopVC] showUnderView:underView offset:offset];
}

#pragma mark -- MyDialogDelegate

-(void)dismissBy:(MyDialog *)dialog withViewController:(UIViewController *)vc isCanceled:(BOOL)isCanceled
{
    if (isCanceled)
        self.completed(NSNotFound);
    else
    {
        self.completed(self.selectedIndex);
    }
}

@end



