//
//  PASConstraintParser.m
//  ximber
//
//  Created by Paul Samuels on 16/11/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

#import "PASConstraintParser.h"

// Categories
#import "NSXMLElement+PASConstraintAdditions.h"
#import "NSXMLElement+PASXibElementAdditions.h"

// Models"
#import "PASConstraintFormatter.h"
#import "PASObjectConnections.h"

@interface PASConstraintParser ()

@property (nonatomic, strong) NSXMLDocument *document;

@end

@implementation PASConstraintParser

- (instancetype)initWithXMLDocument:(NSXMLDocument *)document;
{
  self = [super init];
  if (self) {
    _document = document;
  }
  return self;
}

- (NSDictionary *)userLabels;
{
  NSError *findOutletsError = nil;
  NSArray *outlets = [self.document nodesForXPath:@"//constraint" error:&findOutletsError];
  
  if (!outlets) {
    NSLog(@"Error finding outlets: %@", findOutletsError.localizedDescription);
  }
  
  NSMutableDictionary *userLabels = NSMutableDictionary.dictionary;
  
  for (NSXMLElement *outlet in outlets) {
    NSMutableArray *attributes = NSMutableArray.array;
    
    if (outlet.pas_firstAttribute) {
      [attributes addObject:outlet.pas_firstAttribute];
    }
    
    if (outlet.pas_secondAttribute) {
      [attributes addObject:outlet.pas_secondAttribute];
    }
    
    userLabels[outlet.pas_ID] = [PASConstraintFormatter formatWithOutlet:outlet attributes:attributes document:self.document];
  }
  
  return [userLabels copy];
}

@end