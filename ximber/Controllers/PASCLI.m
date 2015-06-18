//
//  PASCLI.m
//  ximber
//
//  Created by Paul Samuels on 15/11/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

#import "PASCLI.h"

#import "PASXibParser.h"
#import "PASXibUpdater.h"

// Pods
#import <PASOptionParser/PASOptionParser.h>

#import "PASConstraintParser.h"

@interface PASCLI ()

@property (nonatomic, copy) NSString *outputDirectory;
@property (nonatomic, copy) NSArray  *xibFiles;

@end

@implementation PASCLI

- (instancetype)initWithArgc:(int)argc argv:(const char **)argv;
{
  self = [super init];
  if (self) {
    PASOptionParser *optionParser = [[PASOptionParser alloc] init]; {
      optionParser.onOption(@"-o/--output DIRECTORY", ^(PASOption *option, id argument) {
        _outputDirectory = argument;
      });
    }
    
    _xibFiles = [[optionParser parseWithArgumentCount:argc arguments:argv] copy];
  }
  return self;
}

- (BOOL)run:(NSError **)error;
{
  for (NSString *xibName in self.xibFiles) {
    NSURL *documentURL = [NSURL fileURLWithPath:xibName];
    
    NSXMLDocument *document = ({
      [[NSXMLDocument alloc] initWithContentsOfURL:documentURL
                                           options:kNilOptions
                                             error:NULL];
    });
    
    NSDictionary *mappings = [[[PASXibParser alloc] initWithXMLDocument:document] outletUserLabels];
    
    if (![[[PASXibUpdater alloc] initWithXMLDocument:document userLabels:mappings] modifyWithForce:NO error:error]) {
      return NO;
    }
    
    NSDictionary *constraintlabels = [[[PASConstraintParser alloc] initWithXMLDocument:document] userLabels];
    [[[PASXibUpdater alloc] initWithXMLDocument:document userLabels:constraintlabels] modifyWithForce:YES error:error];
    
    if (self.outputDirectory) {
      documentURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", self.outputDirectory, xibName.lastPathComponent]];
    }
    
    [[document XMLDataWithOptions:NSXMLNodePrettyPrint | NSXMLNodeCompactEmptyElement] writeToURL:documentURL atomically:YES];
  }
  
  return YES;
}

@end
