//
//  PlayingCard.m
//  Matchismo
//
//  Created by Candance Smith on 5/16/16.
//  Copyright © 2016 candance. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

// overwriting match method in Card
- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    // in 2-card match mode
    if ([otherCards count] == 1) {
        // firstObject returns first object in an array, if array is empty, returns nil
        PlayingCard *otherCard = [otherCards firstObject];
        if ([self.suit isEqualToString:otherCard.suit]) {
            score = 1;
        }
        else if (self.rank == otherCard.rank) {
            score = 4;
        }
    }
    // in 3-card match mode
    else if ([otherCards count] == 2) {
        // firstObject returns first object in an array, if array is empty, returns nil
        PlayingCard *otherCard1 = [otherCards firstObject];
        PlayingCard *otherCard2 = [otherCards lastObject];
        if ([self.suit isEqualToString:otherCard1.suit] && [self.suit isEqualToString:otherCard2.suit]) {
            score = 2;
        }
        else if ([self.suit isEqualToString:otherCard1.suit] || [self.suit isEqualToString:otherCard2.suit] || [otherCard1.suit isEqualToString:otherCard2.suit]) {
            score = 1;
        }
        else if (self.rank == otherCard1.rank && self.rank == otherCard2.rank) {
            score = 8;
        }
        else if (self.rank == otherCard1.rank || self.rank == otherCard2.rank || otherCard1.rank == otherCard2.rank) {
            score = 4;
        }
    }
    return score;
}

- (NSString *)contents {
    NSArray *rankStrings = PlayingCard.rankStrings;
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits {
    return @[@"♠️",@"♣️",@"♥️",@"♦️"];
}

- (void)setSuit:(NSString *)suit {
    if ([PlayingCard.validSuits containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank {
    return self.rankStrings.count - 1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= PlayingCard.maxRank) {
        _rank = rank;
    }
}
@end
