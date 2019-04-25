    //
//  HunterViewController.m
//  hunter
//
//  Created by AAA on 11-6-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "HunterView.h"
#import "BallEngine.h"
#import "ActionMode.h"
#import "DialogView.h"
#import "Constant.h"
#import "HunterViewController.h"


@implementation HunterViewController
@synthesize mModeStack;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/
/**
 * The engine has its dimensions and is ready to go.
 * @param ballEngine The ball engine.
 */
/** {@inheritDoc} */
//public void onEngineReady(BallEngine ballEngine) {
//	// display 10 balls bouncing around for visual effect
//	ballEngine.reset(SystemClock.elapsedRealtime(), 10);
//	mBallsView.setMode(DivideAndConquerView.Mode.Bouncing);
//	
//	// show the welcome dialog
//	showDialog(WELCOME_DIALOG);
//}
-(void)onEngineReady:(BallEngine*)ballEngine
{
	// display 10 balls bouncing around for visual effect
	CFTimeInterval curTime = CFAbsoluteTimeGetCurrent()+10000.0f;
	[ballEngine reset:(long int)curTime:BALL_NUMBER_INIT];
	[mBallsView setActionMode:Bouncing];
	
	// show the welcome dialog
	
	//showDialog(WELCOME_DIALOG);
	[[[DialogView alloc] initWithDialogParams
							  :APP_NAME
							  :INSTRUCTIONS
							  :self
							  :NEW_GAME
							  :nil
							  :1] autorelease];
	//postDraw = true;
	[self postReDraw];
}


//@Override
//protected Dialog onCreateDialog(int id) {
//	if (id == WELCOME_DIALOG) {
//		mWelcomeDialog = new WelcomeDialog(this, this);
//		mWelcomeDialog.setOnCancelListener(this);
//		return mWelcomeDialog;
//	} else if (id == GAME_OVER_DIALOG) {
//		mGameOverDialog = new GameOverDialog(this, this);
//		mGameOverDialog.setOnCancelListener(this);
//		return mGameOverDialog;
//	}
//	return null;
//}
//
//@Override
//protected void onPause() {
//	super.onPause();
//	mBallsView.setMode(DivideAndConquerView.Mode.PausedByUser);
//}
//
//@Override
//protected void onResume() {
//	super.onResume();
//	
//	mVibrateOn = PreferenceManager.getDefaultSharedPreferences(this)
//	.getBoolean(Preferences.KEY_VIBRATE, true);
//	
//	mNumLivesStart = Preferences.getCurrentDifficulty(this).getLivesToStart();
//}
//
//private static final int MENU_NEW_GAME = Menu.FIRST;
//private static final int MENU_SETTINGS = Menu.FIRST + 1;
//
//@Override
//public boolean onCreateOptionsMenu(Menu menu) {
//	super.onCreateOptionsMenu(menu);
//	
//	menu.add(0, MENU_NEW_GAME, MENU_NEW_GAME, "New Game");
//	menu.add(0, MENU_SETTINGS, MENU_SETTINGS, "Settings");
//	
//	return true;        
//}
//
///**
// * We pause the game while the menu is open; this remembers what it was
// * so we can restore when the menu closes
// */
//Stack<DivideAndConquerView.Mode> mRestoreMode = new Stack<DivideAndConquerView.Mode>();
//
//@Override
//public boolean onMenuOpened(int featureId, Menu menu) {
//	saveMode();
//	mBallsView.setMode(DivideAndConquerView.Mode.Paused);
//	return super.onMenuOpened(featureId, menu);
//}
//
//@Override
//public boolean onOptionsItemSelected(MenuItem item) {
//	super.onOptionsItemSelected(item);
//	
//	switch (item.getItemId()) {
//		case MENU_NEW_GAME:
//			cancelToasts();
//			onNewGame();
//			break;
//		case MENU_SETTINGS:
//			final Intent intent = new Intent();
//			intent.setClass(this, Preferences.class);
//			startActivity(intent);
//			break;
//	}
//	
//	mRestoreMode.pop(); // don't want to restore when an action was taken
//	
//	return true;
//}
//
//@Override
//public void onOptionsMenuClosed(Menu menu) {
//	super.onOptionsMenuClosed(menu);
//	restoreMode();
//}


