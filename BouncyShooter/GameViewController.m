//
//  GameViewController.m
//  BouncyShooter
//
//  Created by Alexander Popov on 11/15/14.
//  Copyright (c) 2014 -. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;

    GameScene *scene = [[GameScene alloc] initWithSize:[skView frame].size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:scene];    
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
    
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.

}

- (BOOL)prefersStatusBarHidden
{

    return YES;

}

@end
