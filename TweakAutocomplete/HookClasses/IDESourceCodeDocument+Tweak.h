//
//  IDESourceCodeDocument+Tweak.h
//  TweakAutocomplete
//
//  Created by Jobs on 16/5/20.
//  Copyright © 2016年 Jobs. All rights reserved.
//

#import "IDESourceCodeDocument.h"

@interface IDESourceCodeDocument (Tweak)

@property (nonatomic, assign, readonly) BOOL isTweakFile;

+ (void)tweak_hook;

@end
