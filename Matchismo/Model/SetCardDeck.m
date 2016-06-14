//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Candance Smith on 6/14/16.
//  Copyright © 2016 candance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init {
    
    //to make sure Deck init doesn't fail
    self = [super init];
    
    if (self) {
        for (NSString *symbol in SetCard.validSymbols) {
            for (NSNumber *numberOfSymbols in SetCard.validNumberOfSymbols) {
                for (NSNumber *shading in SetCard.validShadings) {
                    for (UIColor *color in SetCard.validColors) {
                        SetCard *card = [[SetCard alloc] init];
                        card.symbol = symbol;
                        card.numberOfSymbols = numberOfSymbols;
                        card.shading = shading;
                        card.color = color;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
