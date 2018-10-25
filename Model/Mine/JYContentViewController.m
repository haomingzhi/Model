//
//  JYContentViewController.m
//  compassionpark
//
//  Created by air on 2017/5/16.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "JYContentViewController.h"
#import "BUSystem.h"
#import "JYCommonTool.h"
@interface JYContentViewController ()
@property (strong, nonatomic) IBOutlet UILabel *contentLb;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation JYContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    HUDSHOW(@"加载中");
    [self getData];
    self.view.backgroundColor = kUIColorFromRGB(color_9);
    _contentLb.x = 15;
    _contentLb.y = 10;
    _contentLb.width = __SCREEN_SIZE.width - 30;
    _contentLb.text = @"";
    _contentLb.numberOfLines = 0;
    _contentLb.font = [UIFont systemFontOfSize:15];
    _contentLb.textColor = kUIColorFromRGB(color_1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getData
{
    [busiSystem.agent getHelpDetail:_userInfo[@"id"] observer:self callback:@selector(getDataNotification:)];
}

-(void)getDataNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
//        HUDDISMISS;
//        self.title = busiSystem.agent.help.title;
//        NSString *htmlStringx = [JYCommonTool unescape:busiSystem.agent.help.content] ;
//        NSString *htmlString = htmlStringx;
////        if ([htmlString containString:@"</"] || [htmlString containsString:@"/>"]  ) {
//        
//            //            NSString *style = [NSString stringWithFormat:@"<style  type=\"text/css\">img{width:220px,height:200px}</style>"];
//            //            htmlString = [NSString stringWithFormat:@"%@%@",style,htmlString];
//        NSInteger www = __SCREEN_SIZE.width - 30;
//            htmlString = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><style  type=\"text/css\">img{width:%ldpx; }</style></head><body>%@</body></html>",www,htmlString];
//            NSMutableAttributedString  *attrStr = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//            _contentLb.attributedText = attrStr;
//            [_contentLb sizeToFit];
//       CGSize s = [busiSystem.agent.help.content size:_contentLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width - 30, 100000)];
//        _contentLb.width = s.width;
//        _contentLb.height = s.height;
        
        [_scrollView setContentSize:CGSizeMake(__SCREEN_SIZE.width, _contentLb.height + 10)];
    }
    else
    {
//        HUDCRY(noti.error.domain, 2);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
