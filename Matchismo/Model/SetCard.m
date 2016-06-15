//
//  SetCard.m
//  Matchismo
//
//  Created by Candance Smith on 6/14/16.
//  Copyright © 2016 candance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCard.h"

@implementation SetCard

// overwriting match method in Card
- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    // Have to match 3 cards total
    if ([otherCards count] == 2) {
        id card1 = [otherCards firstObject];
        id card2 = [otherCards lastObject];
        // making sure card1 and card2 are SetCard so program won't crash
        if ([card1 isKindOfClass:[SetCard class]] && [card2 isKindOfClass:[SetCard class]]) {
            SetCard *otherCard1 = (SetCard *)card1;
            SetCard *otherCard2 = (SetCard *)card2;
//            if ([self.symbol isEqualToString:otherCard1.symbol] && [self.symbol isEqualToString:otherCard2.symbol]) {
//                score = 2;
//            }
//            else if ([self.suit isEqualToString:otherCard1.suit] || [self.suit isEqualToString:otherCard2.suit] || [otherCard1.suit isEqualToString:otherCard2.suit]) {
//                score = 1;
//            }
//            else if (self.rank == otherCard1.rank && self.rank == otherCard2.rank) {
//                score = 8;
//            }
//            else if (self.rank == otherCard1.rank || self.rank == otherCard2.rank || otherCard1.rank == otherCard2.rank) {
//                score = 4;
//            }
        }
    }
    return score;
}

+ (NSArray *)validSymbols {
    return @[@"●",@"▲",@"◼︎"];
}

+ (NSArray *)validColors {
    return @[[UIColor redColor],[UIColor greenColor],[UIColor purpleColor]];
}

+ (NSArray *)validShadings {
    return @[@1,@0.4,@0];
}

+ (NSArray *)validNumberOfSymbols {
    return @[@1,@2,@3];
}

@end
