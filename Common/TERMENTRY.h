//
//  TERMENTRY.h
//  ProVocNov
//
//  Created by Mark James Thompson on 3/30/13.
//  Copyright (c) 2013 Mark James Thompson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TERMENTRY : NSManagedObject

@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSString * target;

@end
