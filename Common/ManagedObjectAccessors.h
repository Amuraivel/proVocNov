//
//  ManagedObjectAccessors.h
//  Lord o'Lore
//
//  Created by Mark James Thompson on 8/31/10.
//  Copyright (c) 2010 Arete Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSManagedObject (ManagedObjectAccessors)

//COMMON
@property(readwrite,retain) NSManagedObject *node;
@property(readwrite,retain) NSSet *tests;
@property(readwrite,retain) NSManagedObject *adminNote;

//TEST
@property(readwrite,retain) NSString *title;
@property(readwrite,retain) NSNumber *numberOfChoices;
@property(readwrite,retain) NSNumber *needReview;
@property(readwrite,retain) NSNumber *newSynapses;


//TermEntry
@property(readwrite,retain) NSString *canonicalName;
@property(readwrite,retain) NSData	 *figure;
@property(readwrite,retain) NSData	 *sound;
@property(readwrite,retain) NSString *symbolic;
@property(readwrite,retain) NSString *uuid;
@property(readwrite,retain) NSData	 *video;
//----------------Relationships------------------//
@property(readwrite,retain) NSSet			*terms;
@property(readwrite,retain) NSManagedObject *xRef;

//Term
@property(readwrite,retain) NSNumber *animacy;
@property(readwrite,retain) NSData *audio;
@property(readwrite,retain) NSString *component;
@property(readwrite,retain) NSString *etymology;
@property(readwrite,retain) NSString *grammaticalGender;
@property(readwrite,retain) NSString *grammaticalNumber;
@property(readwrite,retain) NSString *hyphenation;
@property(readwrite,retain) NSString *lemma;
@property(readwrite,retain) NSString *partOfSpeech;
@property(readwrite,retain) NSString *pronunciation;
@property(readwrite,retain) NSString *syllabification;
//-------------Relationships--------------//
@property(readwrite,retain) NSManagedObject *language;//a.k.a. Language
@property(readwrite,retain) NSManagedObject *termEntry;
@property(readwrite,retain) NSManagedObject *termNote;

//TermNote
@property(readwrite,retain) NSString *homograph;
@property(readwrite,retain) NSString *usageNote;
@property(readwrite,retain) NSNumber *frequency;

//Language,retain
@property(readwrite,retain) NSString *ISO6393;


//SYNAPSE
@property(readwrite,retain) NSString	*contentProperty;
@property(readwrite,retain) NSDate		*created;
@property(readwrite,retain) NSNumber	*difficulty;
@property(readwrite,retain) NSNumber	*flagged;
@property(readwrite,retain) NSString	*label;
@property(readwrite,retain) NSDate		*lastAnswered;
@property(readwrite,retain) NSDate		*lastReviewDate;
@property(readwrite,retain) NSDate		*nextReviewDate;
@property(readwrite,retain) NSNumber	*priority;
@property(readwrite,retain) NSString	*promptProperty;
@property(readwrite,retain) NSString	*question;
@property(readwrite,retain) NSNumber	*right;
@property(readwrite,retain) NSNumber	*wrong;
@property(readonly,retain)  NSString *promptTermString;
@property(readonly,retain)  NSString *contentTermString;
//--------------------Relationships-----------------------//
@property(readwrite,retain) NSManagedObject *contentConcept;
@property(readwrite,retain) NSManagedObject *contentTerm;
@property(readwrite,retain) NSManagedObject *promptConcept;
@property(readwrite,retain) NSManagedObject *promptTerm;


//Node
//canonicalName same attributes as above
@property(readwrite,retain) NSString *name;
@property(readwrite,retain,getter=isContainer) NSNumber *container;
@property(readwrite,retain,getter=isExpandable) NSNumber *expandable;
@property(readwrite,retain) NSNumber *selectable;
@property(readwrite,retain) NSImage *image;
//@property(nonatomic, retain) NSSet *nodes;
@property(readwrite,retain) NSSet *synapses;
-(NSComparisonResult)compare:(id)anOther;

@end
