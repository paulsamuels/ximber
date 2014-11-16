//
//  PASXibUpdater.h
//  ximber
//
//  Created by Paul Samuels on 15/11/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

@import Foundation;

/**
 * The xib updater modifies the xml document in a "safe" way.
 *
 * The updater only attempts to add a user label to a connection only if one is not already present
 * so it won't clobber any manually entered names
 */
@interface PASXibUpdater : NSObject

- (instancetype)initWithXMLDocument:(NSXMLDocument *)document userLabels:(NSDictionary *)userLabels;
- (BOOL)modifyWithForce:(BOOL)force error:(NSError **)error;

@end
