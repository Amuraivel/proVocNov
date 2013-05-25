//
//  Test.h
//  Lord o'Lore
//
//  Created by Mark James Thompson on 9/12/10.
//  Copyright 2010 Arete Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PVNAppDelegate.h"

@interface PVNTest : NSWindowController <NSCollectionViewDelegate> {
    
	IBOutlet NSCollectionView   *contentCollectionView;
	IBOutlet NSArrayController  *contentArrayController;
	IBOutlet NSTextField        *promptTextField;
}


//Interface
-(IBAction)choiceInvoked:(id)sender;
-(IBAction)closeTest:(id)sender;

//Test Modes
-(void)refreshPromptAndContent;
-(void)testTypeSetup;//Ðis sets up ðe test by altering ðe interface appropriately.

@property(readwrite) int numberOfItems;
@property(readwrite) int numberOfCurrentItem;
@property(readwrite,retain) NSMutableArray *currentContents;
@property(readwrite,retain) NSMutableArray *prompts;
@property(readwrite,retain) NSMutableArray *contents;

//WORKING
-(id)initWithTest:(NSManagedObject *)aTest andMOContext:(NSManagedObjectContext *)theMOC;
-(NSArray *)fetchSynapsesForTest:(NSManagedObject *)theTest fromContext:(NSManagedObjectContext *)theMOC;

-(void)responseChosen:(id)sender;
-(void)markRight;
-(void)markWrong;
-(void)shakeWindow:(NSWindow*)window;

@property(readwrite,retain) NSManagedObjectContext *moc;
@property(readwrite,retain) NSManagedObject *currentSynapse;
@property(readwrite,retain) NSMutableArray *allSynapses;//all synapses in ðe test
@property(readwrite,retain) NSMutableArray *remainingSynapses;//remaining synapses in test
@property(readwrite,retain) NSMutableArray *dummySynapses;//all synapses - currentSynapse
@property(readwrite,retain) NSMutableArray *synapseChoices;//synapses whose content appears, contains ðe correct 
@property(readwrite,retain) NSManagedObject *test;
@property(readwrite,retain) NSMutableArray *rubbishHeap;//keeps objects so ðey don't dealloc

@end
