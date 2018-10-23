//
//  BUArea.m
//  ZhongGengGroup
//  地域信息
//  Created by luolc's macBook air on 15/4/12.


#import "BUArea.h"
#import "BUSystem.h"



@implementation BUAreaManager

   static id myObserver;
   static SEL myCallback;
static NSInteger counter;

-(void)loadFromDb
{
    self.areas = [[NSMutableArray alloc] init];
    NSString *filePath = [[NSBundle mainBundle]  pathForResource:@"region" ofType:@"txt"];
    NSString *fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    BSJSON *js = [[BSJSON  alloc] initWithData:[fileContent dataUsingEncoding:NSUTF8StringEncoding ] encoding:NSUTF8StringEncoding];
    BSJSON * dic = [js objectForKey:@"Address"];
    NSArray *provinces = [dic objectForKey:@"child"];
    for (BSJSON *p in provinces) {
        BUprovince *province = [[BUprovince alloc] init];
        province.region_name = [p objectForKey:@"region_name"];
        province.region_id = [p objectForKey:@"region_id"];
        NSArray * jsonCitys = (NSArray *)[ p objectForKey:@"child"];
        for (BSJSON * jsonCity in jsonCitys) {
            BUCity *city = [[BUCity alloc] init];
            city.region_name = [jsonCity objectForKey:@"region_name"];
            city.region_id =[jsonCity objectForKey:@"region_id"];
            city.region_type =[jsonCity objectForKey:@"region_type"];
            NSArray *jsonCountys = (NSArray *)[ jsonCity objectForKey:@"child"];
                for (BSJSON *jsonCounty in jsonCountys) {
                    BUCounty *county = [[BUCounty alloc] init];
//                    county.countyName = [jsonCounty objectForKey:@"region_name"];
//                    county.region_id =[jsonCounty objectForKey:@"region_id"];
//                    BUCity *city1 = [[BUCity alloc] init];
                    county.region_name = [jsonCounty objectForKey:@"region_name"];
                    county.region_id =[jsonCounty objectForKey:@"region_id"];
                    county.region_type =[jsonCounty objectForKey:@"region_type"];
                    [city.child addObject:county];
                }
            [province.child addObject:city];
        }
        [self.areas addObject:province];
        
    }
//    
//    self.areas = (NSMutableArray *)[[NSUserDefaults standardUserDefaults] objectForKey:@"Area"];
//    if (self.areas == NULL) {
//        self.areas = [[NSMutableArray alloc] init];
//    }
}





-(BOOL) updateAreaList:(id)observer callback:(SEL)callback
{
    myCallback = callback;
    myObserver = observer;
    return YES;
//    return [self sendRequest:[NSString stringWithFormat:@"%@%@?parentCode=1000",busiSystem.apiHost,BU_BUSINESS_Area]
//                        head:nil
//                      method:@"GET"
//                       async:YES
//             inputInvocation:NULL
//            outputInvocation:BSGetInvocationFromSel(self, @selector(updateAreaListOutput:ok:input:))
//                    observer:NULL
//                      action:NULL
//                   extraInfo:nil];
}

-(BUprovince *) getProvinceByName:(NSString *) provinceName
{
    NSInteger index = [self.areas indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        BUprovince *p = (BUprovince *) obj;
        if ([p.region_name isEqualToString:provinceName]) {
            //*stop = YES;
            return YES;
        }
        return NO;
    }];
    return (index == NSNotFound) ? NULL : (BUprovince *)self.areas[index];
}

#pragma mark --io

//-(NSError *)updateAreaListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
//{
//    
//    UNPACKETOUTPUTHEAD(recvData, ok);
//    //BOOL isFirst = YES;
//    NSArray * jsonProvinces = (NSArray *)[jsonObj objectForKey:@"data"];
//     [RequestStatus setRequestResultStatus:jsonObj];
//    counter += jsonProvinces.count;
//    for (BSJSON *jsonProvince in jsonProvinces) {
//        BUprovince *province = [[BUprovince alloc] init];
//        province.provinceId = [jsonProvince objectForKey:@"areaCode"];
//        province.provinceName = [jsonProvince objectForKey:@"areaName"];
//        //if (isFirst) {
//            [province updateCitys:NULL callback:NULL];
//            //isFirst = NO;
//        //}
//        
//        [self.areas addObject:province];
//    }
//    return SuccessedError;
//}

@end

@implementation BUprovince

-(id)init
{
    self = [super init];
    if (self) {
        self.child = [[NSMutableArray alloc] init];
    }
    return self;
}

//-(BUCity *) getCityByName:(NSString *)cityname
//{
//    NSInteger index = [self.citys indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
//        BUCity *c = (BUCity *) obj;
//        if ([c.cityName isEqualToString:cityname]) {
//            *stop = YES;
//            return YES;
//        }
//        return NO;
//    }];
//    return (index == NSNotFound) ? NULL : (BUCity *)self.citys[index];
//}

