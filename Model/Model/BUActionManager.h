d

#import "BUAction.h"

typedef NS_ENUM(NSInteger, BSACTIONTYPE)
{
    BSACTIONTYPE_News=1,            //资讯轮播图
    BSACTIONTYPE_SIKI,              //特价
    BSACTIONTYPE_TRADE,             //所有
};

@interface BUActionManager : BUManager

@property(nonatomic,readonly) NSMutableArray *actions;         
@property(nonatomic) BUAction *current;

-(BOOL)updateActionList:(BSACTIONTYPE) actionType categoryId:(NSString *) categoryId  observer:(id)observer callback:(SEL)callback;

@end
