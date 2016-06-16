//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Candance Smith on 6/13/16.
//  Copyright © 2016 candance. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "CardMatchingGame.h"

@interface SetCardGameViewController ()

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UILabel *matchStatusLabel;

@end


@implementation SetCardGameViewController

- (Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateUI];
}

- (void)updateUI {
    
    self.game.numberOfCardsMatchMode = 3;
    
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        // button is only enabled if card is not matched
        cardButton.enabled = !card.isMatched;
    }
    self.matchStatusLabel.text = [NSString stringWithFormat:@"%@", self.game.matchStatus];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
}

- (NSAttributedString *)titleForCard: (Card *)card {
    
    SetCard *setCard = (SetCard *)card;
    
    // convert NSNumber to CGFloat for setCard.shading
    NSNumber *shading = setCard.shading;
    CGFloat shade = [shading floatValue];
    NSAttributedString *contents = [[NSAttributedString alloc] initWithString:[self symbolWithNumber:card]
                                                                   attributes:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody],
                                                                                NSStrokeColorAttributeName: setCard.color,
                                                                                NSStrokeWidthAttributeName: @-5,
                                                                                NSForegroundColorAttributeName: [setCard.color colorWithAlphaComponent:shade]}];
    return contents;
}

- (NSString *)symbolWithNumber: (Card *)card {
    
    SetCard *setCard = (SetCard *)card;
    
    NSMutableArray *symbols = [[NSMutableArray alloc] init];
    
    // converting numberOfSymbols from NSNumber to int for for-loop
    int number = [setCard.numberOfSymbols intValue];
    for (int i = 0; i < number; i++) {
        [symbols addObject:setCard.symbol];
    }
    
    NSString *symbolAndNumber = [symbols componentsJoinedByString:@"\n"];
    return symbolAndNumber;
}

- (UIImage *)backgroundImageForCard: (Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"chosencard" : @"cardfront"];
}

@end
