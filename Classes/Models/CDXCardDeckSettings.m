//
//
// CDXCardDeckSettings.m
//
//
// Copyright (c) 2009-2010 Arne Harren <ah@0xc0.de>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "CDXCardDeckSettings.h"

#undef ql_component
#define ql_component lcl_cModel


enum {
    CDXCardDeckSettingsName,
    CDXCardDeckSettingsGroupSize,
    CDXCardDeckSettingsDeckDisplayStyle,
    CDXCardDeckSettingsCornerStyle,
    CDXCardDeckSettingsPageControl,
    CDXCardDeckSettingsPageControlStyle,
    CDXCardDeckSettingsPageJumps,
    CDXCardDeckSettingsAutoRotate,
    CDXCardDeckSettingsShakeAction,
    CDXCardDeckSettingsCount
};

static const CDXSetting settings[] = {
    { CDXCardDeckSettingsName, CDXSettingTypeText, @"Name" },
    { CDXCardDeckSettingsGroupSize, CDXSettingTypeEnumeration, @"Grouping" },
    { CDXCardDeckSettingsDeckDisplayStyle, CDXSettingTypeEnumeration, @"Deck Style" },
    { CDXCardDeckSettingsCornerStyle, CDXSettingTypeEnumeration, @"Corner Style" },
    { CDXCardDeckSettingsPageControl, CDXSettingTypeBoolean, @"Index Dots" },
    { CDXCardDeckSettingsPageControlStyle, CDXSettingTypeEnumeration, @"Index Style" },
    { CDXCardDeckSettingsPageJumps, CDXSettingTypeBoolean, @"Index Touches" },
    { CDXCardDeckSettingsAutoRotate, CDXSettingTypeBoolean, @"Auto Rotate" },
    { CDXCardDeckSettingsShakeAction, CDXSettingTypeEnumeration, @"Shake" },
    { 0, 0, @"" }
};

typedef struct {
    NSString *title;
    unsigned int settingsCount;
    unsigned int firstIndex;
} CDXCardDeckSettingGroup;

static const CDXCardDeckSettingGroup groups[] = {
    { @"", 2, CDXCardDeckSettingsName },
    { @"Appearance", 4, CDXCardDeckSettingsDeckDisplayStyle },
    { @"Events", 3, CDXCardDeckSettingsPageJumps },
    { @"", 0, 0 }
};


@implementation CDXCardDeckSettings

- (id)initWithCardDeck:(CDXCardDeck *)deck {
    if ((self = [super init])) {
        ivar_assign_and_retain(cardDeck, deck);
    }
    return self;
}

- (void)dealloc {
    ivar_release_and_clear(cardDeck);
    [super dealloc];
}

- (NSString *)title {
    return @"Deck Settings";
}

- (UIView *)titleView {
    return nil;
}

- (NSUInteger)numberOfGroups {
    return (sizeof(groups) / sizeof(CDXCardDeckSettingGroup)) - 1;
}

- (NSString *)titleForGroup:(NSUInteger)group {
    return groups[group].title;
}

- (NSUInteger)numberOfSettingsInGroup:(NSUInteger)group {
    return groups[group].settingsCount;
}

- (CDXSetting)settingAtIndex:(NSUInteger)index inGroup:(NSUInteger)group {
    unsigned int firstIndex = groups[group].firstIndex;
    return settings[firstIndex + index];
}

- (BOOL)booleanValueForSettingWithTag:(NSUInteger)tag {
    switch (tag) {
        default:
            return NO;
        case CDXCardDeckSettingsPageControl:
            return cardDeck.wantsPageControl;
        case CDXCardDeckSettingsPageJumps:
            return cardDeck.wantsPageJumps;
        case CDXCardDeckSettingsAutoRotate:
            return cardDeck.wantsAutoRotate;
    }
}

- (void)setBooleanValue:(BOOL)value forSettingWithTag:(NSUInteger)tag {
    switch (tag) {
        default:
            break;
        case CDXCardDeckSettingsPageControl:
            cardDeck.wantsPageControl = value;
            break;
        case CDXCardDeckSettingsPageJumps:
            cardDeck.wantsPageJumps = value;
            break;
        case CDXCardDeckSettingsAutoRotate:
            cardDeck.wantsAutoRotate = value;
            break;
    }
    [cardDeck updateStorageObjectDeferred:YES];
}

