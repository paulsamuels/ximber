//
//  PASCLI.h
//  ximber
//
//  Created by Paul Samuels on 15/11/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

@import Foundation;

/**
 * The command line interface acts as the controller and kicks everything off
 */
@interface PASCLI : NSObject

- (instancetype)initWithArgc:(int)argc argv:(const char **)argv;
- (BOOL)run:(NSError **)error;

@end
