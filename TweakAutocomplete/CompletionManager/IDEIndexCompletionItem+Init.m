//
//  IDEIndexCompletionItem+Init.m
//  TweakAutocomplete
//
//  Created by Jobs on 16/5/20.
//  Copyright © 2016年 Jobs. All rights reserved.
//

#import "IDEIndexCompletionItem+Init.h"

@implementation IDEIndexCompletionItem (Init)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
        for (NSString *key in dictionary) {
            
            id value = dictionary[key];
            
            if ([key isEqualToString:@"completionText"]) {
                
                value = [value stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
                
            } else if ([key isEqualToString:@"descriptionText"]) {
                
                value = [[NSAttributedString alloc] initWithString:value];
                
            } else if ([key isEqualToString:@"symbolKind"]) {
                
                if ([value length] == 0) {
                    value = @"Xcode.SourceCodeSymbolKind.Callable";
                }
                value = [DVTSourceCodeSymbolKind sourceCodeSymbolKindForIdentifier:value];
            }
            
            [self setValue:value forKey:key];
        }
    }
    
    return self;
}

@end
