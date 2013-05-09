//
//  MenuLayer.m
//  Game
//
//  Created by Mark Evans on 5/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MenuLayer.h"
#import "GameLayer.h"
#import "SimpleAudioEngine.h"

#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds ].size.height - (double)568) < DBL_EPSILON)

@implementation MenuLayer

+(CCScene *)scene
{
	CCScene *scene = [CCScene node];
	MenuLayer *layer = [MenuLayer node];
	[scene addChild: layer];
	return scene;
}

-(void) onEnter
{
    [super onEnter];
    
    //LOAD BACKGROUND MUSIC
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"musicloop.wav" loop:YES];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"musicloop.wav"];
}

-(void) onExit
{
    [super onExit];
    
    //UNLOAD BACKGROUND MUSIC
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"musicloop.wav"];
}

-(id)init
{
	if( (self=[super init]) )
    {
        self.isTouchEnabled = YES;
        
        //WIN SIZE
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        //MENU BACKGROUND
        CCSprite *background;
        if (IS_IPHONE_5) {
            background = [CCSprite spriteWithFile:@"menubg-568@2x.png"];
        } else if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            background = [CCSprite spriteWithFile:@"menubg.png"];
        }
        background.position = ccp(size.width/2, size.height/2);
        [self addChild: background];
        
        //CREATE BUTTON
        CCMenuItemSprite *startGameImage = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"startgame.png"] selectedSprite:[CCSprite spriteWithFile:@"startgame.png"] target:self selector:@selector(buttonAction:)];
        CCMenuItemSprite *howToImage = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"howto.png"] selectedSprite:[CCSprite spriteWithFile:@"howto.png"] target:self selector:@selector(buttonAction:)];
        CCMenuItemSprite *settingsImage = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"settings.png"] selectedSprite:[CCSprite spriteWithFile:@"settings.png"] target:self selector:@selector(buttonAction:)];
        
        //CREATE MENU
        if (IS_IPHONE_5) {
            CCMenu *myMenu = [CCMenu menuWithItems:startGameImage, howToImage, settingsImage, nil];
            [myMenu setPosition:ccp(134 + size.width/2, -32 + size.height/2)];
            [myMenu alignItemsVerticallyWithPadding:10.0];
            [self addChild:myMenu z:1];
        } else if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            CCMenu *myMenu = [CCMenu menuWithItems:startGameImage, howToImage, settingsImage, nil];
            [myMenu setPosition:ccp(93 + size.width/2, -32 + size.height/2)];
            [myMenu alignItemsVerticallyWithPadding:10.0];
            [self addChild:myMenu z:1];
        }
    }
    return self;
}

- (void)buttonAction:(id)sender
{
	//REFERENCE BUTTON
	CCMenuItemFont *button = (CCMenuItemFont *)sender;
    
	//SPIN BUTTON AND START GAME
	[button runAction:[CCScaleTo actionWithDuration:2.0 scale:1.2]];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameLayer scene] withColor:ccWHITE]];
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
