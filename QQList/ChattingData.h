//
//  ChattingData.h
//  QQList
//
//  Created by ly on 8/29/12.
//  Copyright (c) 2012 ly. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _ChattingCharacterType {
    
    ChattingCharacterMe,
    ChattingCharacterOther
    
} ChattingCharacterType;

@interface ChattingData : NSObject
{
    ChattingCharacterType _character;
    NSString *_words;
}

@property (nonatomic, readonly, assign) ChattingCharacterType character;
@property (nonatomic, readonly, retain) NSString *words;

- (id)initWithWords:(NSString *) newWords Character:(ChattingCharacterType) newCharacter;

@end
