//
//  ViewController.h
//  Matchismo
//
//  Created by Candance Smith on 5/16/16.
//  Copyright © 2016 candance. All rights reserved.
//
// Abstract class. Must implement methods as described below

#import <UIKit/UIKit.h>
#import "Deck.h"

@class CardMatchingGame;

@interface ViewController : UIViewController

// protected
// for subclasses
- (Deck *)createDeck; // abstract

@property (nonatomic, strong) CardMatchingGame *game;

@end

