//
//  PASXibKeys.m
//  ximber
//
//  Created by Paul Samuels on 17/11/2014.
//  Copyright (c) 2014 Paul Samuels. All rights reserved.
//

#import "PASXibKeys.h"

const struct PASKeys PASKeys = {
  
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
