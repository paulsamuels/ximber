//
//  PASXibUpdater.m
//  ximber
//
//  Created by Paul Samuels on 15/11/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

#import "PASXibUpdater.h"

// Constants
#import "PASXibKeys.h"

// Models
#import "PASObjectConnections.h"

@interface PASXibUpdater ()

@property (nonatomic, strong) NSXMLDocument *document;
@property (nonatomic, copy)   NSDictionary  *userLabels;

@end

@implementation PASXibUpdater

- (instancetype)initWithXMLDocument:(NSXMLDocument *)document userLabels:(NSDictionary *)userLabels;
{
  self = [super init];
  if (self) {
    _document   = document;
    _userLabels = [userLabels copy];
  }
  return self;
}

- (BOOL)modifyWithForce:(BOOL)force error:(NSError **)error;
{
  [self.userLabels enumerateKeysAndObjectsUsingBlock:^(NSString *nodeID, NSString *userLabel, BOOL *stop) {
    NSError *findNodeError = nil;
    NSXMLElement *node = [self.document nodesForXPath:[NSString stringWithFormat:@"//*[@id='%@']", nodeID]
                                                error:&findNodeError].firstObject;
    
    if (!node) {
      NSLog(@"Could not find node: %@", findNodeError.localizedDescription);
    }
    
    if (force || ![node attributeForName:PASKeys.object.userLabel]) {
      [node addAttribute:[NSXMLNode attributeWithName:PASKeys.object.userLabel stringValue:userLabel]];
    }
  }];
  return YES;
}

@end