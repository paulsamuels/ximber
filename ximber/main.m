//
//  main.m
//  ximber
//
//  Created by Paul Samuels on 15/11/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

@import Foundation;

#import "PASCLI.h"

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    NSError *error = nil;
    
    if (![[[PASCLI alloc] initWithArgc:argc argv:argv] run:&error]) {
      NSLog(@"%@", error);
    }
  }
  return 0;
}
