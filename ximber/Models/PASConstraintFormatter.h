//
//  PASConstraintFormatter.h
//  ximber
//
//  Created by Paul Samuels on 17/11/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

@import Foundation;

@interface PASConstraintFormatter : NSObject

+ (NSString *)formatWithOutlet:(NSXMLElement *)outlet attributes:(NSArray *)attributes document:(NSXMLDocument *)document;

@end
