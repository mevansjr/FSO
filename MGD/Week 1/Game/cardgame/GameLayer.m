//
//  GameLayer.m
//  cardgame
//
//  Created by Mark Evans on 5/8/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import "GameLayer.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"
#import "MenuLayer.h"

#define randint(min, max) (arc4random() % ((max + 1) - min)) + min
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds ].size.height - (double)568) < DBL_EPSILON)

#pragma mark - GameLayer

@implementation GameLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	GameLayer *layer = [GameLayer node];
	[scene addChild: layer];
	return scene;
}

-(void) onEnter
{
    [super onEnter];
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"musicloop.wav" loop:YES];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"musicloop.wav"];
}

-(id) init
{
	if( (self=[super init]) ) {
        //WIN SIZE
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        //MENU BACKGROUND
        CCSprite *background;
        if (IS_IPHONE_5) {
            background = [CCSprite spriteWithFile:@"gamebg-568@2x.png"];
        } else if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            background = [CCSprite spriteWithFile:@"gamebg.png"];
        }
        background.position = ccp(size.width/2, size.height/2);
        [self addChild: background];
        
        //SET CARD TYPES
        cardType = [[NSMutableArray alloc]initWithObjects:@"s", @"c", @"d", @"h", nil];
        
        //SET SPRITE SHEETS
        if (IS_IPHONE_5) {
            CCTexture2D *iphone5_tex = [[CCTextureCache sharedTextureCache] addImage:@"customcards.png"];
            [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:@"customcards_coords.plist" texture:iphone5_tex];
        } else if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            CCTexture2D *tex = [[CCTextureCache sharedTextureCache] addImage:@"customcards_r.png"];
            [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:@"customcards_r_coords.plist" texture:tex];
        }
        
        scoreInt = 0;
        
        //CREATE SCORE LABEL
        scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i",scoreInt] fontName:@"Marker Felt" fontSize:24];
        if (IS_IPHONE_5) {
            [scoreLabel setPosition:ccp(-235+size.width/2, -20+size.height/1)];
        } else {
            [scoreLabel setPosition:ccp(-200+size.width/2, -20+size.height/1)];
        }
		[self addChild:scoreLabel z:1];
        [scoreLabel setColor:ccYELLOW];
        
        //CREATE CLOSE BUTTON
        CCMenuItemSprite *closeImage = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"close.png"] selectedSprite:[CCSprite spriteWithFile:@"close.png"] target:self selector:@selector(endGame)];
        CCMenu *closemenu = [CCMenu menuWithItems:closeImage, nil];
        if (IS_IPHONE_5) {
            [closemenu setPosition:ccp(250+size.width/2, -20+size.height/1)];
        } else {
            [closemenu setPosition:ccp(200+size.width/2, -20+size.height/1)];
        }
        [self addChild:closemenu z:1];
        
        //CREATE MENU
        CCMenuItemFont *hi = [CCMenuItemFont itemWithString:@"Higher" target:self selector:@selector(higher:)];
        CCMenuItemFont *lo = [CCMenuItemFont itemWithString:@"Lower" target:self selector:@selector(lower:)];
        CCMenu *menu = [CCMenu menuWithItems:hi, lo, nil];
        if (IS_IPHONE_5) {
            [menu setPosition:ccp(-65+size.width/1, size.height/2)];
        } else {
            [menu setPosition:ccp(-65+size.width/1, size.height/2)];
        }
        [menu alignItemsVerticallyWithPadding:20.0];
        [self addChild:menu z:1];
        
        [self randomCards];
	}
	return self;
}

- (void)endGame
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MenuLayer scene] withColor:ccWHITE]];
}

- (void)addPoints
{
    scoreInt = scoreInt + 500;
    [scoreLabel setString:[NSString stringWithFormat:@"%i", scoreInt]];
}

- (void)removePoints
{
    scoreInt = scoreInt - 500;
    [scoreLabel setString:[NSString stringWithFormat:@"%i", scoreInt]];
}

- (void)drawPoints
{
    scoreInt = scoreInt + 0;
    [scoreLabel setString:[NSString stringWithFormat:@"%i", scoreInt]];
}

