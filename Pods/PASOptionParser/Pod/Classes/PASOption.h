//
//  PASOption.h
//  PASOptionParser
//
//  Created by Paul Samuels on 28/09/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

@import Foundation;

@interface PASOption : NSObject

@property (nonatomic, assign, getter=hasRequiredArgument, readonly) BOOL     requiredArgument;
@property (nonatomic, copy, readonly)                               NSString *shortFlag;
@property (nonatomic, copy, readonly)                               NSString *longFlag;
@property (nonatomic, copy, readonly)                               NSString *format;

@property (nonatomic, copy, readonly) void (^handler)(PASOption *option, id argument);

+ (instancetype)optionWithFormat:(NSString *)format handler:(void (^)(PASOption *option, id argument))handler;
- (void)invokeWithArgument:(id)argument;

@end
