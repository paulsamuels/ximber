//
//  PASObjectConnections.m
//  ximber
//
//  Created by Paul Samuels on 15/09/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

#import "PASObjectConnections.h"

@interface PASObjectConnections ()

@property (nonatomic, strong) NSMutableSet *mutableConnections;

@end

@implementation PASObjectConnections

+ (instancetype)objectConnectionsWithObjectID:(NSString *)objectID;
{
  PASObjectConnections *instance = [[self alloc] init]; {
    instance->_objectID = [objectID copy];
  }
  
  return instance;
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    _mutableConnections = [[NSMutableSet alloc] init];
  }
  return self;
}

- (void)addConnectionNamed:(NSString *)connectionName;
{
  [self.mutableConnections addObject:connectionName];
}

- (NSSet *)connections;
{
  return [self.mutableConnections copy];
}

- (NSString *)description;
{
  return [NSString stringWithFormat:@",%@: %p, connections: %@",
          self.class,
          self,
          self.connections];
}

@end
