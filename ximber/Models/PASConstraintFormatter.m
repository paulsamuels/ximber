//
//  PASConstraintFormatter.m
//  ximber
//
//  Created by Paul Samuels on 17/11/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

#import "PASConstraintFormatter.h"

// Categories
#import "NSArray+PASContains.h"
#import "NSXMLElement+PASConstraintAdditions.h"
#import "NSXMLElement+PASXibElementAdditions.h"

// Constants
#import "PASConstraintKeys.h"
#import "PASXibKeys.h"

@interface PASConstraintFormatter ()

@property (nonatomic, strong) NSArray       *attributes;
@property (nonatomic, copy)   NSString      *constant;
@property (nonatomic, strong) NSXMLDocument *document;
@property (nonatomic, strong) NSXMLElement  *outlet;
@property (nonatomic, copy)   NSString      *prettyConstant;

@end

@implementation PASConstraintFormatter

+ (NSString *)formatWithOutlet:(NSXMLElement *)outlet attributes:(NSArray *)attributes document:(NSXMLDocument *)document;
{
  return [[[self alloc] initWithOutlet:outlet attributes:attributes document:document] format];
}

- (instancetype)initWithOutlet:(NSXMLElement *)outlet attributes:(NSArray *)attributes document:(NSXMLDocument *)document;
{
  self = [super init];
  if (self) {
    _attributes     = attributes;
    _document       = document;
    _outlet         = outlet;
    _constant       = self.outlet.pas_constant ?: @"0";
    _prettyConstant = [NSString stringWithFormat:@"%@ %ld", _constant.integerValue < 0 ? @"-" : @"+", (long)ABS(_constant.integerValue)]; {
      _prettyConstant = 0 == _constant.integerValue ? @"" : _prettyConstant;
    }
  }
  return self;
}

- (NSString *)format;
{
  if (2 == self.attributes.count && [self.attributes.firstObject isEqual:self.attributes.lastObject]) {
    if ([@[ PASConstraintKeys.height, PASConstraintKeys.width ] containsObject:self.attributes.firstObject]) {
      
      NSString *direction  = [self.attributes.firstObject isEqual:PASConstraintKeys.height] ? @"V" : @"H";
      NSString *firstItem  = [self nameFromID:self.outlet.pas_firstItem] ?: @"parent";
      NSString *secondItem = [self nameFromID:self.outlet.pas_secondItem];
      
      if (self.constant) {
        return [NSString stringWithFormat:@"%@:[%@(==%@%@)]", direction, firstItem, secondItem, self.prettyConstant];
      } else {
        return [NSString stringWithFormat:@"%@:[%@(==%@)]", direction, firstItem, secondItem];
      }
      
    } else if ([@[
                  PASConstraintKeys.baseline,
                  PASConstraintKeys.bottom,
                  PASConstraintKeys.leading,
                  PASConstraintKeys.top,
                  PASConstraintKeys.trailing,
                  ] containsObject:self.attributes.firstObject]) {
      
      return [self alignmentDescription];
      
    } else if ([self.attributes.firstObject hasPrefix:@"center"]) {
      
      return [self centerDescription];
    
    }
  }
  
  if ([self.attributes pas_containsObjects:@[ PASConstraintKeys.bottom, PASConstraintKeys.top ]] || [self.attributes pas_containsObjects:@[ PASConstraintKeys.leading, PASConstraintKeys.trailing ]]) {
    return [self spaceDescription];
  }
  
  if ([self.attributes pas_containsObjects:@[ PASConstraintKeys.height, PASConstraintKeys.width ]] && !self.outlet.pas_firstItem) {
    return [self aspectRatioDescription];
  }
  
  if (1 == self.attributes.count && ([self.attributes.firstObject isEqual:PASConstraintKeys.height] || [self.attributes.firstObject isEqual:PASConstraintKeys.width])) {
    return [self heightOrWidthDescription];
  }
  
  NSLog(@"We shouldn't get here - probably worth adding a new case or raising an issue\n%@ -> %@", self.attributes, self.outlet);
  return nil;
}

- (NSString *)heightOrWidthDescription;
{
  NSString     *direction = [self.attributes.firstObject isEqual:PASConstraintKeys.height] ? @"V" : @"H";
  NSXMLElement *viewNode  = (id)self.outlet.parent.parent;
  
  NSString *userLabel = [self nameFromID:viewNode.pas_ID];
  
  if (!userLabel) {
    userLabel = viewNode.pas_userLabel ?: viewNode.name;
  }
  
  return [NSString stringWithFormat:@"%@:[%@(%@%@)]",
          direction,
          userLabel,
          self.outlet.pas_relationDescription,
          self.constant];
}

- (NSString *)aspectRatioDescription;
{
  return [NSString stringWithFormat:@"%@.aspectRatio == %@",
          [self nameFromID:[(id)self.outlet.parent.parent pas_ID]],
          self.outlet.pas_multiplier];
}

- (NSString *)centerDescription;
{
  NSString *direction = [self.attributes.firstObject isEqual:PASConstraintKeys.centerX] ? @"X" : @"Y";
  
  return [NSString stringWithFormat:@"%@.mid%@ == %@.mid%@ %@",
          [self nameFromID:self.outlet.pas_firstItem] ?: @"super",
          direction,
          [self nameFromID:self.outlet.pas_secondItem],
          direction,
          self.prettyConstant];
}

- (NSString *)alignmentDescription;
{
  return [NSString stringWithFormat:@"%@.%@ == %@.%@ %@",
          [self nameFromID:self.outlet.pas_firstItem] ?: @"parent",
          self.attributes.firstObject,
          [self nameFromID:self.outlet.pas_secondItem],
          self.attributes.firstObject,
          self.prettyConstant];
}

- (NSString *)spaceDescription;
{
  NSString *topLabel    = nil;
  NSString *bottomLabel = nil;
  
  if ([@[ PASConstraintKeys.leading, PASConstraintKeys.top ] containsObject:self.outlet.pas_firstAttribute]) {
    topLabel    = [self nameFromID:self.outlet.pas_secondItem];
    bottomLabel = [self nameFromID:self.outlet.pas_firstItem];
  } else {
    topLabel    = [self nameFromID:self.outlet.pas_firstItem];
    bottomLabel = [self nameFromID:self.outlet.pas_secondItem];
  }
  
  NSString *direction = [self.attributes containsObject:PASConstraintKeys.top] ? @"V" : @"H";
  
  NSString *spacing = 0 == self.constant.integerValue ? @"" : [NSString stringWithFormat:@"-(%@%@)-", self.outlet.pas_relationDescription, self.constant];
  
  return [NSString stringWithFormat:@"%@:[%@]%@[%@]", direction, topLabel, spacing, bottomLabel];
}

- (NSString *)nameFromID:(NSString *)nodeID;
{
  if (!nodeID) {
    return nil;
  }
  
  NSError *findNodeError = nil;
  NSXMLElement *node = [self.document nodesForXPath:[NSString stringWithFormat:@"//*[@id='%@']", nodeID]
                                              error:&findNodeError].firstObject;
  
  if (!node) {
    NSLog(@"Could not find node: %@", findNodeError.localizedDescription);
  }

  return node.pas_userLabel ?: node.name;
}

@end
