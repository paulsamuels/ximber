//
//  PASConstraintParser.h
//  ximber
//
//  Created by Paul Samuels on 16/11/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

@import Foundation;

@interface PASConstraintParser : NSObject

- (instancetype)initWithXMLDocument:(NSXMLDocument *)document;
- (NSDictionary *)userLabels;

@end