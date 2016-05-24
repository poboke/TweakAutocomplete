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
                     error:nil];
}


- (BOOL)tweak_shouldAutoCompleteAtLocation:(NSInteger)location
{
    // Should autocomplete when pressing `%` key.
    if (TweakAutocompletePlugin.isEdittingTweakFile) {
        unichar character = [self.textStorage.string characterAtIndex:(location - 1)];
        if (character == LogosSyntaxStartChar) {
            return YES;
        }
    }
    
    return [self tweak_shouldAutoCompleteAtLocation:location];
}

@end
