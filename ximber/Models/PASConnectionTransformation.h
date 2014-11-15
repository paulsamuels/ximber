//
//  PASConnectionTransformation.h
//  ximber
//
//  Created by Paul Samuels on 15/09/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

@import Foundation;

/**
 * The connection transformation is a basic data structure that holds a block that is
 * executed on each node found at the xpath
 */
@interface PASConnectionTransformation : NSObject

@property (nonatomic, copy, readonly) NSString *xPath;
@property (nonatomic, copy, readonly) NSString *(^keyTransformer)(NSString *key);

+ (instancetype)connectionTransformationWithXPath:(NSString *)xPath keyTransformer:(NSString *(^)(NSString *key))keyTransformer;

@end
