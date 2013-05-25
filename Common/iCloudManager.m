//
//  iCloudManager.m
//  ProVocNov
//
//  Created by Mark James Thompson on 3/30/13.
//  Copyright (c) 2013 Mark James Thompson. All rights reserved.
//

#import "iCloudManager.h"


@implementation iCloudManager

- (id)init {
    self = [super init];
    if (self) {
        self.fileManager = [NSFileManager defaultManager];
        id currentToken = [self.fileManager ubiquityIdentityToken];
        self.isSignedIntoICloud = (currentToken!=nil);
    }
    return self;
}


/*You'll learn a lot from this method.  If you have configured iCloud on your test devices, that token will not be nil and it will be the same on each device. The code below shows how to save the token.
 */

-(void) persistentICloudToken{
    id currentICloudToken;
  
    //If the user has not enabled iCloud on his or her phone, the currentToken value will be nil.
    if (((BOOL)[[NSUserDefaults standardUserDefaults] valueForKey:@"HasLaunchedOnce"]!= TRUE) && self.isSignedIntoICloud) {
        currentICloudToken = [[NSFileManager defaultManager] ubiquityIdentityToken];
    }
    
    
    /* If it's not nil, you'll want to save it someplace like NSUserDefaults, because if the current token changes, you'll need to adjust your persistent store accordingly
    */
    
    if (currentICloudToken) {
        NSData *newTokenData = [NSKeyedArchiver archivedDataWithRootObject:currentICloudToken];
        [[NSUserDefaults standardUserDefaults] setObject:newTokenData forKey:@"com.arete.provocnov.UbiquityIdentityToken"];
    } else {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"com.arete.provocnov.UbiquityIdentityToken"];
    }
}




-(void) requestPermissionToUseICloud{
    //Add ðis in second parse
    //((BOOL)[[NSUserDefaults standardUserDefaults] valueForKey:@"HasLaunchedOnce"]!= TRUE) &&
    if (self.isSignedIntoICloud){

NSArray *commonStrings = [NSArray arrayWithObjects:
                    @"Choose Storage Option",
                    @"Should documents be stored in iCloud and available on all your devices?",
                    @"Local Only",
                    @"iCloud",                  
                    nil];
    
#if (TARGET_OS_IPHONE)
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[commonStrings objectAtIndex:0]
                                                        message:[commonStrings objectAtIndex:1]
                                                       delegate: self
                                              cancelButtonTitle:[commonStrings objectAtIndex:2]
                                              otherButtonTitles:[commonStrings objectAtIndex:3]
                               ,nil];
        [alert show];

#else 
    NSAlert *alert = [NSAlert alertWithMessageText:[commonStrings objectAtIndex:0]
                                     defaultButton:[commonStrings objectAtIndex:3]
                                   alternateButton:[commonStrings objectAtIndex:2]
                                       otherButton:@""
                         informativeTextWithFormat:[commonStrings objectAtIndex:1],nil];
        

        [alert runModal];
#endif

    }
}
    

-(NSURL *)createICloudDataDirectory {
    /*This method creates the iCloud data directory and returns the NSURL reference to the SQLite store that will go within it, CoreDataBooks.sqlite. The URLForUbiquityContainerIdentifier method takes a string argument this is the full bundle name, including company identifier, for my app. From that path, I'm creating a Data.nosync folder. It is into that folder we're going to put the SQLite database.
     */
    NSURL *storeURL = [self.fileManager URLForUbiquityContainerIdentifier:@"M2CJ3284E3.com.arete.ProVocNov"];
    NSURL *dataFolder = [storeURL URLByAppendingPathComponent:@"Data.nosync"];
    //that nosync file extension is important!
    NSURL *dataFile = [dataFolder URLByAppendingPathComponent:@"CoreDataProVocNov.sqlite"];
    BOOL isDirectory = YES;
    NSError *error;
    if(![self.fileManager fileExistsAtPath:[dataFolder path] isDirectory:&isDirectory])
        if(![self.fileManager createDirectoryAtURL:dataFolder withIntermediateDirectories:YES attributes:nil error:&error])
            NSLog(@"Create Directory Error %@, %@", error, [error userInfo]);
    NSLog(@"dataFile=%@",[dataFile path]);
    return dataFile;
    
}

