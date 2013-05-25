//
//  CoreDataManipulator.h
//  ProVocNov
//
//  Created by Mark James Thompson on 5/9/10.
//  Copyright 2010 Arete Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CoreDataManipulator : NSObject {

}

+(NSArray *)fetchManagedObjectsForEntity:(NSManagedObjectContext *)managedObjectContext 
								entity:(NSString *)entityName 
							 attribute:(NSString *)attributeName 
						attributeValue:(id)attributeValue;

@end
