//
//  JSONValueTransformer.m
//
//  @version 1.0.2
//  @author Marin Todorov, http://www.touch-code-magazine.com
//

// Copyright (c) 2012-2014 Marin Todorov, Underplot ltd.
// This code is distributed under the terms and conditions of the MIT license.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
// The MIT License in plain English: http://www.touch-code-magazine.com/JSONModel/MITLicense

#import "BSJSONValueTransformer.h"
#import "BURes.h"

#pragma mark - functions
extern BOOL isNull(id value)
{
    if (!value) return YES;
    if ([value isKindOfClass:[NSNull class]]) return YES;
    
    return NO;
}

@implementation BSJSONValueTransformer



#pragma mark - string <-> url
+(NSURL*)NSURLFromNSString:(NSString*)string
{
    return [NSURL URLWithString:[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

+(NSString*)JSONObjectFromNSURL:(NSURL*)url
{
    return [url absoluteString];
}

#pragma mark - string <-> date
+(NSDateFormatter*)importDateFormatter
{
    static dispatch_once_t onceInput;
    static NSDateFormatter* inputDateFormatter;
    dispatch_once(&onceInput, ^{
        inputDateFormatter = [[NSDateFormatter alloc] init];
        [inputDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [inputDateFormatter setDateFormat:@"yyyy-MM-dd'T'HHmmssZZZ"];
    });
    return inputDateFormatter;
}

+(NSDate*)__NSDateFromNSString:(NSString*)string
{
    string = [string stringByReplacingOccurrencesOfString:@":" withString:@""]; // this is such an ugly code, is this the only way?
    return [self.importDateFormatter dateFromString: string];
}

+(NSString*)__JSONObjectFromNSDate:(NSDate*)date
{
    static dispatch_once_t onceOutput;
	static NSDateFormatter *outputDateFormatter;
    dispatch_once(&onceOutput, ^{
        outputDateFormatter = [[NSDateFormatter alloc] init];
        [outputDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [outputDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
    });
    return [outputDateFormatter stringFromDate:date];
}

#pragma mark - number <-> date

+ (NSDate*)NSDateFromNSNumber:(NSNumber*)number
{
    return [NSDate dateWithTimeIntervalSince1970:number.doubleValue];
}

#pragma mark - BURes<-> string

+(id)BUResFromNSString:(NSString *) string
{
    return [[BURes alloc] initWith:@"" relativeURL:string type:BURESTYPE_IMAGE];
}

@end
