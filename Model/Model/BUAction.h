

#import "BUImageRes.h"

@interface BUAction : BUBase

@property(strong,nonatomic) BUImageRes *img;
@property(strong,nonatomic) NSString *url;

+(NSString *)getContentStr:(BUBase*)action;
@end
