//
//  iCloudManager.h
//  ProVocNov
//
//  Created by Mark James Thompson on 3/30/13.
//  Copyright (c) 2013 Mark James Thompson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface iCloudManager : NSObject


@property (strong, nonatomic) NSFileManager *fileManager;
@property (strong, nonatomic) id currentToken;
@property BOOL isSignedIntoICloud;

-(void) requestPermissionToUseICloud;
-(void) addPersistentStore:(NSURL*)dataFileURL
          storeCoordinator:(NSPersistentStoreCoordinator*)coordinator;
-(NSURL *)createICloudDataDirectory;
- (void)deDupe:(NSNotification *)importNotification;
@end
