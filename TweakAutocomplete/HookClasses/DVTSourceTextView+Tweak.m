//
//  DVTSourceTextView+Tweak.m
//  TweakAutocomplete
//
//  Created by Jobs on 16/5/20.
//  Copyright © 2016年 Jobs. All rights reserved.
//

#import "DVTSourceTextView+Tweak.h"

@implementation DVTSourceTextView (Tweak)

+ (void)tweak_hook
{
    [self jr_swizzleMethod:@selector(shouldAutoCompleteAtLocation:)
                withMethod:@selector(tweak_shouldAutoCompleteAtLocation:)
                     error:NULL];
}


- (BOOL)tweak_shouldAutoCompleteAtLocation:(NSInteger)location
{
    // Should autocomplete when pressing `%` key.
    if (TweakAutocompletePlugin.isEdittingTweakFile) {
        NSInteger index = MAX((location - 1), 0);
        unichar character = [self.textStorage.string characterAtIndex:index];
        if (character == LogosSyntaxStartChar) {
            return YES;
        }
    }
    
    return [self tweak_shouldAutoCompleteAtLocation:location];
}

@end