- (NSUInteger)enumerationValueForSettingWithTag:(NSUInteger)tag {
    switch (tag) {
        default:
            return 0;
        case CDXCardDeckSettingsDeckDisplayStyle:
            return (NSUInteger)cardDeck.displayStyle;
        case CDXCardDeckSettingsCornerStyle:
            return (NSUInteger)cardDeck.cornerStyle;
        case CDXCardDeckSettingsPageControlStyle:
            return cardDeck.pageControlStyle;
        case CDXCardDeckSettingsGroupSize:
            return cardDeck.groupSize;
        case CDXCardDeckSettingsShakeAction:
            return cardDeck.shakeAction;
    }
}

- (void)setEnumerationValue:(NSUInteger)value forSettingWithTag:(NSUInteger)tag {
    switch (tag) {
        default:
            break;
        case CDXCardDeckSettingsDeckDisplayStyle:
            cardDeck.displayStyle = value;
            break;
        case CDXCardDeckSettingsCornerStyle:
            cardDeck.cornerStyle = value;
            break;
        case CDXCardDeckSettingsPageControlStyle:
            cardDeck.pageControlStyle = value;
            break;
        case CDXCardDeckSettingsGroupSize:
            cardDeck.groupSize = value;
            break;
        case CDXCardDeckSettingsShakeAction:
            cardDeck.shakeAction = value;
            break;
    }
    [cardDeck updateStorageObjectDeferred:YES];
}

- (NSUInteger)enumerationValuesCountForSettingWithTag:(NSUInteger)tag {
    switch (tag) {
        default:
            return 0;
        case CDXCardDeckSettingsDeckDisplayStyle:
            return (NSUInteger)CDXCardDeckDisplayStyleCount;
        case CDXCardDeckSettingsCornerStyle:
            return (NSUInteger)CDXCardCornerStyleCount;
        case CDXCardDeckSettingsPageControlStyle:
            return (NSUInteger)CDXCardDeckPageControlStyleCount;
        case CDXCardDeckSettingsGroupSize:
            return (NSUInteger)CDXCardDeckGroupSizeCount;
        case CDXCardDeckSettingsShakeAction:
            return (NSUInteger)CDXCardDeckShakeActionCount;
    }
}

- (NSString *)descriptionForEumerationValue:(NSUInteger)value forSettingWithTag:(NSUInteger)tag {
    switch (tag) {
        default:
            return @"";
        case CDXCardDeckSettingsDeckDisplayStyle:
            switch (value) {
                default:
                case CDXCardDeckDisplayStyleSideBySide:
                    return @"Side-by-side (Scroll)";
                case CDXCardDeckDisplayStyleStack:
                    return @"Stacked (Scroll)";
                case CDXCardDeckDisplayStyleSwipeStack:
                    return @"Stacked (Swipe)";
            }
        case CDXCardDeckSettingsCornerStyle:
            switch (value) {
                default:
                case CDXCardCornerStyleRounded:
                    return @"Rounded";
                case CDXCardCornerStyleCornered:
                    return @"Cornered";
            }
        case CDXCardDeckSettingsPageControlStyle:
            switch (value) {
                default:
                case CDXCardDeckPageControlStyleLight:
                    return @"Light";
                case CDXCardDeckPageControlStyleDark:
                    return @"Dark";
            }
        case CDXCardDeckSettingsGroupSize: {
            if (value == CDXCardDeckGroupSizeNoGroups) {
                return @"Off";
            } else if (value == 1) {
                return @"1 Card";
            } else {
                return [NSString stringWithFormat:@"%d Cards", value];
            }
        }
        case CDXCardDeckSettingsShakeAction: {
            switch (value) {
                default:
                case CDXCardDeckShakeActionNone:
                    return @"Off";
                case CDXCardDeckShakeActionShuffle:
                    return @"Shuffle";
                case CDXCardDeckShakeActionRandom:
                    return @"Random";
            }
        }
    }
}

- (NSString *)textValueForSettingWithTag:(NSUInteger)tag {
    switch (tag) {
        default:
            return @"";
        case CDXCardDeckSettingsName:
            return cardDeck.name;
    }
}

- (void)setTextValue:(NSString *)value forSettingWithTag:(NSUInteger)tag {
    switch (tag) {
        default:
            break;
        case CDXCardDeckSettingsName:
            cardDeck.name = value;
            break;
    }
    [cardDeck updateStorageObjectDeferred:YES];
}

- (UIImage *)settingsImageForSettingWithTag:(NSUInteger)tag {
    return nil;
}

- (NSObject<CDXSettings> *)settingsSettingsForSettingWithTag:(NSUInteger)tag {
    return nil;
}

- (NSString *)urlActionURLForSettingWithTag:(NSUInteger)tag {
    return nil;
}

- (NSString *)htmlTextValueForSettingWithTag:(NSUInteger)tag {
    return nil;
}

@end

