//
//  NSXMLElement+PASConstraintAdditions.h
//  ximber
//
//  Created by Paul Samuels on 17/11/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

@import Foundation;

@interface NSXMLElement (PASConstraintAdditions)

- (NSString *)pas_relationDescription;
- (NSString *)pas_constant;
- (NSString *)pas_firstAttribute;
- (NSString *)pas_firstItem;
- (NSString *)pas_multiplier;
- (NSString *)pas_secondAttribute;
- (NSString *)pas_secondItem;
- (NSString *)pas_relation;

@end