/*

 - (void)deDupe:(NSNotification *)importNotification {
 //if importNotification, scope dedupe by inserted records
 //else no search scope, prey for efficiency.
 @autoreleasepool {
 NSError *error = nil;
 NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] init];
 [moc setPersistentStoreCoordinator:_psc];
 
 NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
 [fr setIncludesPendingChanges:NO]; //distinct has to go down to the db, not implemented for in memory filtering
 [fr setFetchBatchSize:1000]; //protect thy memory
 
 NSExpression *countExpr = [NSExpression expressionWithFormat:@"count:(emailAddress)"];
 NSExpressionDescription *countExprDesc = [[NSExpressionDescription alloc] init];
 [countExprDesc setName:@"count"];
 [countExprDesc setExpression:countExpr];
 [countExprDesc setExpressionResultType:NSInteger64AttributeType];
 
 NSAttributeDescription *emailAttr = [[[[[_psc managedObjectModel] entitiesByName] objectForKey:@"Person"] propertiesByName] objectForKey:@"emailAddress"];
 [fr setPropertiesToFetch:[NSArray arrayWithObjects:emailAttr, countExprDesc, nil]];
 [fr setPropertiesToGroupBy:[NSArray arrayWithObject:emailAttr]];
 
 [fr setResultType:NSDictionaryResultType];
 
 NSArray *countDictionaries = [moc executeFetchRequest:fr error:&error];
 NSMutableArray *emailsWithDupes = [[NSMutableArray alloc] init];
 for (NSDictionary *dict in countDictionaries) {
 NSNumber *count = [dict objectForKey:@"count"];
 if ([count integerValue] > 1) {
 [emailsWithDupes addObject:[dict objectForKey:@"emailAddress"]];
 }
 }
 
 NSLog(@"Emails with dupes: %@", emailsWithDupes);
 
 //fetch out all the duplicate records
 fr = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
 [fr setIncludesPendingChanges:NO];
 
 
 NSPredicate *p = [NSPredicate predicateWithFormat:@"emailAddress IN (%@)", emailsWithDupes];
 [fr setPredicate:p];
 
 NSSortDescriptor *emailSort = [NSSortDescriptor sortDescriptorWithKey:@"emailAddress" ascending:YES];
 [fr setSortDescriptors:[NSArray arrayWithObject:emailSort]];
 
 NSUInteger batchSize = 500; //can be set 100-10000 objects depending on individual object size and available device memory
 [fr setFetchBatchSize:batchSize];
 NSArray *dupes = [moc executeFetchRequest:fr error:&error];
 
 Person *prevPerson = nil;
 
 NSUInteger i = 1;
 for (Person *person in dupes) {
 if (prevPerson) {
 if ([person.emailAddress isEqualToString:prevPerson.emailAddress]) {
 if ([person.recordUUID compare:prevPerson.recordUUID] == NSOrderedAscending) {
 [moc deleteObject:person];
 } else {
 [moc deleteObject:prevPerson];
 prevPerson = person;
 }
 } else {
 prevPerson = person;
 }
 } else {
 prevPerson = person;
 }
 
 if (0 == (i % batchSize)) {
 //save the changes after each batch, this helps control memory pressure by turning previously examined objects back in to faults
 if ([moc save:&error]) {
 NSLog(@"Saved successfully after uniquing");
 } else {
 NSLog(@"Error saving unique results: %@", error);
 }
 }
 
 i++;
 }
 
 if ([moc save:&error]) {
 NSLog(@"Saved successfully after uniquing");
 } else {
 NSLog(@"Error saving unique results: %@", error);
 }
 }
 }
 


*/

@end



