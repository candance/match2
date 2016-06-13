//
//  ViewController.m
//  Matchismo
//
//  Created by Candance Smith on 5/16/16.
//  Copyright © 2016 candance. All rights reserved.
//

// Matchismo assignment 1 commented out

#import "ViewController.h"
#import "Deck.h"
#import "CardMatchingGame.h"

@interface ViewController ()

//@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
//@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeButton;
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

//// lazy instantiation
//- (Deck *)deck {
//    if (!_deck) {
//        _deck = [self createDeck];
//    }
//    return _deck;
//}

- (Deck *)createDeck { // abstract
    return nil;
}

//- (void)setFlipCount:(int)flipCount {
//    _flipCount = flipCount;
//    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
//    NSLog(@"flipCount changed to %d", self.flipCount);
//}

// if user touches match mode button
- (IBAction)gameMode:(UISegmentedControl *)sender {
    // if 3-card mode is selected
    if (self.modeButton.selectedSegmentIndex == 1) {
        NSLog(@"3-game selected");
        self.game.numberOfCardsMatchMode = 3;
    }
    else {
        NSLog(@"2-game selected");
        self.game.numberOfCardsMatchMode = 2;
    }
}

- (IBAction)touchCardButton:(UIButton *)sender {
//    // if title is non-zero (aka front is showing)
//    if ([sender.currentTitle length]) {
//        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
//                          forState:UIControlStateNormal];
//        [sender setTitle:@"" forState:UIControlStateNormal];
//        self.flipCount++;
//    }
//    else {
//        Card *drawCard = [self.deck drawRandomCard];
//        // if drawCard != nil
//        if (drawCard) {
//            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
//                              forState:UIControlStateNormal];
//            [sender setTitle:drawCard.contents forState:UIControlStateNormal];
//            self.flipCount++;
//            // flipCount does not increase after deck has all been shown
//        }
//    }
    
    // disable mode (2 or 3 card match) switching
    self.modeButton.enabled = NO;
    
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
    // enable mode (2 or 3 card match) switching
    self.modeButton.enabled = YES;
    // card match mode corresponds with currently selected segment
    [self gameMode:self.modeButton];
    [self updateUI];
    self.matchStatusLabel.text = @"Choose a card to start!";
}

@end
