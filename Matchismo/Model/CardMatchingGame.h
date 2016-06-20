//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Candance Smith on 6/2/16.
//  Copyright © 2016 candance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// to count # of cards in the deck (less than 2 cards, can't match)
// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;

// to record which card was picked
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

@property (nonatomic, readonly) NSInteger lastScore;

@property (nonatomic) NSInteger numberOfCardsMatchMode;

@property (nonatomic, strong) NSMutableArray *chosenCards;

@end
