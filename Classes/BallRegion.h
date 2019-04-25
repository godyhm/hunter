//
//  BallRegion.h
//  hunter
//
//  Created by AAA on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import <Cocoa/Cocoa.h>
#import "BallEventDeleGate.h"
#import "Direction.h"
#import "Shape2DDeleGate.h"

@class AnimatingLine;
#define SHRINK_TO_FIT_AREA_THRESH 10000.0f
#define SHRINK_TO_FIT_AREA_THRESH_ONE_BALL 20000.0f
#define SHRINK_TO_FIT_AREA 1000.0f
#define PIXELS_PER_SECOND 25.0f
#define MIN_EDGE 30.0f

@interface BallRegion : NSObject<Shape2DDeleGate> {
    float mLeft;
    float mRight;
    float mTop;
    float mBottom;
	
    NSMutableArray* mBalls;
	
    AnimatingLine* mAnimatingLine;
	
    BOOL mShrinkingToFit;
	BOOL mDoneShrinking;
    long int mLastUpdate;
	id<BallEventDeleGate> mBallEventDeleGateInBallRegion;
}

//@property float mLeft;
//@property float mRight;
//@property float mTop;
//@property float mBottom;
@property BOOL mDoneShrinking;
@property (nonatomic,assign)id<BallEventDeleGate> mBallEventDeleGateInBallRegion;
@property (retain)NSMutableArray* mBalls;
@property (nonatomic,retain)AnimatingLine* mAnimatingLine;



-(id)initWithBallRegionParams:(long int)now:(float)left:(float)right:(float)top:
(float)bottom:(NSMutableArray*)balls;
-(void)checkShrinkToFit;
//-(NSMutableArray*)getBalls;
-(BOOL)consumeDoneShrinking;
-(void)setNow:(long int)now;
-(BallRegion*)updateRegion:(long int)now;
-(void)handleShrinkToFit:(long int)now;
-(BOOL)canStartLineAt:(float)x:(float)y;
-(void)startHorizontalLine:(long int)now:(float)x:(float)y;
-(void)startVerticalLine:(long int)now:(float)x:(float)y;
-(BallRegion*)splitRegion:(long int)now:(Direction)direction:(float)perpAxisOffset;
@end
