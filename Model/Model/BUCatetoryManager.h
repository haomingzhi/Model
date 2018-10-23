
typedef NS_ENUM(NSInteger, BSCATETORYTYPE)
{
    BSCATETORYTYPE_News=1,// 资讯
    BSCATETORYTYPE_SIKI , //社交
     BSCATETORYTYPE_DealSell,//交易出售
    BSCATETORYTYPE_DealBuy,//交易求购
    BSCATETORYTYPE_DealBuyer//交易买手
};
@interface BUCatetoryManager : BUManager
@property(nonatomic) NSArray *CategoryList;
@property(nonatomic) NSInteger currentIndex;    //当前项

-(NSArray *) getCategoryNames;
-(BOOL)getCategoryList:(BSCATETORYTYPE) caType observer:(id)observer callback:(SEL)callback ;        //获取资讯分类表
@end
