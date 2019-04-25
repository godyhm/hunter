//
//  DirectionPoint.h
//  hunter
//
//  Created by AAA on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import <Cocoa/Cocoa.h>

typedef enum{
	PointVertical,
	PointHorizonal,
	PointUnknown
} AmbiguousDirection;

@interface DirectionPoint : NSObject {
    float mX;
    float mY;
	
    float endLineX;
    float endLineY;
}
@property float mX;
@property float mY;

-(id)initWithDirectionPointParams:(float)x:(float)y;
-(void)updateEndPoint:(float)x:(float)y;
-(AmbiguousDirection)getPointDirection;
@end
