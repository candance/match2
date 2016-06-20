//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Candance Smith on 6/2/16.
//  Copyright © 2016 candance. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

// readwrite is only used when you're using readonly
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger lastScore;

@property (nonatomic, strong) NSMutableArray *cards; // of Card

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)chosenCards
{
    if (!_chosenCards) _chosenCards = [[NSMutableArray alloc] init];
    return _chosenCards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        // to add cards for matching
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            // to make sure card is not nil (aka still cards left in deck to be drawn)
            if (card) {
                // add card to mutable array
                [self.cards addObject:card];
            }
            else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

// constant OR use #define MISMATCH_PENALTY 2
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
//static const int COST_TO_CHOOSE = 1;

// most important logic, where matching and scoring happens
- (void)chooseCardAtIndex:(NSUInteger)index
{

    for (Card *otherCard in self.cards) {
        if (!otherCard.isChosen || otherCard.isMatched) {
            [self.chosenCards removeObject:otherCard];
        }
    }

    Card *card = [self cardAtIndex:index];

    // if card is NOT matched
    if (!card.isMatched) {
        // if card is NOT chosen
        if (card.isChosen) {
            // chosen is name of property, isChosen is name of getter
            card.chosen = NO;
            [self.chosenCards removeObject:card];
        }
        else {
            // create an array to store chosen cards
            NSMutableArray *otherChosenCards = [[NSMutableArray alloc] init];
            [self.chosenCards addObject:card];
            for (Card *otherCard in self.cards) {
                // if another card is chosen and has not been matched
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [otherChosenCards addObject:otherCard];
                }
            }
            // if the number of currently chosen unmatched cards matches the number of cards that have to be matched
            // minus 1 because the otherChosenCards doesn't include the currently selected card
            if ([otherChosenCards count] == self.numberOfCardsMatchMode - 1) {
                self.lastScore = 0;
                [self.chosenCards arrayByAddingObjectsFromArray:otherChosenCards];
                int matchScore = [card match:otherChosenCards];
                // match: returns 0 if no match, so if matchScore is valid, there's a match
                if (matchScore) {
                    self.lastScore = matchScore * MATCH_BONUS;
                    self.score += self.lastScore;
                    for (Card *otherCard in otherChosenCards) {
                        otherCard.matched = YES;
                    }
                    card.matched = YES;
                }
                else {
                    self.lastScore = -MISMATCH_PENALTY;
                    self.score +=  self.lastScore;
                    for (Card *otherCard in otherChosenCards) {
                        otherCard.chosen = NO;
                    }
                }
            }
//            // cost to choose so that user can't just flip over all cards to memorize
//            self.score -= COST_TO_CHOOSE;
            // card is still chosen even though not matched
            card.chosen = YES;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    // to protect against invalid index
    // if index < count, assign index to card, else nil
    return (index < [self.cards count]) ? self.cards[index]: nil;
}

@end
