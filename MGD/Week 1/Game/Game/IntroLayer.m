//
//  IntroLayer.m
//  Game
//
//  Created by Mark Evans on 5/6/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//

#import "IntroLayer.h"
#import "GameLayer.h"
#import "MenuLayer.h"
#import "SimpleAudioEngine.h"

#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds ].size.height - (double)568) < DBL_EPSILON)

#pragma mark - IntroLayer

@implementation IntroLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	IntroLayer *layer = [IntroLayer node];
	[scene addChild: layer];
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
	
	//TRANSISTION
	[self scheduleOnce:@selector(makeTransition:) delay:1];
}

-(void) makeTransition:(ccTime)dt
{
    //PLAY SOUND
    [[SimpleAudioEngine sharedEngine] playEffect:@"startup2.wav"];
    
    //LOAD MENU
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:2.0 scene:[MenuLayer scene]]];
}
@end
