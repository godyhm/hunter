//
//  DialogView.h
//  hunter
//
//  Created by AAA on 11-7-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import <Cocoa/Cocoa.h>


@interface DialogView : NSObject {

	//id<NewGameDeleGate> mNewGameDeleGate;
	//UIAlertView* dlgView;
}

-(id)initWithDialogParams:(NSString*)title:(NSString*)msg:
(id)delegate:(NSString*)btnOneText:(NSString*)btnTwoText:(int)tag;
@end
