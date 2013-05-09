//
//  GameLayer.h
//  cardgame
//
//  Created by Mark Evans on 5/8/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import <GameKit/GameKit.h>
#import "cocos2d.h"

@interface GameLayer : CCLayer
{
    int dealerInt;
    int playerInt;
    int scoreInt;
    NSMutableArray *cardType;
    CCLabelTTF *scoreLabel;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
