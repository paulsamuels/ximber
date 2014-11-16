//
//  PASXibParser.m
//  ximber
//
//  Created by Paul Samuels on 15/11/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

#import "PASXibParser.h"

// Categories
#import "NSMutableDictionary+PASAdditions.h"

// Constants
#import "PASXibKeys.h"

// Models
#import "PASConnectionTransformation.h"
#import "PASObjectConnections.h"

@interface PASXibParser ()

@property (nonatomic, strong) NSXMLDocument *document;

@end

@implementation PASXibParser

- (instancetype)initWithXMLDocument:(NSXMLDocument *)document;
{
  self = [super init];
  if (self) {
    _document = document;
  }
  return self;
}

- (NSDictionary *)outletUserLabels;
{
  NSMutableDictionary *mappings = [[NSMutableDictionary alloc] init];
  
  NSArray *connectionsTransformations = ({
    @[
      [PASConnectionTransformation connectionTransformationWithXPath:PASKeys.xPath.outlets
                                                      keyTransformer:^(NSString *key) {
                                                        return key;
                                                      }],
      
      [PASConnectionTransformation connectionTransformationWithXPath:PASKeys.xPath.outletCollections
                                                      keyTransformer:^(NSString *key) {
                                                        return [NSString stringWithFormat:@"[%@]", key];
                                                      }],
      ];
  });
  
  for (PASConnectionTransformation *connectionTransformation in connectionsTransformations) {
    
    NSError *findOutletsError = nil;
    NSArray *outlets = [self.document nodesForXPath:connectionTransformation.xPath error:&findOutletsError];
    
    if (!outlets) {
      NSLog(@"Error finding outlets: %@", findOutletsError.localizedDescription);
    }
    
    for (NSXMLElement *outlet in outlets) {
      BOOL isFilesOwner = [[outlet attributeForName:PASKeys.outlet.destination] isEqualTo:@"-1"];
      if (isFilesOwner) {
        continue;
      }
      
      PASObjectConnections *connections = ({
        [mappings pas_valueForKey:[outlet attributeForName:PASKeys.outlet.destination].stringValue
                     defaultValue:^id(id<NSCopying> key) {
                       return [PASObjectConnections objectConnectionsWithObjectID:(id)key];
                     }];
      });
      
      [connections addConnectionNamed:({
        connectionTransformation.keyTransformer([outlet attributeForName:PASKeys.outlet.property].stringValue);
      })];
    }
  }
  
  NSMutableDictionary *results = NSMutableDictionary.dictionary;
  
  [mappings enumerateKeysAndObjectsUsingBlock:^(id _, PASObjectConnections *objectConnections, BOOL *stop) {
    NSString *userLabel = [[objectConnections.connections.allObjects sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] componentsJoinedByString:@", "];
    
    if (objectConnections.connections.count > 1) {
      userLabel = [NSString stringWithFormat:@"[%@]", userLabel];
    }
    
    results[objectConnections.objectID] = userLabel;
  }];

  return [results copy];
}

@end
