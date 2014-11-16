//
//  BSCGameObject.m
//  BouncyShooter
//
//  Created by Alexander Popov on 11/15/14.
//  Copyright (c) 2014 -. All rights reserved.
//

#import "BSCGameObject.h"

@implementation BSCGameObject

- (void)processCollisionWith:(SKPhysicsBody *)body
{
    
    SKPhysicsBody *physicsBody = [self physicsBody];
    int category = [physicsBody categoryBitMask];
    
    int targetCategory = [body categoryBitMask];
    
    if ( category == CATEGORY_ASTEROID ) {
        if ( targetCategory == CATEGORY_ROCKET ) {
            [_delegate didDestroyAsteroid];
            
            // destroy asteroid
            [self removeFromParent];
        } else if ( targetCategory == CATEGORY_BOUNDARY ) {
            NSLog(@"asteroid collided with wall");
        }
    }
    
}

@end
