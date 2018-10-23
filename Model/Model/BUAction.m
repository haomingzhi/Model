

#import "BUAction.h"

@implementation BUAction
-(id) init
{
    self = [super init];
    if (self) {
        self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
    }
    return self;
}

+(NSString *)getContentStr:(BUBase*)action;
{
    if ([action isKindOfClass:[BURes class]])
    {
        return ((BURes *)action).relativeURL;
    }
    return @"";
}
@end
