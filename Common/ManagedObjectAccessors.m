//
//  ManagedObjectAccessors.m
//  Lord o'Lore
//
//  Created by Mark James Thompson on 8/31/10.
//  Copyright (c) 2010 Arete Group. All rights reserved.
//

#import "ManagedObjectAccessors.h"

@implementation NSManagedObject (ManagedObjectAccessors)

//General

//Test
@dynamic title;
@dynamic numberOfChoices;
@dynamic needReview;
@dynamic newSynapses;

//TermEntry
@dynamic canonicalName;
@dynamic figure;
@dynamic sound;
@dynamic symbolic;
@dynamic uuid;
@dynamic video;
//--Relationships--//
@dynamic terms;
@dynamic xRef;

//SYNAPSE
@dynamic contentProperty;
@dynamic created;
@dynamic difficulty;
@dynamic flagged;
@dynamic lastAnswered;
@dynamic lastReviewDate;
@dynamic nextReviewDate;
@dynamic promptProperty;
@dynamic right;
@dynamic wrong;
@dynamic question;
@dynamic label;
//--Relationships--//
@dynamic contentConcept;
@dynamic contentTerm;
@dynamic promptConcept;
@dynamic promptTerm;


//Term
@dynamic animacy;
@dynamic audio;
@dynamic component;
@dynamic etymology;
@dynamic grammaticalGender;
@dynamic grammaticalNumber;
@dynamic hyphenation;
@dynamic lemma;
@dynamic partOfSpeech;
@dynamic priority;
@dynamic pronunciation;
@dynamic syllabification;
//---Relatioships----//
@dynamic adminNote;
@dynamic language;
@dynamic node;
@dynamic termEntry;
@dynamic termNote;



//TermNote
@dynamic homograph;
@dynamic usageNote;
@dynamic frequency;

//Language
@dynamic ISO6393;


//NODE
//canonicalName same as above
@dynamic name;
@dynamic container;
@dynamic expandable;
@dynamic selectable;
@dynamic synapses;
@dynamic tests;


-(NSString *)promptTermString{
	//NSLog(@"Getting prompt term string");
	NSString *promptProperty    = [self valueForKey:@"promptProperty"];
	NSManagedObject *promptTerm = [self valueForKey:@"promptTerm"];
	NSString *stringValue       = [promptTerm valueForKeyPath:promptProperty];
	return stringValue;
}

-(NSString *)contentTermString{
	NSString *contentProperty    = [self valueForKey:@"contentProperty"];
	NSManagedObject *contentTerm = [self valueForKey:@"contentTerm"];
	NSString *stringValue        = [contentTerm valueForKeyPath:contentProperty];
	return stringValue;
}


-(void)setImage:(NSImage *)image{
	NSLog(@"Image doesn't need to be set as it is dynamically retrieved on call");
}

-(NSImage *)image{

	//NSLog(@"Name for image is is: %@", self.name);
	NSImage *image = [NSImage alloc];
	/**/
	//FIXME: If ðese nodes get renames, ðis will break.
	if ([[[self entity] name] isEqualToString:@"Node"]) {
		if ([self.name isEqualToString:@"Tests"]) {
			[image initWithContentsOfURL:[[NSBundle mainBundle] 
										  URLForResource:@"ovTest"
										  withExtension:@"icns"]];
		} else if ([self.name isEqualToString:@"Classified Lore"]){
			[image initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"classifiedLore" withExtension:@"icns"]];
		} else if ([self.name isEqualToString:@"Synapse"]) {
			[image initWithContentsOfURL:[[NSBundle mainBundle] 
										  URLForResource:@"Image10"
										  withExtension:@"tiff"]];
		} else if ([self.name isEqualToString:@"Languages"]){
			[image initWithContentsOfURL:[[NSBundle mainBundle] 
										  URLForResource:@"Localization"
										  withExtension:@"icns"]];
		} else if ([[[self entity] name] isEqualToString:@"Language"]) {
			NSString *imageName = self.ISO6393;
			//Images need to have a properly named resource.
			[image initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:imageName withExtension:@"png"]];
		} else {
			[image initWithContentsOfURL:[[NSBundle mainBundle] 
										  URLForResource:@"Image10" 
										  withExtension:@"tiff"]];
		}
	}
	NSSize size;
	size.width = 16;
	size.height = 16;
	[image setSize:size];
	return image;
}



- (NSComparisonResult)compare:(id)anOther {
    // We want the data to be sorted by name, so we compare [self name] to [other name]
    if ([anOther isKindOfClass:[NSManagedObject class]]) {
        NSManagedObject *other = (NSManagedObject *)anOther;
        return [self.name compare:other.name];
    } else {
        return NSOrderedAscending;
    }
}


@end
