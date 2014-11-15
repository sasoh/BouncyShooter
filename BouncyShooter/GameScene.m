//
//  GameScene.m
//  BouncyShooter
//
//  Created by Alexander Popov on 11/15/14.
//  Copyright (c) 2014 -. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view
{

    // construct scene
    _tappableZone = [[SKSpriteNode alloc] init];
    [_tappableZone setSize:CGSizeMake([self frame].size.width, 75.0f)];
    [_tappableZone setColor:[UIColor greenColor]];
    [_tappableZone setAnchorPoint:CGPointZero];
    [_tappableZone setPosition:CGPointZero];
    [self addChild:_tappableZone];
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        if ( CGRectContainsPoint([_tappableZone frame], location)) {
            NSLog(@"launch rocket along X: %.0f", location.x);
        }
    }
}

-(void)update:(CFTimeInterval)currentTime
{

    /* Called before each frame is rendered */

}

@end
