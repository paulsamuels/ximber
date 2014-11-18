//
//  NSXMLElement+PASXibElementAdditions.m
//  ximber
//
//  Created by Paul Samuels on 17/11/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

#import "NSXMLElement+PASXibElementAdditions.h"

@implementation NSXMLElement (PASXibElementAdditions)

- (NSString *)pas_ID;
{
  return [self attributeForName:@"id"].stringValue;
}

- (NSString *)pas_userLabel;
{
  return [self attributeForName:@"userLabel"].stringValue;
}

@end
