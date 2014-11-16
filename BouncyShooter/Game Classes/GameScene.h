//
//  GameScene.h
//  BouncyShooter
//

//  Copyright (c) 2014 -. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BSCGameObject.h"

@interface GameScene : SKScene <SKPhysicsContactDelegate, BSCGameObjectDelegate> {
    SKSpriteNode *_uiNode;
    SKSpriteNode *_tappableNode;
    SKSpriteNode *_playgroundNode;
    SKLabelNode *_startLabelNode;
    SKLabelNode *_scoreLabelNode;
    
    BOOL _started;
    int _score;
}

@end
