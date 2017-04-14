//
//  PVNDetailViewController.h
//  ProVocNov
//
//  Created by Mark James Thompson on 3/29/13.
//  Copyright (c) 2013 Mark James Thompson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PVNDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITextField *sourceDescriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *targetDescriptionTextField;
@property (weak,nonatomic) NSManagedObjectContext *managedObjectContext;
@end
