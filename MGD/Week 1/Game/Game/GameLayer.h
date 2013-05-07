//
//  FirstLayer.h
//  Game
//
//  Created by Mark Evans on 5/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameLayer : CCLayer <CCStandardTouchDelegate>
{
    CCSprite *plane;
    CCSprite *bomb;
    CCSprite *box;
    CCSprite *aim;
    CCSprite *_bg1;
    CCSprite *_bg2;
}
+(CCScene *)scene;
-(void)update:(ccTime)delta;

@end
