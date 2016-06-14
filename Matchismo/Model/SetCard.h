//
//  SetCard.h
//  Matchismo
//
//  Created by Candance Smith on 6/14/16.
//  Copyright © 2016 candance. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSNumber *shading;
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) NSNumber *numberOfSymbols;

+ (NSArray *)validSymbols;
+ (NSArray *)validColors;
+ (NSArray *)validShadings;
+ (NSArray *)validNumberOfSymbols;

@end
