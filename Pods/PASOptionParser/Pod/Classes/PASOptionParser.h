//
//  PASOptionParser.h
//  PASOptionParser
//
//  Created by Paul Samuels on 26/09/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

@import Foundation;

@class PASOption;

@interface PASOptionParser : NSObject

@property (nonatomic, copy, readonly) void (^onOption)(NSString *format, void (^handler)(PASOption *option, id argument));
@property (nonatomic, copy) void (^onCompletion)(NSArray *arguments);

- (void)addOption:(PASOption *)option;
- (NSArray *)parseWithArgumentCount:(NSInteger)count arguments:(const char **)arguments;

@end
