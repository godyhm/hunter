//
//  HunterViewController.h
//  hunter
//
//  Created by AAA on 11-6-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BallEngineDeleGate.h"
#import "NewGameDeleGate.h"
@class HunterView;
@class BallEngine;

@interface HunterViewController : UIViewController 
<BallEngineDeleGate,NewGameDeleGate,UIAlertViewDelegate>
{
	long int mNumBalls;
	long int mNumLives;
	long int mNumLivesStart;
	HunterView* mBallsView;
	NSMutableArray* mModeStack;
//	  private WelcomeDialog mWelcomeDialog;
//    private GameOverDialog mGameOverDialog;
//	
//    private TextView mLivesLeft;
//    private TextView mPercentContained;
//    private Vibrator mVibrator;
//    private TextView mLevelInfo;
	
//	NSThread* threadPostDraw;
//	NSCondition* drawCondition;
//	NSTimeInterval interval;
//	BOOL postDraw;
}

@property (nonatomic,retain)NSMutableArray* mModeStack;

-(void)saveMode;

-(void)levelUp:(BallEngine*)ballEngine;

-(void)updatePercentDisplay:(float)amountFiled;

-(void)updateLevelDisplay:(long int )numBalls;

-(void)updateLivesDisplay:(long int )numLives;

//-(void)postInvalidate;
-(void)postReDraw;
@end
