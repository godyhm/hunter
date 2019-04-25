//
//  AnimatingLine.h
//  hunter
//
//  Created by AAA on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import <Cocoa/Cocoa.h>
//#import "Shape2D.h"
#import "Direction.h"
#import "Shape2DDeleGate.h"
@interface AnimatingLine : NSObject<Shape2DDeleGate> {
    Direction mDirection;
    float mPerpAxisOffset;
	
    float mStart;
    float mEnd;
	
    float mMin;
    float mMax;
	
    long int mLastUpdate;
    float mPixelsPerSecond;
}

@property float mStart;
@property float mEnd;
@property float mMin;
@property float mMax;
@property long int mLastUpdate;
@property float mPerpAxisOffset;
@property Direction mDirection;

-(id)initWithLineParams:(Direction)direction:(long int)now:
(float)axisStart:(float)start:(float)min:(float)max;
-(Direction)getLineDirection;
-(float)getLeft;
-(float)getRight;
-(float)getTop;
-(float)getBottom;
-(float)getPercentageDone;
-(BOOL)update:(long int)time;
@end
