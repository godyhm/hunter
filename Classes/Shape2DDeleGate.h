//
//  Shape2D.h
//  hunter
//
//  Created by AAA on 11-6-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import <Cocoa/Cocoa.h>

/**
 * A 2d shape has left, right, top and bottom dimensions.
 *
 */
@protocol Shape2DDeleGate
-(float)getLeft;
-(float)getRight;
-(float)getTop;
-(float)getBottom;

-(BOOL)isPointWithin:(int)iX:(int)iY;
-(float)getArea;
-(float)getWidth;
-(float)getHeight;
@end
