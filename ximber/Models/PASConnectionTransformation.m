//
//  PASConnectionTransformation.m
//  ximber
//
//  Created by Paul Samuels on 15/09/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

#import "PASConnectionTransformation.h"

@implementation PASConnectionTransformation

+ (instancetype)connectionTransformationWithXPath:(NSString *)xPath keyTransformer:(NSString *(^)(NSString *))keyTransformer;
{
  PASConnectionTransformation *instance = [[self alloc] init]; {
    instance->_xPath          = [xPath copy];
    instance->_keyTransformer = [keyTransformer copy];
  }
  
  return instance;
}

@end
