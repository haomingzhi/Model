

#import "BUCategory.h"




@implementation BUCategory

-(id) init
{
    self = [super init];
    if (self) {
        self.deserializationMap = @{@"id":@"CategoryId",@"type_name":@"CategoryName"};
    }
    return self;
}


@end
