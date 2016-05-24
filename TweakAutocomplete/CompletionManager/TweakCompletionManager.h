//
//  TweakCompletionManager.h
//  TweakAutocomplete
//
//  Created by Jobs on 16/5/20.
//  Copyright © 2016年 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDEIndexCompletionItem;

@interface TweakCompletionManager : NSObject

@property (nonatomic, strong) NSMutableArray<IDEIndexCompletionItem *> *logosCompletionItems;
@property (nonatomic, strong) NSMutableArray<IDEIndexCompletionItem *> *objcCompletionItems;
@property (nonatomic, strong) NSMutableArray<IDEIndexCompletionItem *> *allCompletionItems;

@end
