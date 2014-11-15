//
//  NSString+PASOptionHelpers.h
//  PASOptionParser
//
//  Created by Paul Samuels on 27/09/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

@import Foundation;

@interface NSString (PASOptionHelpers)

- (BOOL)pas_isArgument;
- (BOOL)pas_isShortArgument;
- (BOOL)pas_isLongArgument;
- (NSString *)pas_stringByRemovingArgumentPrefix;

@end
