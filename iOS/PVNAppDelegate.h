//
//  PVNAppDelegate.h
//  ProVocNov
//
//  Created by Mark James Thompson on 3/29/13.
//  Copyright (c) 2013 Mark James Thompson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCloudManager.h"
#import "PVNMasterViewController.h"

@interface PVNAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong,nonatomic) iCloudManager *iCloudManager;
@property (strong, nonatomic) PVNMasterViewController *masterViewController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(void)reloadFetchedResults;
@end
