//
//  IntroLayer.m
//  cardgame
//
//  Created by Mark Evans on 5/8/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "MenuLayer.h"

#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds ].size.height - (double)568) < DBL_EPSILON)
#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// 
-(void) onEnter
{
	[super onEnter];

    //WIN SIZE
	CGSize size = [[CCDirector sharedDirector] winSize];
    
    //SPLASH BACKGROUND
	if (IS_IPHONE_5) {
        background = [CCSprite spriteWithFile:@"Default-568h@2x.png"];
        background.rotation = 90;
    } else if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        background = [CCSprite spriteWithFile:@"Default.png"];
        background.rotation = 90;
    } else {
		background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
	}
	background.position = ccp(size.width/2, size.height/2);
	[self addChild: background];
	
	// In one second transition to the new scene
	[self scheduleOnce:@selector(makeTransition:) delay:1];
}

-(void) makeTransition:(ccTime)dt
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MenuLayer scene] withColor:ccWHITE]];
}
@end
