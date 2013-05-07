//
//  CreditsLayer.m
//  Game
//
//  Created by Mark Evans on 5/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "CreditsLayer.h"
#import "IntroLayer.h"
#import "MenuLayer.h"

@implementation CreditsLayer

+(CCScene *)scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CreditsLayer *layer = [CreditsLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)init
{
	if( (self=[super init]) )
    {
        self.isTouchEnabled = YES;
        
        //WIN SIZE
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        //CREATE BUTTON
        CCMenuItemFont *startOver = [CCMenuItemFont itemWithString:@"Created By: Mark Evans" target:self selector:@selector(buttonAction:)];
        
        //CREATE MENU
		CCMenu *myMenu = [CCMenu menuWithItems:startOver, nil];
		[myMenu setPosition:ccp(size.width/2, size.height/2)];
		[myMenu alignItemsVerticallyWithPadding:20.0];
		[self addChild:myMenu z:1];
    }
    return self;
}

- (void)buttonAction:(id)sender
{
	//ANIMATE BUTTON AND START OVER
	[[CCDirector sharedDirector] pushScene:[CCTransitionFadeTR transitionWithDuration:2.0 scene:[MenuLayer scene]]];
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in [event allTouches])
    {
        //TOUCH LOCATION
        CGPoint touchLocation = [touch locationInView:touch.view];
        NSLog(@"TOUCH-> x: %f - y: %f", touchLocation.x, touchLocation.y);
    }
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //
}

-(void)onEnterTransitionDidFinish
{
    CCTouchDispatcher *ccTouchDispatcher =[[CCTouchDispatcher alloc]init];
    [ccTouchDispatcher addStandardDelegate:self priority:0];
}
@end
