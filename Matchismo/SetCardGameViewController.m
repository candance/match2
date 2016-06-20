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

@property (strong, nonatomic) NSAttributedString *matchStatusUpdate;

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
}

- (NSAttributedString *)titleForCard: (Card *)card {
    
    SetCard *setCard = (SetCard *)card;
    
    // convert NSNumber to CGFloat for setCard.shading
    NSNumber *shading = setCard.shading;
    CGFloat shade = [shading floatValue];
    NSAttributedString *contents = [[NSAttributedString alloc] initWithString:[self symbolWithNumber:card symbolSeparator:@"\n"]
                                                                   attributes:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody],
                                                                                NSStrokeColorAttributeName: setCard.color,
                                                                                NSStrokeWidthAttributeName: @-5,
                                                                                NSForegroundColorAttributeName: [setCard.color colorWithAlphaComponent:shade]}];
    return contents;
}

- (NSString *)symbolWithNumber:(Card *)card symbolSeparator:(NSString *)symbolSeparator{
    
    SetCard *setCard = (SetCard *)card;
    
    NSMutableArray *symbols = [[NSMutableArray alloc] init];
    
    // converting numberOfSymbols from NSNumber to int for for-loop
    int number = [setCard.numberOfSymbols intValue];
    for (int i = 0; i < number; i++) {
        [symbols addObject:setCard.symbol];
    }
    
    NSString *symbolAndNumber = [symbols componentsJoinedByString:symbolSeparator];
    return symbolAndNumber;
}

- (UIImage *)backgroundImageForCard: (Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"chosencard" : @"cardfront"];
}

- (id)matchStatusWithCards:(NSArray *)cards {
    
    if (self.game.chosenCards.count == 1) {
        id card = [self.game.chosenCards firstObject];
        if ([card isKindOfClass:[SetCard class]]) {
            SetCard *chosenCard = (SetCard *)card;
            self.matchStatusUpdate = [[NSAttributedString alloc] initWithAttributedString:[self setCardContent:chosenCard]];
            return self.matchStatusUpdate;
        }
    }
    else if (self.game.chosenCards.count == 2) {
        id card1 = self.game.chosenCards[0];
        id card2 = self.game.chosenCards[1];
        if ([card1 isKindOfClass:[SetCard class]] && [card2 isKindOfClass:[SetCard class]]) {
            self.matchStatusUpdate = [[NSAttributedString alloc] initWithAttributedString: [self setOf2Cards]];
            return self.matchStatusUpdate;
        }
    }
    else if (self.game.chosenCards.count == 3) {
        id card1 = self.game.chosenCards[0];
        id card2 = self.game.chosenCards[1];
        id card3 = self.game.chosenCards[2];
        if ([card1 isKindOfClass:[SetCard class]] && [card2 isKindOfClass:[SetCard class]] && [card3 isKindOfClass:[SetCard class]]) {

            if (self.game.lastScore > 0) {
            
                self.matchStatusUpdate = [[NSAttributedString alloc] initWithAttributedString: [self winStatus]];
                return self.matchStatusUpdate;
            }
            else if (self.game.lastScore < 0) {

                self.matchStatusUpdate = [[NSAttributedString alloc] initWithAttributedString: [self loseStatus]];
                return self.matchStatusUpdate;
            }
        }
    }
    else {
        self.matchStatusUpdate = nil;
        return self.matchStatusUpdate;
    }
    return nil;
}

- (NSAttributedString *)setCardContent:(Card *)card {
    
    SetCard *setCard = (SetCard *)card;
    
    NSNumber *shading = setCard.shading;
    CGFloat shade = [shading floatValue];
    
    NSAttributedString *contents = [[NSAttributedString alloc] initWithString:[self symbolWithNumber:setCard symbolSeparator:@""]
                                    attributes:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody],
                                                 NSStrokeColorAttributeName: setCard.color,
                                                 NSStrokeWidthAttributeName: @-5,
                                                 NSForegroundColorAttributeName: [setCard.color colorWithAlphaComponent:shade]}];
    
    return contents;

}

- (NSAttributedString *)setOf2Cards {
    
    NSAttributedString *space = [[NSAttributedString alloc] initWithString:@" "];
    
    SetCard *card1 = self.game.chosenCards[0];
    NSMutableAttributedString *twoCardsContent = [[self setCardContent:card1] mutableCopy];
    SetCard *card2 = self.game.chosenCards[1];
    NSMutableAttributedString *card2Content = [[self setCardContent:card2] mutableCopy];

    [twoCardsContent appendAttributedString:space];
    [twoCardsContent appendAttributedString:card2Content];
    [twoCardsContent appendAttributedString:space];
    
    return twoCardsContent;
}

- (NSAttributedString *)setOf3Cards {

    NSMutableAttributedString *threeCardsContent = [[self setOf2Cards] mutableCopy];
    
    SetCard *card3 = self.game.chosenCards[2];
    NSMutableAttributedString *card3Content = [[self setCardContent:card3] mutableCopy];
    
    [threeCardsContent appendAttributedString:card3Content];
    
    return threeCardsContent;
}

- (NSAttributedString *)winStatus {
    
    NSString *scoreStatus = [NSString stringWithFormat:@"%ld point gain! \n Sucessfully matched ", (long)self.game.lastScore];
    
    NSMutableAttributedString *scoreStatuswithCards = [[NSMutableAttributedString alloc] initWithString:scoreStatus];
    [scoreStatuswithCards appendAttributedString:[self setOf3Cards]];
    
    return scoreStatuswithCards;
}

- (NSAttributedString *)loseStatus {
    
    NSString *scoreStatus = [NSString stringWithFormat:@"%ld point penalty! \n Did not match ", (long)self.game.lastScore];
    
    NSMutableAttributedString *scoreStatuswithCards = [[NSMutableAttributedString alloc] initWithString:scoreStatus];
    [scoreStatuswithCards appendAttributedString:[self setOf3Cards]];
    
    return scoreStatuswithCards;
}

@end
