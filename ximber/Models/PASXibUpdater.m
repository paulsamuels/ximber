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
@property (nonatomic, copy)   NSDictionary  *outletMappings;

@end

@implementation PASXibUpdater

- (instancetype)initWithXMLDocument:(NSXMLDocument *)document outletMappings:(NSDictionary *)outletMappings;
{
  self = [super init];
  if (self) {
    _document       = document;
    _outletMappings = [outletMappings copy];
  }
  return self;
}

- (BOOL)modify:(NSError **)error;
{
  [self.outletMappings enumerateKeysAndObjectsUsingBlock:^(id _, PASObjectConnections *objectConnections, BOOL *stop) {
    NSError *findNodeError = nil;
    NSXMLElement *node = [self.document nodesForXPath:[NSString stringWithFormat:@"//*[@id='%@']", objectConnections.objectID]
                                                error:&findNodeError].firstObject;
    
    if (!node) {
      NSLog(@"Could not find node: %@", findNodeError.localizedDescription);
    }
    
    if (![node attributeForName:PASKeys.object.userLabel]) {
      NSString *userLabel = [[objectConnections.connections.allObjects sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] componentsJoinedByString:@", "];
      [node addAttribute:[NSXMLNode attributeWithName:PASKeys.object.userLabel
                                          stringValue:userLabel]];
    }
  }];
  return YES;
}

@end
