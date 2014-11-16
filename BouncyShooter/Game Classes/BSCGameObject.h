//
//  BSCGameObject.h
//  BouncyShooter
//
//  Created by Alexander Popov on 11/15/14.
//  Copyright (c) 2014 -. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

static const int CATEGORY_BOUNDARY  = 1 << 0;
static const int CATEGORY_ROCKET    = 1 << 1;
static const int CATEGORY_ASTEROID  = 1 << 2;

@protocol BSCGameObjectDelegate <NSObject>

@optional
- (void)didDestroyAsteroid;

@end

@interface BSCGameObject : SKSpriteNode

@property (nonatomic, weak) id <BSCGameObjectDelegate> delegate;

- (void)processCollisionWith:(SKPhysicsBody *)body;

@end
