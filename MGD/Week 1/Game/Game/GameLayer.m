//
//  FirstLayer.m
//  Game
//
//  Created by Mark Evans on 5/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "MenuLayer.h"
#import "CreditsLayer.h"
#import "SimpleAudioEngine.h"

static const int kScrollSpeed = 3;

@implementation GameLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	GameLayer *layer = [GameLayer node];
	[scene addChild: layer];
	return scene;
}

-(id)init
{
	if( (self=[super init]) )
    {
        self.isTouchEnabled = YES;
    
        //WIN SIZE
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        //SCROLLING BACKGROUND -- SKY
        _bg1 = [CCSprite spriteWithFile:@"sky2.png"];
		_bg1.position = CGPointMake(0, size.height * 0.5f);
		_bg1.anchorPoint = CGPointMake(0, 0.5f);
		[self addChild:_bg1];
		_bg2 = [CCSprite spriteWithFile:@"sky2.png"];
		_bg2.position = CGPointMake(_bg2.contentSize.width, _bg1.position.y);
		_bg2.anchorPoint = CGPointMake(0, 0.5f);
		[self addChild:_bg2];
        
        //SET TEXTURE
        CCTexture2D *tex = [[CCTextureCache sharedTextureCache] addImage:@"spritetexture.png"];
        [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:@"spritecoordinates.plist" texture:tex];
        
        //PLANE
        plane = [CCSprite spriteWithSpriteFrameName:@"p1.png"];
        plane.position = ccp(size.width/2, size.height/2);
        plane.rotation = 90;
        [self addChild: plane];
        
        //BOMB
        bomb = [CCSprite spriteWithSpriteFrameName:@"bomb.png"];
        CGPoint pos1 = CGPointMake(plane.position.x + 155, plane.position.y);
        bomb.position = pos1;
        [self addChild: bomb];
        
        //BOX
        box = [CCSprite spriteWithSpriteFrameName:@"box.png"];
        CGPoint pos2 = CGPointMake(plane.position.x + -155, plane.position.y);
        box.position = pos2;
        [self addChild: box];
        
        //BOX
        aim = [CCSprite spriteWithFile:@"crosshair.png"];
        CGPoint pos3 = ccp(size.width/2, size.height/2);
        aim.position = pos3;
        [self addChild:aim];
        
        //CREATE BUTTON
        CCMenuItemFont *closeBtn = [CCMenuItemFont itemWithString:@"Close" target:self selector:@selector(buttonAction:)];
        
        //CREATE MENU
		CCMenu *closeMenu = [CCMenu menuWithItems:closeBtn, nil];
		[closeMenu setPosition:ccp(-45+size.width/1, -20+size.height/1)];
		[self addChild:closeMenu z:1];
        
        [self scheduleUpdate];
    }
	return self;
}

- (void)buttonAction:(id)sender
{
	//REFERENCE BUTTON
	CCMenuItemFont *button = (CCMenuItemFont *)sender;
    
	//SPIN BUTTON AND START GAME
	[button runAction:[CCEaseInOut actionWithDuration:1]];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[CreditsLayer scene] withColor:ccWHITE]];
}

