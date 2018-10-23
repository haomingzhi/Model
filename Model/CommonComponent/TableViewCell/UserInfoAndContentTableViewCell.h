//
//  UserInfoAndContentTableViewCell.h
//  
//
//  Created by air on 15/12/16.
//
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface UserInfoAndContentTableViewCell : JYAbstractTableViewCell
@property(nonatomic,strong) void (^moreAction)(id o);
@property(nonatomic,strong) void (^selectBtnHandle)(id o);
@property(nonatomic,strong) void (^tapLinkAction)(id o);
@property(nonatomic,strong) void (^longPressLinkAction)(id o);
@end
