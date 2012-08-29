//
//  ChattingData.m
//  QQList
//
//  Created by ly on 8/29/12.
//  Copyright (c) 2012 ly. All rights reserved.
//

#import "ChattingData.h"

@implementation ChattingData
@synthesize character = _character, words = _words;

- (id)initWithWords:(NSString *) newWords Character:(ChattingCharacterType) newCharacter
{
    self = [super init];
    if (self) {
        _words = [newWords retain];
        _character = newCharacter;
    }
    
    return self;
}

@end