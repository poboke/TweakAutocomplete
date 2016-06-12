//
//  DVTCompletingTextView+Tweak.m
//  TweakAutocomplete
//
//  Created by Jobs on 16/5/20.
//  Copyright © 2016年 Jobs. All rights reserved.
//

#import "DVTCompletingTextView+Tweak.h"

@implementation DVTCompletingTextView (Tweak)

+ (void)tweak_hook
{
    [self jr_swizzleClassMethod:@selector(identifierChars)
                withClassMethod:@selector(tweak_identifierChars)
                          error:NULL];
}


+ (NSMutableCharacterSet *)tweak_identifierChars
{
    NSMutableCharacterSet *chars = [self tweak_identifierChars];
    
    // Add `%` character to the autocomplete identifier chars.
    if (TweakAutocompletePlugin.isEdittingTweakFile) {
        [chars addCharactersInString:LogosSyntaxStartCharString];
    }
    
    return chars;
}

@end
