//
//  PASXibKeys.h
//  ximber
//
//  Created by Paul Samuels on 15/11/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

@import Foundation;

static const struct PASKeys {
  
  struct {
    __unsafe_unretained NSString *userLabel;
  } object;
  
  struct {
    __unsafe_unretained NSString *destination;
    __unsafe_unretained NSString *property;
  } outlet;
  
  struct {
    __unsafe_unretained NSString *outletCollections;
    __unsafe_unretained NSString *outlets;
  } xPath;
  
} PASKeys = {
  
  .object = {
    .userLabel = @"userLabel",
  },
  
  .outlet = {
    .destination = @"destination",
    .property    = @"property",
  },
  
  .xPath = {
    .outletCollections = @"//connections/outletCollection",
    .outlets           = @"//connections/outlet",
  }
  
};