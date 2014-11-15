//
//  NSMutableDictionary+PASAdditions.m
//  ximber
//
//  Created by Paul Samuels on 15/09/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

#import "NSMutableDictionary+PASAdditions.h"

@implementation NSMutableDictionary (PASAdditions)

- (id)pas_valueForKey:(id<NSCopying>)key
         defaultValue:(id (^)(id<NSCopying>))defaultValue;
{
  id result = self[key];
  
  if (!result) {
    self[key] = result = defaultValue(key);
  }
  
  return result;
}

@end
