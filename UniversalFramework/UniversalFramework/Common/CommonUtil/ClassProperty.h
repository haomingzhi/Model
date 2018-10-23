

#import <Foundation/Foundation.h>

enum kCustomizationTypes {
    kNotInspected = 0,
    kCustom,
    kNo
    };

typedef enum kCustomizationTypes PropertySetterType;
typedef enum kCustomizationTypes PropertyGetterType;

/**
 * **You do not need to instantiate this class yourself.** This class is used internally by JSONModel
 * to inspect the declared properties of your model class.
 *
 * Class to contain the information, representing a class property
 * It features the property's name, type, whether it's a required property, 
 * and (optionally) the class protocol
 */
@interface ClassProperty : NSObject

/** The name of the declared property (not the ivar name) */
@property (nonatomic) NSString* name;

/** A property class type  */
@property (nonatomic) NSString * propertyType;


/** The name of the protocol the property conforms to (or nil) */
@property (nonatomic) NSString* protocol;

/** If YES, it can be missing in the input data, and the input would be still valid */
@property (assign, nonatomic) BOOL isOptional;


/** If YES - create a mutable object for the value of the property */
@property (assign, nonatomic) BOOL isMutable;

/** If YES - create models on demand for the array members */
@property (assign, nonatomic) BOOL convertsOnDemand;



/** The status of property getter introspection in a model */
@property (assign, nonatomic) PropertyGetterType getterType;

/** a custom getter for this property, found in the owning model */
@property (assign, nonatomic) SEL customGetter;

/** The status of property setter introspection in a model */
@property (assign, nonatomic) PropertySetterType setterType;

/** a custom setter for this property, found in the owning model */
@property (assign, nonatomic) SEL customSetter;

@end
