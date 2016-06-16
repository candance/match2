//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Candance Smith on 6/13/16.
//  Copyright © 2016 candance. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UILabel *matchStatusLabel;

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
    self.matchStatusLabel.text = [NSString stringWithFormat:@"%@", self.game.matchStatus];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
}

- (NSString *)titleForCard: (Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard: (Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
