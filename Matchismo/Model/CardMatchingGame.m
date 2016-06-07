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

@property (nonatomic, strong) NSMutableArray *cards; // of Card

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
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

// if user doesn't select game mode, default card match mode is 2
- (NSInteger)numberOfCardsMatchMode {
    if (!_numberOfCardsMatchMode) _numberOfCardsMatchMode = 2;
    return _numberOfCardsMatchMode;
}

// constant OR use #define MISMATCH_PENALTY 2
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
//static const int COST_TO_CHOOSE = 1;

// most important logic, where matching and scoring happens
- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    // if card is NOT matched
    if (!card.isMatched) {
        // if card is NOT chosen
        if (card.isChosen) {
            // chosen is name of property, isChosen is name of getter
            card.chosen = NO;
            self.matchStatus = @"";
        }
        else {
            self.matchStatus = card.contents;
            // create an array to store chosen cards
            NSMutableArray *currentChosenCards = [[NSMutableArray alloc] init];
            // create a mutable string to add current chosen cards for easy display
            NSMutableString *contentsCurrentChosenCards = [[NSMutableString alloc] init];
            for (Card *otherCard in self.cards) {
                // if another card is chosen and has not been matched
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [currentChosenCards addObject:otherCard];
                    [contentsCurrentChosenCards appendFormat:@"%@ ", otherCard.contents];
                    self.matchStatus = [[NSString stringWithFormat:@"One more card to match with %@ and ", card.contents] stringByAppendingString:contentsCurrentChosenCards];
                }
            }
            // if the number of currently chosen unmatched cards matches the number of cards that have to be matched
            // minus 1 because the currentChosenCards doesn't include the currently selected card
            if ([currentChosenCards count] == self.numberOfCardsMatchMode - 1) {
                int matchScore = [card match:currentChosenCards];
                // match: returns 0 if no match, so if matchScore is valid, there's a match
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    for (Card *otherCard in currentChosenCards) {
                        otherCard.matched = YES;
                        self.matchStatus = [[NSString stringWithFormat:@"%d point gain! Sucessfully matched %@", matchScore * MATCH_BONUS, card.contents] stringByAppendingString:contentsCurrentChosenCards];
                    }
                    card.matched = YES;
                }
                else {
                    self.score -= MISMATCH_PENALTY;
                    for (Card *otherCard in currentChosenCards) {
                        otherCard.chosen = NO;
                        self.matchStatus = [[NSString stringWithFormat:@"%d point penalty! Did not match %@", MISMATCH_PENALTY, card.contents] stringByAppendingString:contentsCurrentChosenCards];
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
