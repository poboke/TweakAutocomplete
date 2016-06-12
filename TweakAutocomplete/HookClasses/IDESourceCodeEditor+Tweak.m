//
//  IDESourceCodeEditor+Tweak.m
//  TweakAutocomplete
//
//  Created by Jobs on 16/5/20.
//  Copyright © 2016年 Jobs. All rights reserved.
//

#import "IDESourceCodeEditor+Tweak.h"
#import "IDESourceCodeDocument+Tweak.h"

@implementation IDESourceCodeEditor (Tweak)

+ (void)tweak_hook
{
    [self jr_swizzleMethod:@selector(didSetupEditor)
                withMethod:@selector(tweak_didSetupEditor)
                     error:NULL];
}


- (void)tweak_didSetupEditor
{
    [self tweak_didSetupEditor];
    
    BOOL isTweakFile = self.sourceCodeDocument.isTweakFile;
    TweakAutocompletePlugin.isEdittingTweakFile = isTweakFile;
}

@end
