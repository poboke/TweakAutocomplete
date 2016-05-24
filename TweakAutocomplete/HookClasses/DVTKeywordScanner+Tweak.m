//
//  DVTKeywordScanner+Tweak.m
//  TweakAutocomplete
//
//  Created by Jobs on 16/5/20.
//  Copyright © 2016年 Jobs. All rights reserved.
//

#import "DVTKeywordScanner+Tweak.h"

@implementation DVTKeywordScanner (Tweak)

+ (void)tweak_hook
{
    [self jr_swizzleMethod:@selector(initWithPropertyListDictionary:language:)
                withMethod:@selector(tweak_initWithPropertyListDictionary:language:)
                     error:nil];
}


- (instancetype)tweak_initWithPropertyListDictionary:(NSDictionary *)dictionary language:(NSInteger)language
{
    // Add `%` character to the start chars.
    if (TweakAutocompletePlugin.isEdittingTweakFile) {
        if ([dictionary[@"Type"] isEqualToString:@"xcode.syntax.keyword"]) {
            NSString *startChars = dictionary[@"StartChars"];
            if (startChars) {
                startChars = [startChars stringByAppendingString:LogosSyntaxStartCharString];
                [dictionary setValue:startChars forKey:@"StartChars"];
            }
        }
    }
    
    return [self tweak_initWithPropertyListDictionary:dictionary language:language];
}

@end
