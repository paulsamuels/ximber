//
//  NSXMLElement+PASConstraintAdditions.m
//  ximber
//
//  Created by Paul Samuels on 17/11/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

#import "NSXMLElement+PASConstraintAdditions.h"

static const struct PASEquality {
  __unsafe_unretained NSString *equalsFormat;
  
  struct {
    __unsafe_unretained NSString *format;
    __unsafe_unretained NSString *key;
  } greaterThanOrEqual;
  
  struct {
    __unsafe_unretained NSString *format;
    __unsafe_unretained NSString *key;
  } lessThanOrEqual;
  
} PASEquality = {
  .equalsFormat = @"==",
  
  .greaterThanOrEqual = {
    .format = @">=",
    .key    = @"greaterThanOrEqual",
  },
  
  .lessThanOrEqual = {
    .format = @"<=",
    .key    = @"lessThanOrEqual",
  },
};

@implementation NSXMLElement (PASConstraintAdditions)

- (NSString *)pas_relationDescription;
{
  NSString *result   = PASEquality.equalsFormat;
  NSString *relation = self.pas_relation;
  
  if ([relation isEqualToString:PASEquality.lessThanOrEqual.key]) {
    result = PASEquality.lessThanOrEqual.format;
  } else if ([relation isEqualToString:PASEquality.greaterThanOrEqual.key]) {
    result = PASEquality.greaterThanOrEqual.format;
  }
  
  return result;
}

- (NSString *)pas_constant;
{
  return [self attributeForName:@"constant"].stringValue;
}

- (NSString *)pas_firstAttribute;
{
  return [self attributeForName:@"firstAttribute"].stringValue;
}

- (NSString *)pas_firstItem;
{
  return [self attributeForName:@"firstItem"].stringValue;
}

- (NSString *)pas_multiplier;
{
  return [self attributeForName:@"multiplier"].stringValue;
}

- (NSString *)pas_secondAttribute;
{
  return [self attributeForName:@"secondAttribute"].stringValue;
}

- (NSString *)pas_secondItem;
{
  return [self attributeForName:@"secondItem"].stringValue;
}

- (NSString *)pas_relation;
{
  return [self attributeForName:@"relation"].stringValue;
}

@end
