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
    self.resetButton.layer.borderWidth = 1;
    self.resetButton.layer.borderColor = [UIColor whiteColor].CGColor;
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
    
    id matchStatus = [self matchStatusWithCards:self.game.chosenCards];
    
    if ([matchStatus isKindOfClass:[NSString class]]) {
        
        // PlayingCard display
        self.matchStatusLabel.text = (NSString *)matchStatus;
    }
    else if ([matchStatus isKindOfClass:[NSAttributedString class]]) {
        
        // SetCard display
        self.matchStatusLabel.attributedText = (NSAttributedString *)matchStatus;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
}

- (void)updateUI { //abstract
    nil;
}

- (id)matchStatusWithCards:(NSArray *)cards { //abstract
    return nil;
}

- (IBAction)resetGame:(UIButton *)sender {
    // to reset game, set game to nil (deletes everything) then update UI
    self.game = nil;
    [self updateUI];
    self.matchStatusLabel.text = @"Choose a card to start!";
}

@end
