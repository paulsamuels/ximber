//
//  PASXibParser.h
//  ximber
//
//  Created by Paul Samuels on 15/11/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

@import Foundation;

/**
 * The xib parser deals with extracting all of the connection mappings from
 * a xib. This class does not modify the xml document in anyway
 */
@interface PASXibParser : NSObject

- (instancetype)initWithXMLDocument:(NSXMLDocument *)document;
- (NSDictionary *)outletMappings;

@end
