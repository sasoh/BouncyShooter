//
//  GameScene.m
//  BouncyShooter
//
//  Created by Alexander Popov on 11/15/14.
//  Copyright (c) 2014 -. All rights reserved.
//

#import "GameScene.h"
#import "BSCGameObject.h"

@interface GameScene ()

- (void)setupUI;
- (void)startGame;
- (void)spawnRocketAt:(CGFloat)xCoordinate;

@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view
{

    _started = NO;
    [self setupUI];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if ( _started == YES ) {
        for (UITouch *touch in touches) {
            CGPoint location = [touch locationInNode:self];
            
            if ( CGRectContainsPoint([_tappableNode frame], location)) {
                [self spawnRocketAt:location.x];
            }
        }
    } else {
        [self startGame];
    }
    
}

-(void)update:(CFTimeInterval)currentTime
{

    /* Called before each frame is rendered */

}

- (void)setupUI
{
 
    _uiNode = [[SKSpriteNode alloc] init];
    [_uiNode setSize:[self frame].size];
    [_uiNode setAnchorPoint:CGPointZero];
    [_uiNode setPosition:CGPointZero];
    [_uiNode setColor:[SKColor clearColor]];
    [_uiNode setHidden:YES]; // hide before game start tap
    [self addChild:_uiNode];
    
    // add tappable zone
    _tappableNode = [[SKSpriteNode alloc] init];
    [_tappableNode setSize:CGSizeMake([self frame].size.width, 75.0f)];
    [_tappableNode setAnchorPoint:CGPointZero];
    [_tappableNode setPosition:CGPointZero];
    [_tappableNode setColor:[SKColor greenColor]];
    [_tappableNode setAlpha:0.5f];
    [_uiNode addChild:_tappableNode];
    
    // add tappable zone info label
    SKLabelNode *tappableZoneInfoLabel = [[SKLabelNode alloc] init];
    [tappableZoneInfoLabel setPosition:CGPointMake([_uiNode size].width / 2, [_tappableNode frame].size.height / 2)];
    [tappableZoneInfoLabel setFontColor:[SKColor blackColor]];
    [tappableZoneInfoLabel setText:@"Tap here to launch"];
    [_tappableNode addChild:tappableZoneInfoLabel];
    
    // add target zone
    _playgroundNode = [[SKSpriteNode alloc] init];
    [_playgroundNode setSize:CGSizeMake([_uiNode size].width, [_uiNode size].height - [_tappableNode size].height)];
    [_playgroundNode setAnchorPoint:CGPointZero];
    [_playgroundNode setPosition:CGPointMake(0.0f, [_tappableNode size].height)];
    [_playgroundNode setColor:[SKColor grayColor]];
    [_playgroundNode setZPosition:[_tappableNode zPosition] - 2];
    [_uiNode addChild:_playgroundNode];
    
    // add target zone info label
    SKLabelNode *targetZoneInfoLabel = [[SKLabelNode alloc] init];
    [targetZoneInfoLabel setPosition:CGPointMake([_playgroundNode frame].size.width / 2, [_playgroundNode frame].size.height / 2)];
    [targetZoneInfoLabel setFontColor:[SKColor blackColor]];
    [targetZoneInfoLabel setText:@"Target zone"];
    [targetZoneInfoLabel setZRotation:45.0f];
    [_playgroundNode addChild:targetZoneInfoLabel];
    
    // add tap to start label
    _startLabelNode = [[SKLabelNode alloc] init];
    [_startLabelNode setPosition:CGPointMake([_playgroundNode frame].size.width / 2, [_playgroundNode frame].size.height / 2)];
    [_startLabelNode setFontColor:[SKColor whiteColor]];
    [_startLabelNode setText:@"Tap to start"];
    [self addChild:_startLabelNode];
    
}

- (void)startGame
{
    
    _started = YES;
    [_uiNode setHidden:NO];
    [_startLabelNode removeFromParent];

}

- (void)spawnRocketAt:(CGFloat)xCoordinate
{
    
    // create rocket object
    BSCGameObject *rocket = [[BSCGameObject alloc] initWithImageNamed:@"astronaut.png"];
    [rocket setPosition:CGPointMake(xCoordinate, -([rocket frame].size.height / 2))];
    [rocket setScale:0.25f];
    [rocket setZPosition:[_tappableNode zPosition] - 1];
    [self addChild:rocket];
    
    // create launch & remove action sequence
    SKAction *movementAction = [SKAction moveBy:CGVectorMake(0.0f, 750.0f) duration:2.0f];
    [movementAction setTimingMode:SKActionTimingEaseIn];
    SKAction *removeAction = [SKAction removeFromParent];
    SKAction *sequence = [SKAction sequence:@[movementAction, removeAction]];
    
    [rocket runAction:sequence];
    
}

@end