//private void saveMode() {
//	// don't want to restore to a state where user can't resume game.
//	final DivideAndConquerView.Mode mode = mBallsView.getMode();
//	final DivideAndConquerView.Mode toRestore = (mode == DivideAndConquerView.Mode.Paused) ?
//	DivideAndConquerView.Mode.PausedByUser : mode;
//	mRestoreMode.push(toRestore);
//}
-(void)saveMode
{
	ActionMode mode = [mBallsView getActionMode];
	ActionMode toRestore = (mode == Paused) ?PausedByUser:mode;
	[mModeStack addObject:(id)toRestore];
}

//private void restoreMode() {
//	if (!mRestoreMode.isEmpty()) {
//		mBallsView.setMode(mRestoreMode.pop());
//	}
//}
-(void)restoreMode
{
	if([mModeStack count]>0)
	{
		[mBallsView setActionMode:(ActionMode)
		 [mModeStack objectAtIndex:(NSUInteger)([mModeStack count]-1)]];
	}
}

/**
 * A ball has hit a moving line.
 * @param ballEngine The engine.
 * @param x The x coordinate of the ball.
 * @param y The y coordinate of the ball.
 */
/** {@inheritDoc} */
//public void onBallHitsMovingLine(final BallEngine ballEngine, float x, float y) {
//	if (--mNumLives == 0) {
//		saveMode();
//		mBallsView.setMode(DivideAndConquerView.Mode.Paused);
//		
//		// vibrate three times
//		if (mVibrateOn) {
//			mVibrator.vibrate(
//							  new long[]{0l, COLLISION_VIBRATE_MILLIS,
//								  50l, COLLISION_VIBRATE_MILLIS,
//								  50l, COLLISION_VIBRATE_MILLIS},
//							  -1);
//		}
//		showDialog(GAME_OVER_DIALOG);
//	} else {
//		if (mVibrateOn) {
//			mVibrator.vibrate(COLLISION_VIBRATE_MILLIS);
//		}
//		updateLivesDisplay(mNumLives);
//		if (mNumLives <= 1) {
//			mBallsView.postDelayed(mOneLifeToastRunnable, 700);
//		} else {
//			mBallsView.postDelayed(mLivesBlinkRedRunnable, 700);
//		}
//	}
//}
-(void)onBallHitsMovingLine:(BallEngine*)ballEngine:(float)x:(float)y
{
	if (--mNumLives == 0) {
		[self saveMode];
		[mBallsView setActionMode:Bouncing];
		
		// vibrate three times
//		if (mVibrateOn) {
//			mVibrator.vibrate(
//							  new long[]{0l, COLLISION_VIBRATE_MILLIS,
//								  50l, COLLISION_VIBRATE_MILLIS,
//								  50l, COLLISION_VIBRATE_MILLIS},
//							  -1);
//		}
//		showDialog(GAME_OVER_DIALOG);
	} else {
		//if (mVibrateOn) {
//			mVibrator.vibrate(COLLISION_VIBRATE_MILLIS);
//		}
		[self updateLivesDisplay:mNumLives];
		if (mNumLives <= 1) {
			//mBallsView.postDelayed(mOneLifeToastRunnable, 700);
		} else {
			//mBallsView.postDelayed(mLivesBlinkRedRunnable, 700);
		}
	}
	
}


//private Runnable mOneLifeToastRunnable = new Runnable() {
//	public void run() {
//		showToast("1 life left!");
//	}
//};
//
//private Runnable mLivesBlinkRedRunnable = new Runnable() {
//	public void run() {
//		mLivesLeft.setTextColor(Color.RED);
//		mLivesLeft.postDelayed(mLivesTextWhiteRunnable, 2000);
//	}
//};



/**
 * A line made it to the edges of its region, splitting off a new region.
 * @param ballEngine The engine.
 */
//public void onAreaChange(final BallEngine ballEngine) {
//	final float percentageFilled = ballEngine.getPercentageFilled();
//	updatePercentDisplay(percentageFilled);
//	if (percentageFilled > LEVEL_UP_THRESHOLD) {
//		levelUp(ballEngine);
//	}
//}
-(void)onAreaChange:(BallEngine*)ballEngine
{
	float percentageFilled = [ballEngine getPercentageFilled];
	[self updatePercentDisplay:percentageFilled];
	float levelThreshold = LEVEL_UP_THRESHOLD;
	if (percentageFilled > levelThreshold) {
		[self levelUp:ballEngine];
	}
}

