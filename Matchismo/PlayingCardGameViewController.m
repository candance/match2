//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Candance Smith on 6/13/16.
//  Copyright © 2016 candance. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface PlayingCardGameViewController ()

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UILabel *matchStatusLabel;

@property (strong, nonatomic) NSString *matchStatusUpdate;

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)updateUI {
    
    self.game.numberOfCardsMatchMode = 2;
    
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        cardButton.titleLabel.font = [UIFont systemFontOfSize: 18];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        // button is only enabled if card is not matched
        cardButton.enabled = !card.isMatched;
    }
}

- (NSString *)titleForCard: (Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard: (Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (id)matchStatusWithCards:(NSArray *)cards {

    if (self.game.chosenCards.count == 1) {
        id card = [self.game.chosenCards firstObject];
        if ([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *chosenCard = (PlayingCard *)card;
            self.matchStatusUpdate = [NSString stringWithFormat:@"%@", chosenCard.contents];
            return self.matchStatusUpdate;
        }
    }
    else if (self.game.chosenCards.count == 2) {
        id card1 = [self.game.chosenCards firstObject];
        id card2 = [self.game.chosenCards lastObject];
        if ([card1 isKindOfClass:[PlayingCard class]] && [card2 isKindOfClass:[PlayingCard class]]) {
            PlayingCard *chosenCard1 = (PlayingCard *)card1;
            PlayingCard *chosenCard2 = (PlayingCard *)card2;
            
            if (self.game.lastScore > 0) {
                self.matchStatusUpdate = [NSString stringWithFormat:@"%ld point gain! Sucessfully matched %@%@", (long)self.game.lastScore, chosenCard1.contents, chosenCard2.contents];
                return self.matchStatusUpdate;
            }
            else if (self.game.lastScore < 0) {
                self.matchStatusUpdate = [NSString stringWithFormat:@"%ld point penalty! Did not match %@%@", (long)self.game.lastScore,chosenCard1.contents, chosenCard2.contents];
                return self.matchStatusUpdate;
            }
        }
    }
    else {
        self.matchStatusUpdate = nil;
        return self.matchStatusUpdate;
    }
    
//    if (self.game.card)
    
    return nil;
}


@end
