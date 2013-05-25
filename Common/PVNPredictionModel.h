//
//  PVNPredictionModel.h
//  ProVocNov
//
//  Created by Mark James Thompson on 4/4/13.
//  Copyright (c) 2013 Mark James Thompson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "gsl_math.h"

@interface PVNPredictionModel : NSObject


@property NSNumber *intercept;
@property NSNumber *decayScale;
@property NSNumber *noise;
@property NSNumber *inferenceScalar;
@property NSNumber *encodingScalar;
@property NSNumber *threshhold;
@property NSNumber *coefficientOfDetermination;


+(void)setNextReviewDate:(NSManagedObject*)synapse;

@end
