//
//  NSArray+PASContains.m
//  ximber
//
//  Created by Paul Samuels on 17/11/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

#import "NSArray+PASContains.h"

@implementation NSArray (PASContains)

- (BOOL)pas_containsObjects:(NSArray *)objects;
{
  NSMutableArray *comparisonObjects = [self mutableCopy];
  
  for (id object in objects) {
    NSInteger index = [comparisonObjects indexOfObject:object];
    
    if (NSNotFound == index) {
      return NO;
    }
    
    [comparisonObjects removeObjectAtIndex:index];
  }
  
  return YES;
}

@end
