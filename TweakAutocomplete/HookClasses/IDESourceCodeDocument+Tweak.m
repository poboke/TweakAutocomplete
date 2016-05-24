//
//  IDESourceCodeDocument+Tweak.m
//  TweakAutocomplete
//
//  Created by Jobs on 16/5/20.
//  Copyright © 2016年 Jobs. All rights reserved.
//

#import "IDESourceCodeDocument+Tweak.h"

@implementation IDESourceCodeDocument (Tweak)

+ (void)tweak_hook
{
    [self jr_swizzleMethod:@selector(fileType)
                withMethod:@selector(tweak_fileType)
                     error:nil];
}


- (NSString *)tweak_fileType
{
    if (self.isTweakFile) {
        // Return Objective-C file type.
        return @"public.objective-c-source";
    } else {
        return [self tweak_fileType];
    }
}


- (BOOL)isTweakFile
{
    NSArray *tweakFileExtensions = @[@"x", @"xm", @"xi", @"xmi"];
    NSString *fileExtension = self.fileURL.pathExtension;
    return [tweakFileExtensions containsObject:fileExtension];
}

@end
