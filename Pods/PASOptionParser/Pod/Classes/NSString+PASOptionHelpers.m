//
//  NSString+PASOptionHelpers.m
//  PASOptionParser
//
//  Created by Paul Samuels on 27/09/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

#import "NSString+PASOptionHelpers.h"

@implementation NSString (PASOptionHelpers)

- (BOOL)pas_isArgument;
{
  return [self pas_isLongArgument] || [self pas_isShortArgument];
}

- (BOOL)pas_isShortArgument;
{
  return [self hasPrefix:@"-"] && ![self pas_isLongArgument];
}

- (BOOL)pas_isLongArgument;
{
  return [self hasPrefix:@"--"];
}

- (NSString *)pas_stringByRemovingArgumentPrefix;
{
  if ([self pas_isLongArgument]) {
    return [self substringFromIndex:2];
  } else if ([self pas_isShortArgument]) {
    return [self substringFromIndex:1];
  }
  
  return self;
}

@end
