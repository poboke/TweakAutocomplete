//
//  TweakAutocomplete.m
//  TweakAutocomplete
//
//  Created by Jobs on 16/5/20.
//  Copyright © 2016年 Jobs. All rights reserved.
//

#import "TweakAutocomplete.h"

#import "IDESourceCodeEditor+Tweak.h"
#import "IDESourceCodeDocument+Tweak.h"
#import "IDEIndexCompletionStrategy+tweak.h"
#import "DVTSourceTextView+Tweak.h"
#import "DVTCompletingTextView+Tweak.h"
#import "DVTKeywordScanner+Tweak.h"

@interface TweakAutocomplete()
@end


@implementation TweakAutocomplete

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    // Load only into Xcode
    NSString *identifier = [NSBundle mainBundle].bundleIdentifier;
    if (![identifier isEqualToString:@"com.apple.dt.Xcode"]) {
        return;
    }
    
    [self sharedPlugin];
}


+ (instancetype)sharedPlugin
{
    static TweakAutocomplete *_sharedPlugin;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedPlugin = [[self alloc] init];
    });
    
    return _sharedPlugin;
}


- (instancetype)init
{
    if (self = [super init]) {
        
        _completionManager = [[TweakCompletionManager alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidFinishLaunching:) name:NSApplicationDidFinishLaunchingNotification object:nil];
    }
    
    return self;
}


- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    [self hookMethods];
}


- (void)hookMethods
{
    [IDESourceCodeEditor tweak_hook];
    [IDESourceCodeDocument tweak_hook];
    [IDEIndexCompletionStrategy tweak_hook];
    
    [DVTSourceTextView tweak_hook];
    [DVTCompletingTextView tweak_hook];
    [DVTKeywordScanner tweak_hook];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