-(BOOL) updateCitys:(id)observer callback:(SEL)callback
{
//    if (self.citys.count >0) {
//        return [self sendLocalRequest:SuccessedError observer:observer action:callback extraInfo:NULL];
//    }
//    
//    NSString *provinceid = self.provinceId;
//        NSInvocation *input = BSGetInvocationFromSel(self, @selector(updateCitysInput:));
//        [input setArgument:&provinceid atIndex:2];
//        [input retainArguments];
//    return [self sendRequest:[NSString stringWithFormat:@"%@%@?parentCode=%@",busiSystem.apiHost,BU_BUSINESS_Area,provinceid]
//                        head:nil
//                      method:@"GET"
//                       async:YES
//             inputInvocation:input
//            outputInvocation:BSGetInvocationFromSel(self, @selector(updateCitysOutput:ok:input:))
//                    observer:observer
//                      action:callback
//                   extraInfo:nil];
    return YES;
}

#pragma mark --io
-(NSData *) updateCitysInput:(NSString *)provinceid
{
    return NULL;//[[NSString stringWithFormat:@"parentCode=%@",provinceid] dataUsingEncoding:NSUTF8StringEncoding];
}

//-(NSError *)updateCitysOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
//{
//    UNPACKETOUTPUTHEAD(recvData, ok);
//    counter--;
//    __unsafe_unretained NSString *provinceid;
//    [input getArgument:&provinceid atIndex:2];
//    NSArray * jsonCitys = (NSArray *)[jsonObj objectForKey:@"data"];
//     [RequestStatus setRequestResultStatus:jsonObj];
//    counter += jsonCitys.count;
//    for (BSJSON *jsonCity in jsonCitys) {
//        BUCity *city = [[BUCity alloc] init];
//        city.cityId = [jsonCity objectForKey:@"areaCode"];
//        city.cityName = [jsonCity objectForKey:@"areaName"];
//        city.provinceId = provinceid;
//        [city updateCountys:NULL callback:NULL];
//        [self.citys addObject:city];
//    }
//    
//    return SuccessedError;
//}

@end

@implementation BUCity

-(id)init
{
    self = [super init];
    if (self) {
        self.child = [[NSMutableArray alloc] init];
    }
    return self;
}

//-(BUCounty *) getCountyByName:(NSString *)countyName
//{
//    NSInteger index = [self.countys indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
//        BUCounty *c = (BUCounty *) obj;
//        if ([c.countyName isEqualToString:countyName]) {
//            *stop = YES;
//            return YES;
//        }
//        return NO;
//    }];
//    return (index == NSNotFound) ? NULL : (BUCounty *)self.countys[index];
//}

-(BOOL) updateCountys:(id)observer callback:(SEL)callback
{
//    if (self.countys.count >0) {
//        return [self sendLocalRequest:SuccessedError observer:observer action:callback extraInfo:NULL];
//    }
//    NSString *cityId = self.cityId;
//    NSInvocation *input = BSGetInvocationFromSel(self, @selector(updateRealestatesInput:));
//    [input setArgument:&cityId atIndex:2];
//    [input retainArguments];
//    return [self sendRequest:[NSString stringWithFormat:@"%@%@?parentCode=%@",busiSystem.apiHost,BU_BUSINESS_Area,cityId]
//                        head:nil
//                      method:@"GET"
//                       async:YES
//             inputInvocation:input
//            outputInvocation:BSGetInvocationFromSel(self, @selector(updateRealestatesOutput:ok:input:))
//                    observer:observer
//                      action:callback
//                   extraInfo:nil];
    return YES;
}


#pragma mark --io

-(NSData *)updateRealestatesInput:(NSString *)cityId
{
    return NULL;// [[NSString stringWithFormat:@"parentCode=%@",cityId] dataUsingEncoding:NSUTF8StringEncoding];
}

//-(NSError *)updateRealestatesOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
//{
//    UNPACKETOUTPUTHEAD(recvData, ok);
//    counter--;
//    NSArray * jsonCountys = (NSArray *)[jsonObj objectForKey:@"data"];
//     [RequestStatus setRequestResultStatus:jsonObj];
//    for (BSJSON *jsonCounty in jsonCountys) {
//        BUCounty *county = [[BUCounty alloc] init];
//        county.region_id = self.provinceId;
//        county.cityId = self.cityId;
//        county.countyCode = [jsonCounty objectForKey:@"areaCode"];
//        county.countyName = [jsonCounty objectForKey:@"areaName"];
//        [self.countys addObject:county];
//    }
//    if (counter ==0 && myObserver && myCallback) {
//        //[[NSUserDefaults standardUserDefaults] setObject:busiSystem.areaManager.areas forKey:@"Area"];
////        [myObserver performSelectorOnMainThread:myCallback
////                                            withObject:[BSNotification notificationWith:busiSystem.areaManager
////                                                                              extraInfo:NULL
////                                                                                  error:SuccessedError] waitUntilDone:NO];
//    }
//    return SuccessedError;
//}


-(ChineseString *)description
{
    return _chineseString;
}

@end

@implementation BUCounty



@end
