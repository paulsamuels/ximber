//
//  PASOptionParser.m
//  PASOptionParser
//
//  Created by Paul Samuels on 26/09/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

#import "PASOptionParser.h"

// Categories
#import "NSString+PASOptionHelpers.h"

// Models
#import "PASOption.h"

@interface PASOptionParser ()

@property (nonatomic, strong) NSMutableDictionary *options;

@end

@implementation PASOptionParser

- (instancetype)init
{
  self = [super init];
  if (self) {
    _options = NSMutableDictionary.dictionary;
  }
  return self;
}

- (void (^)(NSString *, void (^)(PASOption *, id)))onOption;
{
  return ^(NSString *format, void (^handler)(PASOption *option, id argument)){
    [self addOption:({
      [PASOption optionWithFormat:format handler:handler];
    })];
  };
}

- (void)addOption:(PASOption *)option;
{
  if (option.shortFlag) {
    self.options[option.shortFlag] = option;
  }
  
  if (option.longFlag) {
    self.options[option.longFlag] = option;
  }
}

- (NSArray *)parseWithArgumentCount:(NSInteger)count arguments:(const char **)arguments;
{
  PASOption      *unhandledOption      = nil;
  NSMutableArray *collectedArguments   = NSMutableArray.array;
  BOOL            shouldParseArguments = YES;
  
  for (int i = 1; i < count; i++) {
    NSString *input = @(arguments[i]);
    
    if ([input isEqualToString:@"--"]) {
      shouldParseArguments = NO;
      continue;
    }
    
    NSArray  *components = [input componentsSeparatedByString:@"="];
    NSString *argument   = nil;
    
    if (!unhandledOption && shouldParseArguments && 2 == components.count && [components.lastObject length] > 0) {
      input    = components.firstObject;
      argument = components.lastObject;
    }
    
    if ([input pas_isArgument] && shouldParseArguments) {
      if (unhandledOption) {
        [self notifyIncorrectlyHandledOption:unhandledOption];
      }
      
      NSString *strippedFlag = input.pas_stringByRemovingArgumentPrefix;
      
      if ([strippedFlag hasPrefix:@"no-"] && self.options[[strippedFlag substringFromIndex:3]]) {
        [self.options[[strippedFlag substringFromIndex:3]] invokeWithArgument:@NO];
        continue;
      }

      if (self.options[input.pas_stringByRemovingArgumentPrefix]) {
        unhandledOption = [self handleOption:self.options[strippedFlag] withArgument:argument];
      } else if ([input pas_isShortArgument]) {
        unhandledOption = [self handleShortOptions:input withArgument:argument];
      }
    } else {
      if (unhandledOption) {
        [unhandledOption invokeWithArgument:input];
        unhandledOption = nil;
      } else {
        [collectedArguments addObject:input];
      }
    }
  }
  
  if (unhandledOption) {
    [self notifyIncorrectlyHandledOption:unhandledOption];
  }
  
  return collectedArguments;
}

- (PASOption *)handleShortOptions:(NSString *)input withArgument:(NSString *)argument;
{
  NSMutableSet *characters = NSMutableSet.set;
  
  for (int i = 0; i < input.pas_stringByRemovingArgumentPrefix.length; i++) {
    NSString *character = [NSString stringWithFormat:@"%c", [input.pas_stringByRemovingArgumentPrefix characterAtIndex:i]];
    
    if ([characters containsObject:character]) {
      continue;
    }
    
    if (self.options[character]) {
      PASOption *option = self.options[character];
      if ([option hasRequiredArgument] && i < input.pas_stringByRemovingArgumentPrefix.length - 1) {
        [self notifyIncorrectlyHandledOption:option];
      }
      
      return [self handleOption:self.options[character] withArgument:argument];
    } else {
      NSLog(@"Ignoring unkown flag \"-%@\"", character);
    }
    
    [characters addObject:character];
  }

  return nil;
}

- (PASOption *)handleOption:(PASOption *)option withArgument:(NSString *)argument;
{
  if ([option hasRequiredArgument]) {
    if (argument) {
      [option invokeWithArgument:argument];
    } else {
      return option;
    }
  } else {
    [option invokeWithArgument:@YES];
  }
  
  return nil;
}

- (void)notifyIncorrectlyHandledOption:(PASOption *)incorrectlyHandledOption;
{
  [NSException raise:NSInternalInconsistencyException format:@"\"%@\" requires an argument!!!", incorrectlyHandledOption.format];
}

@end
