//
//  CoreDataManipulator.m
//  ProVocNov
//
//  Created by Mark James Thompson on 5/9/10.
//  Copyright 2010 Arete Group. All rights reserved.
//
#import "CoreDataManipulator.h"
@implementation CoreDataManipulator


+(NSArray *)fetchManagedObjectsForEntity:(NSManagedObjectContext *)managedObjectContext 
								  entity:(NSString *)entityName 
							   attribute:(NSString *)attributeName 
						  attributeValue:(id)attributeValue{
	
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		[request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext]];
		
		if (attributeName == nil) {
			//  NSLog(@"No attributes sepecified; please specify an attribute");
		} else {	
			
			if (([attributeValue isKindOfClass:[NSString class]])||(attributeValue == nil)) {
				[request setPredicate:[NSPredicate predicateWithFormat:@"%K == %@",attributeName,attributeValue]];
			} else if ([attributeValue isEqualToString:@"YES"]) {
				[request setPredicate:[NSPredicate predicateWithFormat:@"%K = %d",attributeName, 1]];
			} else if ([attributeValue isEqualToString:@"NO"]){
				[request setPredicate:[NSPredicate predicateWithFormat:@"%K = %d",attributeName, 0]];
			} else {
				[request setPredicate:[NSPredicate predicateWithFormat:@"%K = %d",attributeName,[attributeValue intValue]]];
			}
		}//fi
	
	//NSLog(@"Fetch request is: %@",request);
	
	NSError *error = nil;
	
	NSArray *results = [NSArray arrayWithArray:[managedObjectContext executeFetchRequest:request error:&error]];
	//NSLog(@"Core Data Manipulator = %@",[[results objectAtIndex:0] valueForKey:@"name"]);
	return results;
}
/*
+(NSArray *)fetchExactManagedObjectsFromContext:(NSManagedObjectContext *)managedObjectContext
									entityNamed:(NSString *)entityName
								 attributeNamed:(NSString *)attributeName
							 withAttributeValue:(id)attributeValue{
	
	
	
	
	return results;
}
 
 */




@end