/**
 * Go to the next level
 * @param ballEngine The ball engine.
 */
//private void levelUp(final BallEngine ballEngine) {
//	mNumBalls++;
//	
//	updatePercentDisplay(0);
//	updateLevelDisplay(mNumBalls);
//	ballEngine.reset(SystemClock.elapsedRealtime(), mNumBalls);
//	mBallsView.setMode(DivideAndConquerView.Mode.Bouncing);
//	if (mNumBalls % 4 == 0) {
//		mNumLives++;
//		updateLivesDisplay(mNumLives);
//		showToast("bonus life!");
//	}
//	if (mNumBalls == 10) {
//		showToast("Level 10? You ROCK!");
//	} else if (mNumBalls == 15) {
//		showToast("BALLS TO THE WALL!");
//	}
//}
-(void)levelUp:(BallEngine*)ballEngine
{
	mNumBalls++;
	
	[self updatePercentDisplay:0];
	[self updateLevelDisplay:mNumBalls];
	CFTimeInterval tmpTime = CFAbsoluteTimeGetCurrent()+10000.0f;
	[ballEngine reset:(long int)tmpTime:mNumBalls];
	[mBallsView setActionMode:Bouncing];
	if (mNumBalls % 4 == 0) {
		mNumLives++;
		[self updateLivesDisplay:mNumLives];
		//showToast("bonus life!");
	}
	if (mNumBalls == 10) {
		//showToast("Level 10? You ROCK!");
	} else if (mNumBalls == 15) {
		//showToast("BALLS TO THE WALL!");
	}
}


//private Runnable mLivesTextWhiteRunnable = new Runnable() {
//	
//	public void run() {
//		mLivesLeft.setTextColor(Color.WHITE);
//	}
//};
//
//private void showToast(String text) {
//	cancelToasts();
//	mCurrentToast = Toast.makeText(this, text, Toast.LENGTH_SHORT);
//	mCurrentToast.show();
//}
//
//private void cancelToasts() {
//	if (mCurrentToast != null) {
//		mCurrentToast.cancel();
//		mCurrentToast = null;
//	}
//}

/**
 * Update the header that displays how much of the space has been contained.
 * @param amountFilled The fraction, between 0 and 1, that is filled.
 */
//private void updatePercentDisplay(float amountFilled) {
//	final int prettyPercent = (int) (amountFilled *100);
//	mPercentContained.setText(
//							  getString(R.string.percent_contained, prettyPercent));
//}
-(void)updatePercentDisplay:(float)amountFiled
{
	//final int prettyPercent = (int) (amountFilled *100);
//	mPercentContained.setText(
//							  getString(R.string.percent_contained, prettyPercent));	
}

/**
 * The user wants to start a new game.
 */
//public void onNewGame() {
//	mNumBalls = NEW_GAME_NUM_BALLS;
//	mNumLives = mNumLivesStart;
//	updatePercentDisplay(0);
//	updateLivesDisplay(mNumLives);
//	updateLevelDisplay(mNumBalls);
//	mBallsView.getEngine().reset(SystemClock.elapsedRealtime(), mNumBalls);
//	mBallsView.setMode(DivideAndConquerView.Mode.Bouncing);
//}
-(void)onNewGame
{
	mNumBalls = NEW_GAME_NUM_BALLS;
	mNumLives = mNumLivesStart;
	[self updatePercentDisplay:0];
	[self updateLivesDisplay:mNumLives];
	[self updateLevelDisplay:mNumBalls];
	CFTimeInterval tmpTime = CFAbsoluteTimeGetCurrent()+10000.0f;
	[mBallsView.mBallEngine reset:(long int)tmpTime:mNumBalls];
	[mBallsView setActionMode:Bouncing];
}

/**
 * Update the header displaying the current level
 */
//private void updateLevelDisplay(int numBalls) {
//	mLevelInfo.setText(getString(R.string.level, numBalls));
//}
-(void)updateLevelDisplay:(long int )numBalls
{
	//mLevelInfo.setText(getString(R.string.level, numBalls));
}

/**
 * Update the display showing the number of lives left.
 * @param numLives The number of lives left.
 */
