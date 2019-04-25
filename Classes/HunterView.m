//
//  HunterView.m
//  hunter
//
//  Created by AAA on 11-6-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DirectionPoint.h"
#import "Direction.h"
#import "Ball.h"
#import "BallEngine.h"
#import "Explosion.h"
#import "AnimatingLine.h"
#import "BallRegion.h"
#import "HunterViewController.h"
#import "HunterView.h"

/**
 * Handles the visual display and touch input for the game.
 */
@implementation HunterView

@synthesize mBallEngine;
@synthesize mBallEngineDeleGateInView;
@synthesize currentDisplayString;
@synthesize displayStrings;
@synthesize mExplosions;
/*
 If the view is stored in the nib file, when it's unarchived it's sent -initWithCoder:.
 This is the case in the example as provided.  See also initWithFrame:.
 */
//public DivideAndConquerView(Context context, AttributeSet attrs) {
//	super(context, attrs);
//	
//	mPaint = new Paint();
//	mPaint.setAntiAlias(true);
//	mPaint.setStrokeWidth(2);
//	mPaint.setColor(Color.BLACK);
//	
//	// so we can see the back key
//	setFocusableInTouchMode(true);
//	
//	drawBackgroundGradient();
//	
//	mBallBitmap = BitmapFactory.decodeResource(
//											   context.getResources(),
//											   R.drawable.ball);
//	
//	mBallBitmapRadius = ((float) mBallBitmap.getWidth()) / 2f;
//	
//	mExplosion1 = BitmapFactory.decodeResource(
//											   context.getResources(),
//											   R.drawable.explosion1);
//	mExplosion2 = BitmapFactory.decodeResource(
//											   context.getResources(),
//											   R.drawable.explosion2);
//	mExplosion3 = BitmapFactory.decodeResource(
//											   context.getResources(),
//											   R.drawable.explosion3);
//}
- (id)initWithCoder:(NSCoder *)coder {
	NSLog(@"initWithCoder");
	self = [super initWithCoder:coder];
	if (self) {
		mProfileDrawing = FALSE;
		mDrawingProfilingStarted = FALSE;
		mMode = Paused;
		mDirectionPoint = nil;
		mBallImg = [UIImage imageNamed:(NSString *)@"ball.png"];
		mExplosion1 = [UIImage imageNamed:(NSString *)@"explosion1.png"];
		mExplosion2 = [UIImage imageNamed:(NSString *)@"explosion2.png"];
		mExplosion3 = [UIImage imageNamed:(NSString *)@"explosion3.png"];
		mBallImgRadius = [mBallImg size].width/2.0f;
		
		// Load the display strings
		NSString *path = [[NSBundle mainBundle] pathForResource:@"DisplayStrings" ofType:@"txt"];
		NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUTF16BigEndianStringEncoding error:NULL];
		displayStrings = [string componentsSeparatedByString:@"\n"];
		displayStringsIndex = 0;
		mExplosions = [[NSMutableArray alloc] init];
		[self drawBackGroundGradient];
	}
	return self;
}

/*
 If you were to create the view programmatically, you would use initWithFrame:.
 */
- (id)initWithFrame:(CGRect)frame {
    
	NSLog(@"initWithFrame");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.	
		mProfileDrawing = FALSE;
		mDrawingProfilingStarted = FALSE;
		mMode = Paused;
		mDirectionPoint = nil;
		mBallImg = [UIImage imageNamed:(NSString *)@"ball.png"];
		mExplosion1 = [UIImage imageNamed:(NSString *)@"explosion1.png"];
		mExplosion2 = [UIImage imageNamed:(NSString *)@"explosion2.png"];
		mExplosion3 = [UIImage imageNamed:(NSString *)@"explosion3.png"];
		mBallImgRadius = [mBallImg size].width/2.0f;
		
		// Load the display strings
		NSString *path = [[NSBundle mainBundle] pathForResource:@"DisplayStrings" ofType:@"txt"];
		NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUTF16BigEndianStringEncoding error:NULL];
		displayStrings = [string componentsSeparatedByString:@"\n"];
		displayStringsIndex = 0;
		mExplosions = [[NSMutableArray alloc] init];
		[self drawBackGroundGradient];
    }
    return self;
}

