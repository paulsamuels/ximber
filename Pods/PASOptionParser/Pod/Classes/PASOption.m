//
//  PASOption.m
//  PASOptionParser
//
//  Created by Paul Samuels on 28/09/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

#import "PASOption.h"

// Categories
#import "NSString+PASOptionHelpers.h"

@implementation PASOption

+ (instancetype)optionWithFormat:(NSString *)format handler:(void (^)(PASOption *option, id argument))handler;
{
  PASOption *instance = [[self alloc] init]; {
    instance->_handler = [handler copy];
    instance->_format  = [format  copy];
    
    NSScanner *scanner = [NSScanner scannerWithString:format];
    
    NSString *options = nil;
    [scanner scanCharactersFromSet:self.optionCharacterSet intoString:&options];
    
    for (NSString *option in [options componentsSeparatedByString:@"/"]) {
      if ([option pas_isLongArgument]) {
        instance->_longFlag = [option.pas_stringByRemovingArgumentPrefix copy];
      } else if ([option pas_isShortArgument]) {
        instance->_shortFlag = [option.pas_stringByRemovingArgumentPrefix copy];
      }
    }
    
    if ([scanner isAtEnd]) {
      return instance;
    }
    
    NSString *requiredArgument = nil;
    [scanner scanCharactersFromSet:self.requiredArgumentCharacterSet intoString:&requiredArgument];
    
    if (requiredArgument) {
      instance->_requiredArgument = YES;
    }
  }
  
  return instance;
}

+ (NSCharacterSet *)optionCharacterSet;
{
  NSMutableCharacterSet *optionCharacterSet = [NSMutableCharacterSet characterSetWithCharactersInString:@"-/"]; {
    [optionCharacterSet formUnionWithCharacterSet:NSCharacterSet.alphanumericCharacterSet];
  }
  return optionCharacterSet;
}

+ (NSCharacterSet *)requiredArgumentCharacterSet;
{
  return NSMutableCharacterSet.alphanumericCharacterSet;
}

- (void)invokeWithArgument:(id)argument;
{
  self.handler(self, argument);
}

- (NSString *)description;
{
  return [NSString stringWithFormat:@"<%@: %p, shortFlag: %@, longFlag: %@, hasRequiredArgument: %d, format: %@>",
          self.class,
          self,
          self.shortFlag,
          self.longFlag,
          [self hasRequiredArgument],
          self.format];
}

@end
