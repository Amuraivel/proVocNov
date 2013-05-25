//
//  Test.m
//  Lord o'Lore
//
//  Created by Mark James Thompson on 9/12/10.
//  Copyright 2010 Arete Group. All rights reserved.
//

#import "PVNTest.h"
#import "CoreDataManipulator.h"
#import "ManagedObjectAccessors.h"
#import "PVNPredictionModel.h"

@implementation PVNTest

@synthesize numberOfItems;
@synthesize numberOfCurrentItem;
//Arrays
@synthesize contents, currentContents;
@synthesize moc;
@synthesize test;
@synthesize prompts;
@synthesize allSynapses;
@synthesize dummySynapses;
@synthesize synapseChoices;
@synthesize remainingSynapses;
@synthesize currentSynapse;
@synthesize rubbishHeap;

-(id)initWithTest:(NSManagedObject *)aTest andMOContext:(NSManagedObjectContext *)theMOC{
	self = [self init];//normal init
	self.test = aTest;
	self.moc = theMOC;
	self.numberOfCurrentItem = 0;
    self.allSynapses = [NSMutableArray arrayWithArray:[self fetchSynapsesForTest:self.test 
                                                                     fromContext:self.moc]];
	
   	[self testTypeSetup];//Maps CD Test object to interface settings, and initilizes þings
					  
	//Setting window stuff
	[NSBundle loadNibNamed:@"Test" owner:self];
	[[self window] setTitle:[test valueForKey:@"title"]];//Display test title
	return self;
}


-(IBAction)closeTest:(id)sender{
	//Ðis is where test cleanup code will go
	NSLog(@"Stopping test.");
	[NSApp stopModal];
}


-(void)refreshPromptAndContent{
    if (([self.remainingSynapses count] <= 1) || (self.remainingSynapses == nil) || ([self.remainingSynapses count] <= self.numberOfCurrentItem)){
        [self closeTest:self];
    } else {
        self.currentSynapse = [self.remainingSynapses objectAtIndex:self.numberOfCurrentItem];
        //Fill ðe selection of contents  
        self.synapseChoices = nil;//voiding ðe previous contents	
        self.synapseChoices = [NSMutableArray arrayWithCapacity:[self.test.numberOfChoices integerValue]];
        int trueNumber = rand() % [self.test.numberOfChoices intValue]; //Random index of true answer;
        NSMutableArray *dummies = [NSMutableArray arrayWithArray:self.allSynapses];//Getting a dummy subset pf possible choices
        NSLog(@"All synapses: %ld",[self.allSynapses count]);
        [dummies removeObject:self.currentSynapse];
        //Add false synapses + one true synapse.
        for (int i = 0; i < [self.test.numberOfChoices intValue]; i++){
            NSNumber *no = [NSNumber numberWithUnsignedInteger:[dummies count]];
            int r = rand() % [no intValue];//select randomly on current number
            if (i == trueNumber) {
                [self.synapseChoices addObject:self.currentSynapse];//ADD TRUE ANSWER
            } else {
                [self.synapseChoices addObject:[dummies objectAtIndex:r]];//ADD FAKE ANSWER
                [dummies removeObjectAtIndex:r];//Make sure two of same dummy answers don't appear
            }
        }
        [contentArrayController setContent:self.synapseChoices];	
        self.numberOfCurrentItem++;
    }
}


-(void)responseChosen:(id)sender{
    NSManagedObject *responseSynapse = [sender representedObject] ;
	if ([currentSynapse.promptTermString isEqualToString:responseSynapse.promptTermString]) {
		[self markRight];//NSLog(@"Good job pal!");
	} else {
		[self markWrong];//NSLog(@"You suck dick pal!");
		[self shakeWindow:[self window]];
	}
	[PVNPredictionModel setNextReviewDate:self.currentSynapse];
	[self refreshPromptAndContent];
}


-(void)markWrong{
	int w = [self.currentSynapse.wrong intValue] + 1;
	self.currentSynapse.wrong = [NSNumber numberWithInt:w];
}


-(void)shakeWindow:(NSWindow *)window{
    NSRect f = [window frame];
    int c = 0; //counter variable
    int off = -5; //shake amount (offset)
    //shake 5 times
    while (c < 5){
        [window setFrame: NSMakeRect(f.origin.x + off,
									 f.origin.y,
									 f.size.width,
									 f.size.height) display: NO];
        [NSThread sleepForTimeInterval: .04]; //slight pause
        off *= -1; //back and forth
        c++; //inc counter
    }
    [window setFrame:f display: NO]; //return window to original frame
}

	 
-(void)markRight{
	int r = [self.currentSynapse.right intValue] + 1;
	self.currentSynapse.right = [NSNumber numberWithInt:r];
}

	 
-(NSArray *)fetchSynapsesForTest:(NSManagedObject *)theTest fromContext:(NSManagedObjectContext *)theMOC{
	NSArray *synapses = [NSMutableArray arrayWithArray:[CoreDataManipulator fetchManagedObjectsForEntity:theMOC
                    entity:@"Synapse"
                attribute:nil
                    attributeValue:nil]];
	return synapses;
}

-(void)testTypeSetup{
    //Sets Up bindings for prompt field
	@try {
		[promptTextField bind:@"stringValue"
					 toObject:self.currentSynapse
				  withKeyPath:@"promptTerm.component"
					  options:nil];
	}
	@catch (NSException * e) {
		NSLog(@"Attempting bind in testType Setup on: %@",e);
	}	
    
    //Now initializing values for testing system based on predicate details from test object
    if (self.currentSynapse == nil) {
        self.remainingSynapses = self.allSynapses;
        if ([self.test.needReview boolValue] == TRUE){
            
            NSPredicate *datePredicate  = [NSPredicate predicateWithFormat:@"(nextReviewDate < %@) || (nextReviewDate == nil)",[NSDate date]];
            [self.remainingSynapses filterUsingPredicate:datePredicate];
        }
        NSLog(@"remaining: %@",self.remainingSynapses);
        //Strips out new synapses   
        if ([self.test.newSynapses boolValue] == TRUE){
            NSPredicate *newPredicate = [NSPredicate predicateWithFormat:@"(nextReviewDate == nil)"];
            [self.remainingSynapses filterUsingPredicate:newPredicate];
        } else {
            NSPredicate *newPredicate = [NSPredicate predicateWithFormat:@"(nextReviewDate != nil)"];
            [self.remainingSynapses filterUsingPredicate:newPredicate];
        }    
		
	}
    [self refreshPromptAndContent];//First 
}

	 
@end
