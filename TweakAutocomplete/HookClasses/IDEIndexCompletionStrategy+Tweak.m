//
//  IDEIndexCompletionStrategy+tweak.m
//  TweakAutocomplete
//
//  Created by Jobs on 16/5/20.
//  Copyright © 2016年 Jobs. All rights reserved.
//

#import "IDEIndexCompletionStrategy+tweak.h"

@implementation IDEIndexCompletionStrategy (tweak)

+ (void)tweak_hook
{
    [self jr_swizzleMethod:@selector(completionItemsForDocumentLocation:context:highlyLikelyCompletionItems:areDefinitive:)
                withMethod:@selector(tweak_completionItemsForDocumentLocation:context:highlyLikelyCompletionItems:areDefinitive:)
                     error:NULL];
}


- (NSMutableArray *)tweak_completionItemsForDocumentLocation:(id)location context:(NSDictionary *)context highlyLikelyCompletionItems:(id *)completionItems areDefinitive:(char *)areDefinitive
{
    if (TweakAutocompletePlugin.isEdittingTweakFile) {
        return TweakAutocompletePlugin.completionManager.allCompletionItems;
    } else {
        return [self tweak_completionItemsForDocumentLocation:location context:context highlyLikelyCompletionItems:completionItems areDefinitive:areDefinitive];
    }
}

@end

