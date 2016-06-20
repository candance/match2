//
//  SetCard.m
//  Matchismo
//
//  Created by Candance Smith on 6/14/16.
//  Copyright © 2016 candance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCard.h"

@interface SetCard()

@property (nonatomic) BOOL symbolMatch;
@property (nonatomic) BOOL colorMatch;
@property (nonatomic) BOOL numberMatch;
@property (nonatomic) BOOL shadeMatch;

@end

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
            
            // checking if symbols all match or all not match
            if ([self.symbol isEqualToString:otherCard1.symbol] && [self.symbol isEqualToString:otherCard2.symbol]) {
                self.symbolMatch = YES;
            }
            else if (![self.symbol isEqualToString:otherCard1.symbol] && ![self.symbol isEqualToString:otherCard2.symbol] && ![otherCard1.symbol isEqualToString:otherCard2.symbol]) {
                self.symbolMatch = YES;
            }
            else {
                self.symbolMatch = NO;
            }
            
            // checking if colors all match or all not match
            if ([self.color isEqual:otherCard1.color] && [self.color isEqual:otherCard2.color]) {
                self.colorMatch = YES;
            }
            else if (![self.color isEqual:otherCard1.color] && ![self.color isEqual:otherCard2.color] && ![otherCard1.color isEqual:otherCard2.color]) {
                self.colorMatch = YES;
            }
            else {
                self.colorMatch = NO;
            }
            
            // checking if numbers all match or all not match
            if ([self.numberOfSymbols isEqualToNumber:otherCard1.numberOfSymbols] && [self.numberOfSymbols isEqualToNumber:otherCard2.numberOfSymbols]) {
                self.numberMatch = YES;
            }
            else if (![self.numberOfSymbols isEqualToNumber:otherCard1.numberOfSymbols] && ![self.numberOfSymbols isEqualToNumber:otherCard2.numberOfSymbols] && ![otherCard1.numberOfSymbols isEqualToNumber:otherCard2.numberOfSymbols]) {
                self.numberMatch = YES;
            }
            else {
                self.numberMatch = NO;
            }
            
            // checking if shading all match or all not match
            if ([self.shading isEqualToNumber:otherCard1.shading] && [self.shading isEqualToNumber:otherCard2.shading]) {
                self.shadeMatch = YES;
            }
            else if (![self.shading isEqualToNumber:otherCard1.shading] && ![self.shading isEqualToNumber:otherCard2.shading] && ![otherCard1.shading isEqualToNumber:otherCard2.shading]) {
                self.shadeMatch = YES;
            }
            else {
                self.shadeMatch = NO;
            }
            
            // checking if all 4 conditions are fulfilled
            if ((self.symbolMatch) && (self.colorMatch) && (self.numberMatch) && (self.shadeMatch)) {
                score = 10;
            }
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