-(void)randomCards
{
    //WIN SIZE
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    //GET RANDOM CARD VALUE
    int r1 = randint(1, 13);
    playerInt = r1;
    
    //GET RANDOM CARD TYPE
    int random = randint(0, 3);
    NSString *card = [[NSString alloc]initWithFormat:@"%@%d.psd",[cardType objectAtIndex:random],r1];
    
    CCSprite *dealerCard = [CCSprite spriteWithSpriteFrameName:card];
    if (IS_IPHONE_5) {
        dealerCard.position = ccp(-67+size.width/2, 50+size.height/2);
    } else {
        dealerCard.position = ccp(-70+size.width/2, 48+size.height/2);
    }
    [self addChild:dealerCard];
    
    CCSprite *playerCard = [CCSprite spriteWithSpriteFrameName:@"back.psd"];
    if (IS_IPHONE_5) {
         playerCard.position = ccp(73+size.width/2, 50+size.height/2);
    } else {
        playerCard.position = ccp(70+size.width/2, 48+size.height/2);
    }
    [self addChild:playerCard];
}

- (void)higher:(id)sender
{
    //WIN SIZE
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    //GET RANDOM CARD VALUE
    int r2 = randint(1, 13);
    dealerInt = r2;
    
    //GET RANDOM CARD TYPE
    int random = randint(0, 3);
    NSString *card = [[NSString alloc]initWithFormat:@"%@%d.psd",[cardType objectAtIndex:random],r2];
    
	CCSprite *playerCard =[CCSprite spriteWithSpriteFrameName:card];
    if (IS_IPHONE_5) {
        playerCard.position = ccp(73+size.width/2, 50+size.height/2);
    } else {
        playerCard.position = ccp(70+size.width/2, 48+size.height/2);
    }
    [self addChild:playerCard];
    
    if (dealerInt == playerInt) {
        NSLog(@"DRAW");
        //[self drawPoints];
        [[SimpleAudioEngine sharedEngine] playEffect:@"coin.mp3"];
    } else if (dealerInt > playerInt) {
        NSLog(@"PLAYER WINS");
        [self addPoints];
        [[SimpleAudioEngine sharedEngine] playEffect:@"coin.mp3"];
    } else if (playerInt > dealerInt) {
        NSLog(@"DEALER WINS");
        [self removePoints];
        [[SimpleAudioEngine sharedEngine] playEffect:@"wrong.wav"];
    } else {
        NSLog(@"WEIRD");
        [self addPoints];
        [[SimpleAudioEngine sharedEngine] playEffect:@"coin.mp3"];
    }
    //RESET
	[self scheduleOnce:@selector(reset) delay:2];
}

- (void)lower:(id)sender
{
    //WIN SIZE
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    //GET RANDOM CARD VALUE
    int r2 = randint(1, 13);
    dealerInt = r2;
    
    //GET RANDOM CARD TYPE
    int random = randint(0, 3);
    NSString *card = [[NSString alloc]initWithFormat:@"%@%d.psd",[cardType objectAtIndex:random],r2];
    
	CCSprite *playerCard =[CCSprite spriteWithSpriteFrameName:card];
    if (IS_IPHONE_5) {
        playerCard.position = ccp(73+size.width/2, 50+size.height/2);
    } else {
        playerCard.position = ccp(70+size.width/2, 48+size.height/2);
    }
    [self addChild:playerCard];
    
    if (dealerInt == playerInt) {
        NSLog(@"DRAW");
        //[self drawPoints];
        [[SimpleAudioEngine sharedEngine] playEffect:@"coin.mp3"];
    } else if (dealerInt < playerInt) {
        NSLog(@"PLAYER WINS");
        [self addPoints];
        [[SimpleAudioEngine sharedEngine] playEffect:@"coin.mp3"];
    } else if (playerInt < dealerInt) {
        NSLog(@"DEALER WINS");
        [self removePoints];
        [[SimpleAudioEngine sharedEngine] playEffect:@"wrong.wav"];
    } else {
        NSLog(@"WEIRD");
        [self addPoints];
        [[SimpleAudioEngine sharedEngine] playEffect:@"coin.mp3"];
    }
    //RESET
	[self scheduleOnce:@selector(reset) delay:2];
}

- (void)reset
{
    //WIN SIZE
    CGSize size = [[CCDirector sharedDirector] winSize];
    playerInt = 0;
    dealerInt = 0;
    
    CCSprite *dealerCard = [CCSprite spriteWithSpriteFrameName:@"back.psd"];
    if (IS_IPHONE_5) {
        dealerCard.position = ccp(-67+size.width/2, 50+size.height/2);
    } else {
        dealerCard.position = ccp(-70+size.width/2, 48+size.height/2);
    }
    [self addChild:dealerCard];
    
    CCSprite *playerCard = [CCSprite spriteWithSpriteFrameName:@"back.psd"];
    if (IS_IPHONE_5) {
        playerCard.position = ccp(73+size.width/2, 50+size.height/2);
    } else {
        playerCard.position = ccp(70+size.width/2, 48+size.height/2);
    }
    [self addChild:playerCard];
    
    [self randomCards];
}

- (void) dealloc
{
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
