//
//  PASObjectConnections.h
//  ximber
//
//  Created by Paul Samuels on 15/09/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

@import Foundation;

/**
 * Basic model to represent a connection mapping
 *
 * It's possible for a single item in a xib to be referenced by
 * multiple outlets, hence connections is a collection
 */
@interface PASObjectConnections : NSObject

@property (nonatomic, copy, readonly) NSString *objectID;
@property (nonatomic, copy, readonly) NSSet    *connections;

+ (instancetype)objectConnectionsWithObjectID:(NSString *)objectID;

- (void)addConnectionNamed:(NSString *)connectionName;

@end
