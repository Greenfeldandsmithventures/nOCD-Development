//
//  XMLReader.h
//

#import <Foundation/Foundation.h>

enum {
    XMLReaderOptionsProcessNamespaces           = 1 << 0, // Specifies whether the receiver reports the namespace and the qualified name of an element.
    XMLReaderOptionsReportNamespacePrefixes     = 1 << 1, // Specifies whether the receiver reports the scope of namespace declarations.
    XMLReaderOptionsResolveExternalEntities     = 1 << 2, // Specifies whether the receiver reports declarations of external entities.
};
typedef NSUInteger XMLReaderOptions;

@interface XMLReader : NSObject <NSXMLParserDelegate>

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data valueForKey:(NSString*)key error:(NSError **)error;
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string valueForKey:(NSString*)key error:(NSError **)error;
+ (NSDictionary *)dictionaryForXMLData:(NSData *)data options:(XMLReaderOptions)options error:(NSError **)errorPointer;
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string options:(XMLReaderOptions)options error:(NSError **)errorPointer;

@end
