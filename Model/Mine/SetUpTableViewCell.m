//
//  SetUpTableViewCell.m
//  ulife
//
//  Created by sunmax on 15/12/10.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "SetUpTableViewCell.h"
#import "BUSystem.h"
@implementation SetUpTableViewCell
{
    IBOutlet UIImageView *_arrowImgV;
    __weak IBOutlet UISwitch *_switch;
}

- (void)awakeFromNib {
    // Initialization code
}
-(void)setCell:(NSString *)cellName
{
    [self cellNameCenter];
    _cache.hidden =YES;
    _prompt.hidden =YES;
    _cellName.hidden=NO;
    _cellName.text =cellName;
}

-(void)setVersionCell:(NSString *)cellName withVersion:(NSString *)ver
{
     [self setCell:cellName];
     _cache.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _cache.font = [UIFont systemFontOfSize:15];
     _cache.text = ver;
     _cache.hidden = NO;
     _cellName.text = cellName;
     _cache.textColor = kUIColorFromRGB(color_6);
     _cache.x = __SCREEN_SIZE.width - 15 - _cache.width;
     _arrowImgV.hidden = YES;
}
-(void)set_switchCell:(NSString *)cellName
{
    self.height = 45;
    [self cellNameCenter];
    _cache.hidden =YES;
    _arrowImgV.hidden = YES;
    _prompt.hidden =YES;
    _cellName.hidden=NO;
    _cellName.text =cellName;
    _switch.hidden=NO;
    _switch.layer.cornerRadius = _switch.height/2.0;
    _switch.layer.masksToBounds = YES;
    _switch.x = __SCREEN_SIZE.width - 15 - _switch.width;
    _switch.y = self.height/2.0 - _switch.height/2.0;
//    [_switch setOn:busiSystem.agent.AllowPush==1?YES:NO];

    self.accessoryType =UITableViewCellAccessoryNone;
}

-(UISwitch*)pushSw
{
     return _switch;
}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        [_switch setOn:YES];
        [busiSystem.agent pushSetStatus:1 observer:self callback:@selector(pushSetNotification:)];
        busiSystem.agent.AllowPush=1;
    }else {
        [_switch setOn:NO];
        [busiSystem.agent pushSetStatus:0 observer:self callback:@selector(pushSetNotification:)];
        busiSystem.agent.AllowPush=2;
    }
}

-(void)pushSetNotification:(BSNotification *)noti
{ ISTOLOGIN;
//    BASENOTIFICATION(noti);
   
}


-(void)setCacheCell:(NSString *)cellName
{
    [self cellNameCenter];
    _prompt.hidden =YES;
    CGFloat flo =[busiSystem.cache sizeOfCache];
     _cache.font = [UIFont systemFontOfSize:15];
    _cache.text =[NSString stringWithFormat:@"%.2lfM",flo];
    _cellName.text =cellName;
    _cache.textColor = kUIColorFromRGB(color_6);
}


-(void)setPromptCell:(NSString *)cellName
{
    _cellName.text =cellName;
    _cache.hidden=YES;
    self.selectionStyle =UITableViewCellSelectionStyleNone;
    self.accessoryType =UITableViewCellAccessoryNone;
}

- (void)cellNameCenter
{
    _cellName.center =self.center;
    _cellName.frame =CGRectMake(15, _cellName.frame.origin.y, _cellName.frame.size.width, _cellName.frame.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
