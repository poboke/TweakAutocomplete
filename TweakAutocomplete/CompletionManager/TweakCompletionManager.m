//
//  TweakCompletionManager.m
//  TweakAutocomplete
//
//  Created by Jobs on 16/5/20.
//  Copyright © 2016年 Jobs. All rights reserved.
//

#import "TweakCompletionManager.h"
#import "IDEIndexCompletionItem+Init.h"
#import "Objective-Zip.h"

@implementation TweakCompletionManager

- (instancetype)init
{
    if (self = [super init]) {
    }
    
    return self;
}


- (NSMutableArray *)allCompletionItems
{
    if (!_allCompletionItems) {
        NSArray *array = [self.logosCompletionItems arrayByAddingObjectsFromArray:self.objcCompletionItems];
        _allCompletionItems = [array mutableCopy];
    }
    
    return _allCompletionItems;
}


#pragma mark - Logos Syntax Completion

- (NSMutableArray *)logosCompletionItems
{
    if (!_logosCompletionItems) {
        _logosCompletionItems = [NSMutableArray array];
        NSDictionary *dictionary = [self dictionaryWithPlistFileName:@"LogosSyntaxCompletion"];
        for (NSString *key in dictionary) {
            NSArray *items = [dictionary[key] allValues];
            for (NSDictionary *item in items) {
                IDEIndexCompletionItem *completionItem = [[IDEIndexCompletionItem alloc] initWithDictionary:item];
                [_logosCompletionItems addObject:completionItem];
            }
        }
    }
    
    return _logosCompletionItems;
}


- (NSDictionary *)dictionaryWithPlistFileName:(NSString *)fileName
{
    NSBundle *pluginBundle = [NSBundle bundleForClass:[self class]];
    NSString *filePath = [pluginBundle pathForResource:fileName ofType:@"plist"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dictionary;
}


#pragma mark - Objective-C Syntax Completion

- (NSMutableArray *)objcCompletionItems
{
    if (!_objcCompletionItems) {
        _objcCompletionItems = [NSMutableArray array];
        NSArray *items =  [self arrayWithZipFileName:@"ObjcSyntaxCompletion"];
        for (NSDictionary *item in items) {
            IDEIndexCompletionItem *completionItem = [[IDEIndexCompletionItem alloc] initWithDictionary:item];
            [_objcCompletionItems addObject:completionItem];
        }
    }
    
    return _objcCompletionItems;
}


- (NSArray *)arrayWithZipFileName:(NSString *)fileName
{
    NSBundle *pluginBundle = [NSBundle bundleForClass:[self class]];
    NSString *filePath = [pluginBundle pathForResource:fileName ofType:@"zip"];
    
    OZZipFile *unzipFile = [[OZZipFile alloc] initWithFileName:filePath mode:OZZipFileModeUnzip];
    [unzipFile goToFirstFileInZip];
    OZFileInZipInfo *info = [unzipFile getCurrentFileInZipInfo];
    
    OZZipReadStream *read = [unzipFile readCurrentFileInZip];
    NSMutableData *data = [[NSMutableData alloc] initWithLength:info.length];
    [read readDataWithBuffer:data];
    [read finishedReading];
    
    if (!data) {
        return @[];
    }
    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    return array;
}

@end
