//
//  ViewController.m
//  Matchismo
//
//  Created by Candance Smith on 5/16/16.
//  Copyright © 2016 candance. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UILabel *matchStatusLabel;

@end

@implementation ViewController

#pragma mark: Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.matchStatusLabel.text = @"Welcome! Choose a card to start!";
    self.resetButton.layer.borderWidth = 0.5;
    self.resetButton.layer.cornerRadius = 5;
}

// lazy instantiation
- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck { // abstract
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
    
}

- (void)updateUI {
    
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


- (IBAction)resetGame:(UIButton *)sender {
    // to reset game, set game to nil (deletes everything) then update UI
    self.game = nil;
    [self updateUI];
    self.matchStatusLabel.text = @"Choose a card to start!";
}

@end
