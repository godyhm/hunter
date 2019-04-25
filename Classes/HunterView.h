//
//  HunterView.h
//  hunter
//
//  Created by AAA on 11-6-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionMode.h"
#import "BallEventDeleGate.h"
#import "Constant.h"
#import "BallEngineDeleGate.h"
@class BallEngine;
@class BallRegion;
@class DirectionPoint;
@class HunterViewController;

@interface HunterView : UIView<BallEventDeleGate> {
    BOOL mProfileDrawing;
	BOOL mDrawingProfilingStarted;
	BallEngine* mBallEngine;
	ActionMode mMode;
	id<BallEngineDeleGate> mBallEngineDeleGateInView;
	DirectionPoint* mDirectionPoint;
	UIImage* mBallImg;	
	UIImage* mExplosion1;
	UIImage* mExplosion2;
	UIImage* mExplosion3;
	float mBallImgRadius;
	NSMutableArray* mExplosions;
	
	NSString *currentDisplayString;
	NSArray *displayStrings;
	NSUInteger displayStringsIndex;
}
//
@property (nonatomic,retain)NSMutableArray* mExplosions;
@property (nonatomic,retain)BallEngine* mBallEngine;
@property (nonatomic,assign)id<BallEngineDeleGate> mBallEngineDeleGateInView;
@property (nonatomic, retain) NSString *currentDisplayString;
@property (nonatomic, retain) NSArray *displayStrings;


-(void)drawBackGroundGradient;
-(ActionMode)getActionMode;
-(void)setActionMode:(ActionMode)mode;
-(void)checkMode;

-(void)drawPausedText;
-(void)drawRegion:(BallRegion*)region;
+(CGFloat)scaleToBlack:(CGFloat)component: (float)percentage;
-(void)drawAnimatingLine:(AnimatingLine*)al;

//-(BOOL)findController;
//-(void)postInvalidate;
@end