/**
 * Set the callback that will be notified of events related to the ball
 * engine.
 * @param callback The callback.
 */
//public void setCallback(BallEngineCallBack callback) {
//	mCallback = callback;
//}
//
//@Override
//protected void onSizeChanged(int i, int i1, int i2, int i3) {
//	super.onSizeChanged(i, i1, i2,
//						i3);
//	
//	// this should only happen once when the activity is first launched.
//	// we could be smarter about saving / restoring across activity
//	// lifecycles, but for now, this is good enough to handle in game play,
//	// and most cases of navigating away with the home key and coming back.
//	mEngine = new BallEngine(
//							 BORDER_WIDTH, getWidth() - BORDER_WIDTH,
//							 BORDER_WIDTH, getHeight() - BORDER_WIDTH,
//							 BALL_SPEED,
//							 BALL_RADIUS);
//	mEngine.setCallBack(this);
//	mCallback.onEngineReady(mEngine);
//}


/**
 * @return the current mode of operation.
 */
//public Mode getMode() {
//	return mMode;
//}
-(ActionMode)getActionMode
{
	return mMode;
}

/**
 * Set the mode of operation.
 * @param mode The mode.
 */
//public void setMode(Mode mode) {
//	mMode = mode;
//	
//	if (mMode == Mode.Bouncing && mEngine != null) {
//		// when starting up again, the engine needs to know what 'now' is.
//		final long now = SystemClock.elapsedRealtime();
//		mEngine.setNow(now);
//		
//		mExplosions.clear();
//		invalidate();
//	}
//}
-(void)setActionMode:(ActionMode)mode
{
	mMode = mode;
	
	if (mMode == Bouncing && mBallEngine != nil) {
		// when starting up again, the engine needs to know what 'now' is.	
		CFTimeInterval curTime = CFAbsoluteTimeGetCurrent();
		[mBallEngine setNow:(long int)curTime];
		[mExplosions removeAllObjects];
		//[self setNeedsDisplay];
	}
}

//@Override
//public boolean onKeyDown(int keyCode, KeyEvent event) {
//	// the first time the user hits back while the balls are moving,
//	// we'll pause the game.  but if they hit back again, we'll do the usual
//	// (exit the activity)
//	if (keyCode == KeyEvent.KEYCODE_BACK && mMode == Mode.Bouncing) {
//		setMode(Mode.PausedByUser);
//		return true;
//	}
//	return super.onKeyDown(keyCode, event);
//}


//@Override
//public boolean onTouchEvent(MotionEvent motionEvent) {
//	
//	if (mMode == Mode.PausedByUser) {
//		// touching unpauses when the game was paused by the user.
//		setMode(Mode.Bouncing);
//		return true;
//	} else if (mMode == Mode.Paused) {
//		return false;
//	}
//	
//	final float x = motionEvent.getX();
//	final float y = motionEvent.getY();
//	switch(motionEvent.getAction()) {
//		case MotionEvent.ACTION_DOWN:
//			if (mEngine.canStartLineAt(x, y)) {
//				mDirectionPoint =
//				new DirectionPoint(x, y);
//			}
//			return true;
//		case MotionEvent.ACTION_MOVE:
//			if (mDirectionPoint != null) {
//				mDirectionPoint.updateEndPoint(x, y);
//			} else if (mEngine.canStartLineAt(x, y)) {
//				mDirectionPoint =
//				new DirectionPoint(x, y);
//			}
//			return true;
//		case MotionEvent.ACTION_UP:
//			if (mDirectionPoint != null) {
//				switch (mDirectionPoint.getDirection()) {
//					case Unknown:
//						// do nothing
//						break;
//					case Horizonal:
//						mEngine.startHorizontalLine(SystemClock.elapsedRealtime(),
//													mDirectionPoint.getX(), mDirectionPoint.getY());
//						if (PROFILE_DRAWING) {
//							if (!mDrawingProfilingStarted) {
//								Debug.startMethodTracing("BallsDrawing");
//								mDrawingProfilingStarted = true;
//							}
//						}
//						break;
//					case Vertical:
//						mEngine.startVerticalLine(SystemClock.elapsedRealtime(),
//												  mDirectionPoint.getX(), mDirectionPoint.getY());
//						if (PROFILE_DRAWING) {
//							if (!mDrawingProfilingStarted) {
//								Debug.startMethodTracing("BallsDrawing");
//								mDrawingProfilingStarted = true;
//							}
//						}
//						break;
//				}
//			}
//			mDirectionPoint = null;
//			return true;
//		case MotionEvent.ACTION_CANCEL:
//			mDirectionPoint = null;
//			return true;
//	}
//	return false;
//}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self checkMode];
	
	UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self];
	float currentX = currentLocation.x;
	float currentY = currentLocation.y;  
	
    if ([mBallEngine canStartLineAt:currentX:currentY]) {
		mDirectionPoint = [[DirectionPoint alloc] initWithDirectionPointParams:currentX :currentY];
	}
}

