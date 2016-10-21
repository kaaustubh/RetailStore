//
//  Utils.m
//  RetailStore
//
//  Created by Kaustubh on 21/10/16.
//  Copyright © 2016 Kaustubh. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(NSString*)getLocalCurrencyForPrice:(NSString*)price
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setLocale:[NSLocale currentLocale]];
    NSString *localizedMoneyString = [formatter stringFromNumber:[NSNumber numberWithInt:(int)price.integerValue]];
    return localizedMoneyString;
}

@end
