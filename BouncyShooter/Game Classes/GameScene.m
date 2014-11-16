//
//  GameScene.m
//  BouncyShooter
//
//  Created by Alexander Popov on 11/15/14.
//  Copyright (c) 2014 -. All rights reserved.
//

#import "GameScene.h"

@interface GameScene ()

- (void)setupUI;
- (void)setupPhysics;
- (void)startGame;
- (void)spawnRocketAt:(CGFloat)xCoordinate;
- (void)spawnAsteroid;

@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view
{

    _started = NO;
    _score = 0;
    
    [self setupUI];
    [self setupPhysics];
    
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

- (void)setupPhysics
{
    
    SKPhysicsWorld *physicsWorld = [self physicsWorld];
    [physicsWorld setContactDelegate:self];
    
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
    _playgroundNode = [[BSCGameObject alloc] init];
    [_playgroundNode setSize:CGSizeMake([_uiNode size].width, [_uiNode size].height - [_tappableNode size].height)];
    [_playgroundNode setAnchorPoint:CGPointZero];
    [_playgroundNode setPosition:CGPointMake(0.0f, [_tappableNode size].height)];
    [_playgroundNode setColor:[SKColor grayColor]];
    [_playgroundNode setZPosition:[_tappableNode zPosition] - 2];
    [_uiNode addChild:_playgroundNode];
    
    // target zone physics boundary
    CGRect tempRect = [_playgroundNode frame];
    tempRect.origin = CGPointZero; // reset origin so boundary conicides with frame
    SKPhysicsBody *targetZonePhysicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:tempRect];
    [targetZonePhysicsBody setCategoryBitMask:CATEGORY_BOUNDARY];
    [targetZonePhysicsBody setCollisionBitMask:CATEGORY_ASTEROID];
    [targetZonePhysicsBody setContactTestBitMask:CATEGORY_ASTEROID];
    [targetZonePhysicsBody setAffectedByGravity:NO];
    [_playgroundNode setPhysicsBody:targetZonePhysicsBody];
    
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
    
    // add score label
    _scoreLabelNode = [[SKLabelNode alloc] init];
    [_scoreLabelNode setPosition:CGPointMake(0.0f, [_uiNode frame].size.height - 30.0f)];
    [_scoreLabelNode setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    [_scoreLabelNode setFontColor:[SKColor whiteColor]];
    [_scoreLabelNode setText:@"Score: 0"];
    [_uiNode addChild:_scoreLabelNode];
    
}

- (void)startGame
{
    
    _started = YES;
    [_uiNode setHidden:NO];
    [_startLabelNode removeFromParent];
    
    [self spawnAsteroid];

}

- (void)spawnRocketAt:(CGFloat)xCoordinate
{
    
    // create rocket object
    BSCGameObject *rocket = [[BSCGameObject alloc] initWithImageNamed:@"astronaut.png"];
    [rocket setPosition:CGPointMake(xCoordinate, -([rocket frame].size.height / 2))];
    [rocket setScale:0.25f];
    [_playgroundNode addChild:rocket];
    
    // configure physics body
    SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:[rocket size]];
    [physicsBody setAffectedByGravity:NO];
    [physicsBody setCategoryBitMask:CATEGORY_ROCKET];
    [physicsBody setContactTestBitMask:CATEGORY_ASTEROID];
    [physicsBody setCollisionBitMask:CATEGORY_ASTEROID];
    [rocket setPhysicsBody:physicsBody];
    
    // create launch & remove action sequence
    SKAction *movementAction = [SKAction moveBy:CGVectorMake(0.0f, 750.0f) duration:2.0f];
    [movementAction setTimingMode:SKActionTimingEaseIn];
    SKAction *removeAction = [SKAction removeFromParent];
    SKAction *sequence = [SKAction sequence:@[movementAction, removeAction]];
    
    [rocket runAction:sequence];
    
}

- (void)spawnAsteroid
{
    
    
    
    // create asteroid object
    BSCGameObject *asteroid = [[BSCGameObject alloc] initWithImageNamed:@"asteroid.png"];
    
    int inset = 20;
    CGPoint randomPoint = CGPointMake(inset + rand() % ((int)[_playgroundNode frame].size.width - 2 * inset), inset + rand() % ((int)[_playgroundNode frame].size.height - 2 * inset));
    
    [asteroid setPosition:randomPoint];
    [asteroid setScale:0.25f];
    [asteroid setDelegate:self];
    [_playgroundNode addChild:asteroid];
    
    // configure physics body
    SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:[asteroid frame].size.width / 2];
    [physicsBody setAffectedByGravity:NO];
    [physicsBody setCategoryBitMask:CATEGORY_ASTEROID];
    [physicsBody setContactTestBitMask:CATEGORY_ROCKET | CATEGORY_BOUNDARY];
    [physicsBody setCollisionBitMask:CATEGORY_ROCKET | CATEGORY_BOUNDARY];
    [asteroid setPhysicsBody:physicsBody];
    
}

#pragma mark Physics contact delegate

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    
    SKPhysicsBody *bodyA = [contact bodyA];
    SKPhysicsBody *bodyB = [contact bodyB];
    
    BSCGameObject *objectA = (BSCGameObject *)[bodyA node];
    BSCGameObject *objectB = (BSCGameObject *)[bodyB node];
    
    [objectA processCollisionWith:bodyB];
    [objectB processCollisionWith:bodyA];
    
}

#pragma mark BSCGameObject delegate

- (void)didDestroyAsteroid
{
    
    // should spawn another
    [self spawnAsteroid];
    
    // increase score
    _score++;
    [_scoreLabelNode setText:[NSString stringWithFormat:@"Score: %d", _score]];
    
    
}

@end
