//
//  PVNMasterViewController.h
//  ProVocNov
//
//  Created by Mark James Thompson on 3/29/13.
//  Copyright (c) 2013 Mark James Thompson. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CoreDataTableViewController.h"
@class PVNDetailViewController;

#import <CoreData/CoreData.h>

@interface PVNMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) PVNDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
