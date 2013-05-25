//
//  TERMENTRY.m
//  ProVocNov
//
//  Created by Mark James Thompson on 3/30/13.
//  Copyright (c) 2013 Mark James Thompson. All rights reserved.
//

#import "TERMENTRY.h"


@implementation TERMENTRY

@dynamic timeStamp;
@dynamic source;
@dynamic target;


- (id)init {
    self = [super init];
    if (self) {
        self.timeStamp = [NSDate date];
        self.source = @"yes";
        self.target = @"oui";
    }
    return self;
}


@end
