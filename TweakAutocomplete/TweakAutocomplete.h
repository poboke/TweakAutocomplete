//
//  TweakAutocomplete.h
//  TweakAutocomplete
//
//  Created by Jobs on 16/5/20.
//  Copyright © 2016年 Jobs. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "TweakCompletionManager.h"

@interface TweakAutocomplete : NSObject

@property (nonatomic, strong, readonly) TweakCompletionManager *completionManager;
@property (nonatomic, assign) BOOL isEdittingTweakFile;

+ (instancetype)sharedPlugin;

@end