-(void)checkMode
{
	if (mMode == PausedByUser) 
	{
		// touching unpauses when the game was paused by the user.
	    [self setActionMode:Bouncing];
	} 
	else if (mMode == Paused) 
	{
		[self setActionMode:Paused];
	}
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self checkMode];
	
	UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self];
	float currentX = currentLocation.x;
	float currentY = currentLocation.y;  
	
	if (mDirectionPoint != nil) {
		[mDirectionPoint updateEndPoint:currentX:currentY];
	} else if ([mBallEngine canStartLineAt:currentX:currentY]) 
	{
		mDirectionPoint = [[DirectionPoint alloc] initWithDirectionPointParams:currentX :currentY];
	}
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self checkMode];
	
	if (mDirectionPoint != nil) {
		switch ([mDirectionPoint getPointDirection]) {
			case PointUnknown:
				// do nothing
				break;
			case PointHorizonal:
			    {
				CFTimeInterval curTime = CFAbsoluteTimeGetCurrent();
				[mBallEngine startHorizontalLine:(long int)curTime:
				 mDirectionPoint.mX:mDirectionPoint.mY];
				//if (PROFILE_DRAWING) {
//					if (!mDrawingProfilingStarted) {
//						Debug.startMethodTracing("BallsDrawing");
//						mDrawingProfilingStarted = true;
//					}
//				}
			    }
				break;
			case PointVertical:
				{
				CFTimeInterval curTime = CFAbsoluteTimeGetCurrent();
				[mBallEngine startVerticalLine:(long int) curTime:
				 mDirectionPoint.mX:mDirectionPoint.mY];
				//if (PROFILE_DRAWING) {
//					if (!mDrawingProfilingStarted) {
//						Debug.startMethodTracing("BallsDrawing");
//						mDrawingProfilingStarted = true;
//					}
//				}
				}
				break;
		}
	}
	mDirectionPoint = nil;
	
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self checkMode];
	[mDirectionPoint release];
	mDirectionPoint = nil;
	
}

//public void onBallHitsBall(Ball ballA, Ball ballB) {
//	
//}
-(void)onBallHitsBall:(Ball*)ballA:(Ball*)ballB
{
	
}

