//
//  LanguageManager.m
//  ios_language_manager
//
//  Created by Maxim Bilan on 12/23/14.
//  Copyright (c) 2014 Maxim Bilan. All rights reserved.
//

#import "LanguageManager.h"

static NSString * const LanguageCodes[] = { @"en", @"de", @"fr"};
static NSString * const LanguageStrings[] = {@"English", @"German", @"French"};
static NSString * const LanguageSaveKey = @"currentLanguageKey";

@implementation LanguageManager

+ (void)setupCurrentLanguage
{
    NSString *currentLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:LanguageSaveKey];
    if (!currentLanguage) {
        NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        if (languages.count > 0) {
            currentLanguage = languages[0];
            [[NSUserDefaults standardUserDefaults] setObject:currentLanguage forKey:LanguageSaveKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:@[currentLanguage] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSArray *)languageStrings
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < ELanguageCount; ++i) {
        [array addObject:NSLocalizedString(LanguageStrings[i], @"")];
    }
    return [array copy];
}

+ (NSString *)currentLanguageString
{
    NSString *string = @"";
    NSString *currentCode = [[NSUserDefaults standardUserDefaults] objectForKey:LanguageSaveKey];
    for (NSInteger i = 0; i < ELanguageCount; ++i) {
        if ([currentCode isEqualToString:LanguageCodes[i]]) {
            string = NSLocalizedString(LanguageStrings[i], @"");
            break;
        }
    }
    return string;
}

+ (NSInteger)currentLanguageIndex
{
    NSInteger index = 0;
    NSString *currentCode = [[NSUserDefaults standardUserDefaults] objectForKey:LanguageSaveKey];
    for (NSInteger i = 0; i < ELanguageCount; ++i) {
        if ([currentCode isEqualToString:LanguageCodes[i]]) {
            index = i;
            break;
        }
    }
    return index;
}

+ (void)saveLanguageByIndex:(NSInteger)index
{
    if (index >=0 && index < ELanguageCount) {
        NSString *code = LanguageCodes[index];
        [[NSUserDefaults standardUserDefaults] setObject:code forKey:LanguageSaveKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