//void updateLivesDisplay(int numLives) {
//	String text = (numLives == 1) ?
//	getString(R.string.one_life_left) : getString(R.string.lives_left, numLives);
//	mLivesLeft.setText(text);
//}
-(void)updateLivesDisplay:(long int )numLives
{
	//String text = (numLives == 1) ?
//	getString(R.string.one_life_left) : getString(R.string.lives_left, numLives);
//	mLivesLeft.setText(text);
}

//public void onCancel(DialogInterface dialog) {
//	if (dialog == mWelcomeDialog || dialog == mGameOverDialog) {
//		// user hit back, they're done
//		finish();
//	}
//}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
//@Override
//public void onCreate(Bundle savedInstanceState) {
//	super.onCreate(savedInstanceState);
//	// Turn off the title bar
//	requestWindowFeature(Window.FEATURE_NO_TITLE);
//	
//	setContentView(R.layout.main);
//	mBallsView = (DivideAndConquerView) findViewById(R.id.ballsView);
//	mBallsView.setCallback(this);
//	
//	mPercentContained = (TextView) findViewById(R.id.percentContained);
//	mLevelInfo = (TextView) findViewById(R.id.levelInfo);
//	mLivesLeft = (TextView) findViewById(R.id.livesLeft);
//	
//	// we'll vibrate when the ball hits the moving line
//	mVibrator = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);
//}
- (void)loadView {
	NSLog(@"loadView");
	[super loadView];
	//[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updataprogress) userInfo:nil repeats:NO];
//	postDraw = FALSE;
	//delay for 1 second
//	interval = 1;
//	drawCondition = [[NSCondition alloc] init];
//	threadPostDraw = [[NSThread alloc] initWithTarget:self selector:@selector(postInvalidate) object:nil];
//	[threadPostDraw setName:@"Thread-postDraw"];
//	[threadPostDraw start]; 
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    NSLog(@"viewDidLoad");
	mNumBalls = NEW_GAME_NUM_BALLS;
	mNumLivesStart = 3;
	mModeStack = [[NSMutableArray alloc] init];
	mBallsView = self.view;
	mBallsView.mBallEngineDeleGateInView = self;
	[super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	self.mModeStack=nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;	
}


// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (alertView.tag==WELCOME_DIALOG) 
	{	
		NSLog(@"New Game");
		[self onNewGame];
	}
	else if (alertView.tag==GAME_OVER_DIALOG) 
	{
		
	}
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
//- (void)alertViewCancel:(UIAlertView *)alertView;
//
//- (void)willPresentAlertView:(UIAlertView *)alertView;  // before animation and showing view
//- (void)didPresentAlertView:(UIAlertView *)alertView;  // after animation
//
//- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
//- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;

- (void)dealloc {
//	[threadPostDraw release];
//	[drawCondition release];
	[mModeStack release];
    [super dealloc];
}


//-(void)postInvalidate
//{
//	[drawCondition lock];
//	if (postDraw) {
//		//[NSThread sleepForTimeInterval:interval];
//		//sleep(2);
//		//usleep(2000);
//		ActionMode mode = [mBallsView getActionMode];
//		if ( mode== PausedByUser) {
//			[mBallsView drawPausedText];
//		} else if (mode == Bouncing) {
//			// keep em' bouncing!
//			NSLog(@"need to redraw");
//			[mBallsView setNeedsDisplay];
//			//[self setNeedsDisplayInRect:[self bounds]];
//			//[self performSelectorOnMainThread:@selector(setNeedsDisplay) withObject:nil waitUntilDone:NO];
//		}
//		//[self setNeedsDisplay];
//		//[self performSelectorOnMainThread:@selector(setNeedsDisplay) withObject:nil waitUntilDone:NO];
//	}
//	[drawCondition unlock];
//}

//更新函数
-(void)postReDraw
{
	ActionMode mode = [mBallsView getActionMode];
	if ( mode== PausedByUser) {
		[mBallsView drawPausedText];
	} else if (mode == Bouncing) {
		// keep em' bouncing!
		NSLog(@"need to redraw");
		[mBallsView setNeedsDisplay];
		//[self setNeedsDisplayInRect:[self bounds]];
	}
	[NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(postReDraw) userInfo:nil repeats:NO];
}
@end
