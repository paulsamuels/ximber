//
//  NSMutableDictionary+PASAdditions.h
//  ximber
//
//  Created by Paul Samuels on 15/09/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

@import Foundation;

@interface NSMutableDictionary (PASAdditions)

- (id)pas_valueForKey:(id<NSCopying>)key
         defaultValue:(id (^)(id<NSCopying> key))defaultValue;

@end
