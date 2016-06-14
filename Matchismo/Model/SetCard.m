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

+ (NSArray *)validSymbols {
    return @[@"●",@"▲",@"◼︎"];
}

//- (void)setSymbol:(NSAttributedString *)symbol {
//    if ([SetCard.validSymbols containsObject:symbol]) {
//        _symbol = symbol;
//    }
//}

+ (NSArray *)validColors {
    return @[[UIColor redColor],[UIColor greenColor],[UIColor purpleColor]];
}

+ (NSArray *)validShadings {
    return @[@1,@0.5,@0.25];
}

+ (NSArray *)validNumberOfSymbols {
    return @[@1,@2,@3];
}

//
//
//- (NSString *)symbol {
//    return _symbol ? _symbol : @"?";
//}
//
//+ (NSArray *)rankStrings {
//    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
//}
//
//+ (NSUInteger)maxRank {
//    return self.rankStrings.count - 1;
//}
//
//- (void)setRank:(NSUInteger)rank {
//    if (rank <= PlayingCard.maxRank) {
//        _rank = rank;
//    }
//}
//
@end
