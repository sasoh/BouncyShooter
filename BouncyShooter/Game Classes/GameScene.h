//
//  GameScene.h
//  BouncyShooter
//

//  Copyright (c) 2014 -. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene {
    SKSpriteNode *_uiNode;
    SKSpriteNode *_tappableNode;
    SKSpriteNode *_playgroundNode;
    SKLabelNode *_startLabelNode;
    
    BOOL _started;
}

@end