-(void)onBallHitsLine:(long int)when:(Ball*)ball:(AnimatingLine*)animatingLine
{
	[mBallEngineDeleGateInView onBallHitsMovingLine:mBallEngine:ball.mX:ball.mY];
	Explosion* explosion = [[Explosion alloc] initExplosion:when:ball.mX:ball.mY:
													   mExplosion1:mExplosion2:mExplosion3];
	
	[mExplosions addObject:(id)explosion];	
	[explosion release];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//@Override
//protected void onDraw(Canvas canvas) {
//	boolean newRegion = false;
//	
//	if (mMode == Mode.Bouncing) {
//		
//		// handle the ball engine
//		final long now = SystemClock.elapsedRealtime();
//		newRegion = mEngine.update(now);
//		
//		if (newRegion) {
//			mCallback.onAreaChange(mEngine);
//			
//			// reset back to full alpha bg color
//			drawBackgroundGradient();
//		}
//		
//		if (PROFILE_DRAWING) {
//			if (newRegion && mDrawingProfilingStarted) {
//				mDrawingProfilingStarted = false;
//				Debug.stopMethodTracing();
//			}
//		}
//		
//		// the X-plosions
//		for (int i = 0; i < mExplosions.size(); i++) {
//			final Explosion explosion = mExplosions.get(i);
//			explosion.update(now);
//		}
//		
//		
//	}
//	
//	for (int i = 0; i < mEngine.getRegions().size(); i++) {
//		BallRegion region = mEngine.getRegions().get(i);
//		drawRegion(canvas, region);
//	}
//	
//	for (int i = 0; i < mExplosions.size(); i++) {
//		final Explosion explosion = mExplosions.get(i);
//		explosion.draw(canvas, mPaint);
//		// TODO prune explosions that are done
//	}
//	
//	
//	if (mMode == Mode.PausedByUser) {
//		drawPausedText(canvas);
//	} else if (mMode == Mode.Bouncing) {
//		// keep em' bouncing!
//		invalidate();
//	}
//}
- (void)drawRect:(CGRect)rect {
	NSLog(@"drawRect");
    // Drawing code.
	BOOL newRegion = NO;
	
	if (mMode == Bouncing) {
		
		// handle the ball engine
		CFTimeInterval curTime = CFAbsoluteTimeGetCurrent();
		newRegion = [mBallEngine update:(long int)curTime];
		
		if (newRegion) {
			[mBallEngineDeleGateInView onAreaChange:mBallEngine];
			
			// reset back to full alpha bg color
			
			[self drawBackGroundGradient];
		}
		
	//	if (PROFILE_DRAWING) {
//			if (newRegion && mDrawingProfilingStarted) {
//				mDrawingProfilingStarted = false;
//				Debug.stopMethodTracing();
//			}
//		}
		
		// the X-plosions
		for (int i = 0; i < [mExplosions count]; i++) {
			Explosion* explosion = [mExplosions objectAtIndex:(NSUInteger)i];
			[explosion updateInExplosion:(long int)curTime];
		}
		
		
	}
	
	for (int i = 0; i < [mBallEngine.mRegions count] ; i++) {
		BallRegion* region = [mBallEngine.mRegions objectAtIndex:(NSUInteger)i];
		[region retain];
		[self drawRegion:region];
		[region release];
	}
	
	

	for (int j = 0; j < [mExplosions count]; j++) {
		Explosion* explosion = [mExplosions objectAtIndex:(NSUInteger)j];
		[explosion drawExplosionImage];
		// TODO prune explosions that are done
	}
	
//	if (mMode == PausedByUser) {
//		[self drawPausedText];
//	} else if (mMode == Bouncing) {
//		// keep em' bouncing!
//		[self setNeedsDisplay];
//		//[self setNeedsDisplayInRect:[self bounds]];
//		 //[self performSelectorOnMainThread:@selector(setNeedsDisplay) withObject:nil waitUntilDone:NO];
//	}
}

//- (void)drawRect:(CGRect)rect {
//	
//	// Draw the placard at 0, 0
//	[placardImage drawAtPoint:(CGPointMake(0.0f, 0.0f))];
//	
//	/*
//	 Draw the current display string.
//	 Typically you would use a UILabel, but this example serves to illustrate the UIKit extensions to NSString.
//	 The text is drawn center of the view twice - first slightly offset in black, then in white -- to give an embossed appearance.
//	 The size of the font and text are calculated in setupNextDisplayString.
//	 */
//	
//	// Find point at which to draw the string so it will be in the center of the view
//	CGFloat x = self.bounds.size.width/2 - textSize.width/2;
//	CGFloat y = self.bounds.size.height/2 - textSize.height/2;
//	CGPoint point;
//	
//	// Get the font of the appropriate size
//	UIFont *font = [UIFont systemFontOfSize:fontSize];
//	
//	[[UIColor blackColor] set];
//	point = CGPointMake(x, y + 0.5f);
//	[currentDisplayString drawAtPoint:point forWidth:(self.bounds.size.width-STRING_INDENT) withFont:font fontSize:fontSize lineBreakMode:UILineBreakModeMiddleTruncation baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
//	
//	[[UIColor whiteColor] set];
//	point = CGPointMake(x, y);
//	[currentDisplayString drawAtPoint:point forWidth:(self.bounds.size.width-STRING_INDENT) withFont:font fontSize:fontSize lineBreakMode:UILineBreakModeMiddleTruncation baselineAdjustment:UIBaselineAdjustmentAlignBaselines]; 
//}
/**
 * Pain the text instructing the user how to unpause the game.
 */

//private void drawPausedText(Canvas canvas) {
//	mPaint.setColor(Color.BLACK);
//	mPaint.setAntiAlias(true);
//	mPaint.setTextSize(
//					   TypedValue.applyDimension(
//												 TypedValue.COMPLEX_UNIT_SP,
//												 20,
//												 getResources().getDisplayMetrics()));
//	final String unpauseInstructions = getContext().getString(R.string.unpause_instructions);
//	canvas.drawText(unpauseInstructions, getWidth() / 5, getHeight() / 2, mPaint);
//	mPaint.setAntiAlias(false);
//}
-(void)drawPausedText
{
	UIFont *font = [UIFont systemFontOfSize:12.0f];
	[[UIColor blackColor] set];
	
	
	//mPaint.setColor(Color.BLACK);
	//mPaint.setAntiAlias(true);
//	mPaint.setTextSize(
//					   TypedValue.applyDimension(
//												 TypedValue.COMPLEX_UNIT_SP,
//												 20,
//												 getResources().getDisplayMetrics()));
	currentDisplayString = [displayStrings objectAtIndex:(NSUInteger)0];
	//final String unpauseInstructions = getContext().getString(R.string.unpause_instructions);
	//CGPoint point = CGPointMake(self.frame.origin.x/5.0f,self.frame.origin.y/2.0f);
	CGContextRef context = UIGraphicsGetCurrentContext(); 
	CGRect bounds =  CGContextGetClipBoundingBox(context);  
	CGPoint point = CGPointMake((bounds.size.width / 5.0f), (bounds.size.height / 2.0f)); 
	[currentDisplayString drawAtPoint:point forWidth:(self.bounds.size.width-STRING_INDENT) withFont:
	font fontSize:12.0f lineBreakMode:UILineBreakModeMiddleTruncation baselineAdjustment:
	UIBaselineAdjustmentAlignBaselines];
	//canvas.drawText(unpauseInstructions, getWidth() / 5, getHeight() / 2, mPaint);
//	mPaint.setAntiAlias(false);
}


/**
 * Draw a ball region.
 */
//private void drawRegion(Canvas canvas, BallRegion region) {
//	
//	// draw fill rect to offset against background
//	mPaint.setColor(Color.LTGRAY);
//	
//	mRectF.set(region.getLeft(), region.getTop(),
//			   region.getRight(), region.getBottom());
//	canvas.drawRect(mRectF, mPaint);
//	
//	
//	//draw an outline
//	mPaint.setStyle(Paint.Style.STROKE);
//	mPaint.setColor(Color.WHITE);
//	canvas.drawRect(mRectF, mPaint);
//	mPaint.setStyle(Paint.Style.FILL);  // restore style
//	
//	// draw each ball
//	for (Ball ball : region.getBalls()) {
//		//            canvas.drawCircle(ball.getX(), ball.getY(), BALL_RADIUS, mPaint);
//		canvas.drawBitmap(
//						  mBallBitmap,
//						  ball.getX() - mBallBitmapRadius,
//						  ball.getY() - mBallBitmapRadius,
//						  mPaint);
//	}
//	
//	// draw the animating line
//	final AnimatingLine al = region.getAnimatingLine();
//	if (al != null) {
//		drawAnimatingLine(canvas, al);
//	}
//}
-(void)drawRegion:(BallRegion*)region
{
	//如何画矩�?//	CGRect backRect = CGRectMake(10, 10, 50, 8);
//	CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
//	CGContextFillRect(context, backRect);
	
	
	// draw fill rect to offset against background
	CGContextRef context = UIGraphicsGetCurrentContext(); 
	
	//CGContextSetRGBStrokeColor(context, 1.0f, 1.0f, 1.0f, 1.0f);
	// And drawing with a blue fill color
	CGContextSetRGBFillColor(context, 0.667f, 0.667f, 0.667f, 1.0f);
	// Draw them with a 2.0 stroke width so they are a bit more visible.
	//CGContextSetLineWidth(context, 2.0);
	
	// Add Rect to the current path, then stroke it
//	CGContextAddRect(context, CGRectMake([region getLeft],
//										 [region getTop],
//										 [region getRight]-[region getLeft],
//										 [region getBottom]-[region getTop]));
	CGContextFillRect(context, CGRectMake([region getLeft],
										  [region getTop],
										  [region getWidth],
										  [region getHeight]));
										  
										 //[region getRight]-[region getLeft],
										 //[region getBottom]-[region getTop]));
	
	//CGContextStrokePath(context);
	
	//CGContextRef X = UIGraphicsGetCurrentContext();      
//	
//    CGRect bounds =  CGContextGetClipBoundingBox(X);  
//    CGPoint center = CGPointMake((bounds.size.width / 2), (bounds.size.height / 2));  
//	
//    CGContextSetRGBFillColor(X, 0.9,0.9,0.9, 0.8f);  
//    CGContextFillRect(X, bounds);  
//	
//    char* text = "GaGa... NO XIB! Hello iOS!";  
//    CGContextSelectFont(X, "Helvetica Bold", 32.0f, kCGEncodingMacRoman);  
//    CGContextSetTextDrawingMode(X, kCGTextFill);  
//    CGContextSetRGBFillColor(X, 0.1f, 0.3f, 0.8f,  0.85f);      
//    CGAffineTransform xform = CGAffineTransformMake(  
//                                                    1.0f,  0.0f,  
//                                                    0.0f, -1.0f,  
//                                                    0.0f,  0.0f   );  
//    CGContextSetTextMatrix(X, xform);      
//    CGContextShowTextAtPoint(X, 0, center.y, text, strlen(text));  
	
	
	//
//	mPaint.setColor(Color.LTGRAY);
//	
//	mRectF.set(region.getLeft(), region.getTop(),
//			   region.getRight(), region.getBottom());
//	canvas.drawRect(mRectF, mPaint);
	
	
	//draw an outline
	//mPaint.setStyle(Paint.Style.STROKE);
//	mPaint.setColor(Color.WHITE);
//	canvas.drawRect(mRectF, mPaint);
//	mPaint.setStyle(Paint.Style.FILL);  // restore style
	
	// draw each ball
	int cnt = [region.mBalls count];
	for (int i=0; i<cnt; i++) {
		Ball* ball = [region.mBalls objectAtIndex:(NSUInteger)i];
//		if ([ball isKindOfClass:[Ball class]]) {
//			CGFloat x = ball.mX - mBallImgRadius;
//			CGFloat y = ball.mY - mBallImgRadius;
//			CGPoint point = CGPointMake(x, y);
//			[mBallImg drawAtPoint:point];
//		}
		
		[mBallImg drawAtPoint:(CGPointMake(ball.mX-mBallImgRadius, ball.mY-mBallImgRadius))];
	}
	
	//for (Ball ball : region.getBalls()) {
//		//            canvas.drawCircle(ball.getX(), ball.getY(), BALL_RADIUS, mPaint);
//		canvas.drawBitmap(
//						  mBallBitmap,
//						  ball.getX() - mBallBitmapRadius,
//						  ball.getY() - mBallBitmapRadius,
//						  mPaint);
//	}
	
	// draw the animating line
	AnimatingLine* al = region.mAnimatingLine;
	if (al != nil) {
		[self drawAnimatingLine:al];
	}
}

//private static int scaleToBlack(int component, float percentage) {
//	//        return (int) ((1f - percentage*0.4f) * component);
//	
//	return (int) (percentage * 0.6f * (0xFF - component) + component);
//}
+(CGFloat)scaleToBlack:(CGFloat)component: (float)percentage
{
	return (CGFloat) (percentage * 0.6f * (0xff - component) + component);
}

/**
 * Draw an animating line.
 */
//private void drawAnimatingLine(Canvas canvas, AnimatingLine al) {
//	
//	final float perc = al.getPercentageDone();
//	final int color = Color.RED;
//	mPaint.setColor(Color.argb(
//							   0xFF,
//							   scaleToBlack(Color.red(color), perc),
//							   scaleToBlack(Color.green(color), perc),
//							   scaleToBlack(Color.blue(color), perc)
//							   ));
//	switch (al.getDirection()) {
//		case Horizontal:
//			canvas.drawLine(
//							al.getStart(), al.getPerpAxisOffset(),
//							al.getEnd(), al.getPerpAxisOffset(),
//							mPaint);
//			break;
//		case Vertical:
//			canvas.drawLine(
//							al.getPerpAxisOffset(), al.getStart(),
//							al.getPerpAxisOffset(), al.getEnd(),
//							mPaint);
//			break;
//	}
//}
-(void)drawAnimatingLine:(AnimatingLine*)al 
{
	/* Stroke a sequence of line segments one after another in `context'. The
	 line segments are specified by `points', an array of `count' CGPoints.
	 This function is equivalent to
	 
     CGContextBeginPath(context);
     for (k = 0; k < count; k += 2) {
	 CGContextMoveToPoint(context, s[k].x, s[k].y);
	 CGContextAddLineToPoint(context, s[k+1].x, s[k+1].y);
     }
     CGContextStrokePath(context); */
	
	
//	UIColor *currentColor = [UIColor blackColor];
//	
//	CGContextRef context = UIGraphicsGetCurrentContext(); 
//	CGContextSetLineWidth(context, 2.0);
//	CGContextSetStrokeColorWithColor(context, currentColor.CGColor);
//	CGContextBeginPath(context); // <---- this 
//	CGContextMoveToPoint(context, self.bounds.origin.x, self.bounds.origin.y);
//	CGContextAddLineToPoint(context, self.bounds.origin.x + self.bounds.size.x, self.bounds.origin.y + self.bounds.size.y);
//	CGContextStrokePath(context);
	
//	float perc = [al getPercentageDone];
	//UIColor* color = [UIColor redColor];

	// draw fill rect to offset against background
	 
//	
//	CGFloat* cmp = CGColorGetComponents(color.CGColor);
	
//	UIColor *baseColor = self.backgroundColor;
//	CGColorRef cgColor = baseColor.CGColor;
//	int32_t model = CGColorSpaceGetModel(CGColorGetColorSpace(cgColor));
//	const CGFloat *colorComponents = CGColorGetComponents(cgColor);
//	CGFloat red = 0.0;
//	CGFloat green = 0.0;
//	CGFloat blue = 0.0;
//	CGFloat alpha = 0.0;
//	if (model == kCGColorSpaceModelRGB)
//	{
//		red = colorComponents[0];
//		green = colorComponents[1];
//		blue = colorComponents[2];
//		alpha = colorComponents[3];
//	}
//	CGContextSetRGBStrokeColor(context, 
//							   [HunterView scaleToBlack:red:perc],
//							   [HunterView scaleToBlack:green:perc],
//							   [HunterView scaleToBlack:blue:perc],
//							   alpha);
							   //cmp[CGColorGetNumberOfComponents(color)-1]);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	UIColor *currentColor = [UIColor redColor];
	CGContextSetStrokeColorWithColor(context, currentColor.CGColor);
	switch (al.mDirection) {
		case Horizontal:
			{
				CGContextBeginPath(context);
				CGContextMoveToPoint(context, al.mStart, al.mPerpAxisOffset);
				CGContextAddLineToPoint(context, al.mEnd,al.mPerpAxisOffset);
				CGContextStrokePath(context);
			}
			break;

		case Vertical:
			{
				CGContextBeginPath(context);
				CGContextMoveToPoint(context, al.mPerpAxisOffset, al.mStart);
				CGContextAddLineToPoint(context, al.mPerpAxisOffset, al.mEnd);
				CGContextStrokePath(context);
			}
			break;
		default:
			break;
	}
}

//final GradientDrawable mBackgroundGradient =
//new GradientDrawable(
//					 GradientDrawable.Orientation.TOP_BOTTOM,
//					 new int[]{Color.RED, Color.YELLOW});
//
//void drawBackgroundGradient() {
//	setBackgroundDrawable(mBackgroundGradient);
//}
-(void)drawBackGroundGradient
{
	//CGContextRef currentContext = UIGraphicsGetCurrentContext();
	
    CGGradientRef glossGradient;
    CGColorSpaceRef rgbColorspace;
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { 1.0, 1.0, 0.0, 1.0,  // Start color red
		1.0, 0.0, 0.0, 1.0 }; // End color yellow
	
    rgbColorspace = CGColorSpaceCreateDeviceRGB();
    glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
    //CGRect currentBounds = self.bounds;
//    CGPoint topCenter = CGPointMake(CGRectGetMidX(currentBounds), 0.0f);
//    CGPoint midCenter = CGPointMake(CGRectGetMidX(currentBounds), CGRectGetMidY(currentBounds));
//    CGContextDrawLinearGradient(currentContext, glossGradient, topCenter, midCenter, 0);
	

	
	// Allocate bitmap context
	CGContextRef bitmapContext = CGBitmapContextCreate(NULL, 320, 480, 8, 4 * 320, rgbColorspace, kCGImageAlphaNoneSkipFirst);
	// Draw Gradient Here
	CGContextDrawLinearGradient(bitmapContext,
								glossGradient, 
								CGPointMake(0.0f, 0.0f),
								CGPointMake(320.0f, 480.0f)
								,0);
	// Create a CGImage from context
	CGImageRef cgImage = CGBitmapContextCreateImage(bitmapContext);
	// Create a UIImage from CGImage
	UIImage *uiImage = [UIImage imageWithCGImage:cgImage];
	// Release the CGImage
	CGImageRelease(cgImage);
	// Release the bitmap context
	CGContextRelease(bitmapContext);
	CGGradientRelease(glossGradient);
    CGColorSpaceRelease(rgbColorspace); 
	// Create the patterned UIColor and set as background color
	[self setBackgroundColor:[UIColor colorWithPatternImage:uiImage]];
}

- (void)dealloc {
//	[mBallImg release];
//	[mExplosion1 release];
//	[mExplosion2 release];
//	[mExplosion3 release];
	if (mDirectionPoint!=nil) {
		[mDirectionPoint release];
		mDirectionPoint = nil;
	}
	[mExplosions release];
	[mBallEngine release];
	[currentDisplayString release];
	[displayStrings release];
	[super dealloc];
}

- (void)layoutSubviews
{
	CGRect rect = [self bounds];
	
	NSLog(@"bounds:%@",NSStringFromCGRect(rect));
	
	mBallEngine = [[BallEngine alloc] initWithBallEngineParams
							   :BORDER_WIDTH 
							   :rect.size.width-BORDER_WIDTH
							   :BORDER_WIDTH 
							   :rect.size.height-BORDER_WIDTH 
							   :BALL_SPEED 
							   :BALL_RADIUS];
	mBallEngine.mBallEventDeleGateInBallEngine = self;
	[mBallEngineDeleGateInView onEngineReady:mBallEngine];
}
@end
