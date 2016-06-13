//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Candance Smith on 6/13/16.
//  Copyright © 2016 candance. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "CardMatchingGame.h"


@implementation SetCardGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.game.numberOfCardsMatchMode = 3;
}

@end
