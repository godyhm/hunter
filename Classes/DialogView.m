//
//  DialogView.m
//  hunter
//
//  Created by AAA on 11-7-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DialogView.h"


@implementation DialogView
-(id)initWithDialogParams:
(NSString*)title:(NSString*)msg:(id)delegate:(NSString*)btnOneText:(NSString*)btnTwoText:(int)tag
{
	NSLog(@"just test");
	self = [super init];
	if (self) {
		UIAlertView* dlgView = [[UIAlertView alloc] initWithTitle:title message:msg 
								delegate:delegate cancelButtonTitle:
								btnOneText otherButtonTitles:nil];
		if(btnTwoText!=nil)
		{
			[dlgView addButtonWithTitle:btnTwoText];
		}
		dlgView.tag = tag;
		[dlgView show];
		[dlgView release];
	}
	return self;
}
@end
