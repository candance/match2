//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Candance Smith on 6/13/16.
//  Copyright © 2016 candance. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "CardMatchingGame.h"


@implementation SetCardGameViewController

- (Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.game.numberOfCardsMatchMode = 3;
}


//    NSAttributedString *attributedString = [NSAttributedString alloc] initWithString:@"" attributes:<#(nullable NSDictionary<NSString *,id> *)#>

@end