-(void)update:(ccTime)delta
{
	CGPoint bg1Pos = _bg1.position;
	CGPoint bg2Pos = _bg2.position;
	bg1Pos.x -= kScrollSpeed;
	bg2Pos.x -= kScrollSpeed;
    
	// move scrolling background back from left to right end to achieve "endless" scrolling
	if (bg1Pos.x < -(_bg1.contentSize.width))
	{
		bg1Pos.x += _bg1.contentSize.width;
		bg2Pos.x += _bg2.contentSize.width;
	}
    
	// remove any inaccuracies by assigning only int values (this prevents floating point rounding errors accumulating over time)
	bg1Pos.x = (int)bg1Pos.x;
	bg2Pos.x = (int)bg2Pos.x;
	_bg1.position = bg1Pos;
	_bg2.position = bg2Pos;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in [event allTouches])
    {
        //TOUCH LOCATION
        CGPoint touchLocation = [touch locationInView:touch.view];
        
        if (plane != nil) {
            CGRect planeRect = CGRectMake(plane.boundingBox.origin.x, plane.boundingBox.origin.y, plane.boundingBox.size.width, plane.boundingBox.size.height);
            
            //PLANE CONDITIONAL
            CGRect *checkForPlane = CGRectContainsPoint(planeRect,touchLocation);
            if (checkForPlane)
            {
                //PLAY SOUND
                [[SimpleAudioEngine sharedEngine] playEffect:@"plane.wav"];
            } else {
                //NSLog(@"DID NOT TOUCH PLANE");
            }
        }
        
        if (box != nil) {
            CGRect boxRect = CGRectMake(box.boundingBox.origin.x, box.boundingBox.origin.y, box.boundingBox.size.width, box.boundingBox.size.height);
            
            //BOX CONDITIONAL
            CGRect *checkForBox = CGRectContainsPoint(boxRect,touchLocation);
            if (checkForBox)
            {
                //PLAY SOUND
                [[SimpleAudioEngine sharedEngine] playEffect:@"box.wav"];
            } else {
                //NSLog(@"DID NOT TOUCH BOX");
            }
        }
        
        if (bomb != nil) {
            CGRect bombRect = CGRectMake(bomb.boundingBox.origin.x, bomb.boundingBox.origin.y, bomb.boundingBox.size.width, bomb.boundingBox.size.height);
            
            //BOX CONDITIONAL
            CGRect *checkForBomb = CGRectContainsPoint(bombRect,touchLocation);
            if (checkForBomb)
            {
                //PLAY SOUND
                [[SimpleAudioEngine sharedEngine] playEffect:@"bomb.wav"];
            } else {
                //NSLog(@"DID NOT TOUCH BOX");
            }
        }
    }
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in [event allTouches])
    {
        //BOUNDING BOX FOR BOX
        CGRect boxRect = CGRectMake(box.boundingBox.origin.x, box.boundingBox.origin.y, box.boundingBox.size.width, box.boundingBox.size.height);
        //BOUNDING BOX FOR PLANE
        CGRect planeRect = CGRectMake(plane.boundingBox.origin.x, plane.boundingBox.origin.y, plane.boundingBox.size.width, plane.boundingBox.size.height);
        //BOUNDING BOX FOR BOMB
        CGRect bombRect = CGRectMake(bomb.boundingBox.origin.x, bomb.boundingBox.origin.y, bomb.boundingBox.size.width, bomb.boundingBox.size.height);
    
        //MOVES CROSSHAIR
        CGPoint location = [touch locationInView:touch.view];
        location = [[CCDirector sharedDirector]convertToGL:location];
        [aim runAction:[CCMoveTo actionWithDuration:.2 position:location]];
        //PLAY SOUND
        [[SimpleAudioEngine sharedEngine] playEffect:@"gunshot.wav"];
    
        if (plane != nil) {
            //PLANE CONDITIONAL
            CGRect *checkForPlane = CGRectContainsPoint(planeRect,location);
            if (checkForPlane)
            {
                [plane runAction:[CCSequence actions:[CCScaleTo actionWithDuration:2.6 scale:0], [CCCallFuncO actionWithTarget:self       selector:@selector(removeSprite:) object:plane], nil]];
            } else {
                //NSLog(@"DID NOT TOUCH BOX");
            }
        }
        if (bomb != nil) {
            //BOMB CONDITIONAL
            CGRect *checkForBomb = CGRectContainsPoint(bombRect,location);
            if (checkForBomb)
            {
                [bomb runAction:[CCSequence actions:[CCScaleTo actionWithDuration:2.6 scale:0], [CCCallFuncO actionWithTarget:self       selector:@selector(removeSprite:) object:bomb], nil]];
            } else {
                //NSLog(@"DID NOT TOUCH BOX");
            }
        }
        if (box != nil) {
            //BOX CONDITIONAL
            CGRect *checkForBox = CGRectContainsPoint(boxRect,location);
            if (checkForBox)
            {
                [box runAction:[CCSequence actions:[CCScaleTo actionWithDuration:2.6 scale:0], [CCCallFuncO actionWithTarget:self       selector:@selector(removeSprite:) object:box], nil]];
            } else {
            //NSLog(@"DID NOT TOUCH BOX");
            }
        }
    }
}

-(void) removeSprite:(CCSprite*)s
{
    [s setPosition:CGPointMake(-1000, -1000)];
}

-(void)onEnterTransitionDidFinish
{
    CCTouchDispatcher *ccTouchDispatcher =[[CCTouchDispatcher alloc]init];
    [ccTouchDispatcher addStandardDelegate:self priority:0];
}

- (void)dealloc
{
	[super dealloc];
}

@end
