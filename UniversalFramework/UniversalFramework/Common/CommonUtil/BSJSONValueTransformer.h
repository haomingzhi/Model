
#import <Foundation/Foundation.h>


/////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - extern definitons
/**
 * Boolean function to check for null values. Handy when you need to both check
 * for nil and [NSNUll null]
 */
extern BOOL isNull(id value);

/////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - JSONValueTransformer interface
/**
 * **You don't need to call methods of this class manually.** 
 *
 * Class providing methods to transform values from one class to another.
 * You are given a number of built-in transformers, but you are encouraged to
 * extend this class with your own categories to add further value transformers.
 * Just few examples of what can you add to JSONValueTransformer: hex colors in JSON to UIColor,
 * hex numbers in JSON to NSNumber model properties, base64 encoded strings in JSON to UIImage properties, and more.
 *
 * The class is invoked by JSONModel while transforming incoming
 * JSON types into your target class property classes, and vice versa.
 * One static copy is create and store in the JSONModel class scope.
 */
@interface BSJSONValueTransformer : NSObject



#pragma mark - string <-> url
/** @name Transforming URLs */
/**
 * Transforms a string object to an NSURL object
 * @param string the string to convert
 * @return the resulting url object
 */
+(NSURL*)NSURLFromNSString:(NSString*)string;

/**
 * Transforms an NSURL object to a string
 * @param url the url object to convert
 * @return the resulting string
 */
+(NSString*)JSONObjectFromNSURL:(NSURL*)url;


#pragma mark - string <-> date
/** @name Transforming Dates */
/**
 * The following two methods are not public. This way if there is a category on converting 
 * dates it'll override them. If there isn't a category the default methods found in the .m
 * file will be invoked. If these are public a warning is produced at the point of overriding
 * them in a category, so they have to stay hidden here.
 */

//-(NSDate*)NSDateFromNSString:(NSString*)string;
//-(NSString*)JSONObjectFromNSDate:(NSDate*)date;

#pragma mark - number <-> date

/**
 * Transforms a number to an NSDate object
 * @param number the number to convert
 * @return the resulting date
 */
+ (NSDate*)NSDateFromNSNumber:(NSNumber*)number;


#pragma mark - BURes<-> string

+(id)BUResFromNSString:(NSString *) string;


@end
