//
//  TestNSStringViewController.m
//  AGCategories
//
//  Created by JohnnyB0Y on 2018/12/28.
//  Copyright © 2018 JohnnyB0Y. All rights reserved.
//

#import "TestNSStringViewController.h"
#import "../../AGCategories/Categories/NSString/NSString+AGJudge.h"

@interface TestNSStringViewController ()

@end

@implementation TestNSStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *s1 = @"🙍🏿‍♀️🇨🇳𠧃😁哈ABN2@14fjsdk";
    NSString *s2 = @"e\u0301🌎"; // é🌎
    //NSString *s3 = @"\u01F1E8";
    
    // number
    NSString *numberError = @"数字字符判断错误！";
    NSAssert([s1 ag_containsNumberCharacter] == YES, numberError);
    NSAssert([s2 ag_containsNumberCharacter] == NO, numberError);
    NSAssert([s1 ag_lengthOfNumberCharacter] == 3, numberError);
    NSAssert([s2 ag_lengthOfNumberCharacter] == 0, numberError);
    
    
    // english
    NSString *englishError = @"英文字符判断错误！";
    NSAssert([s1 ag_containsEnglishCharacter] == YES, englishError);
    NSAssert([s2 ag_containsEnglishCharacter] == NO, englishError);
    NSAssert([s1 ag_lengthOfEnglishCharacter] == 8, englishError);
    NSAssert([s2 ag_lengthOfEnglishCharacter] == 0, englishError);
    
    
    // chinese
    
    
    
    // emoji
    NSString *emojiError = @"表情字符判断错误！";
    NSAssert([s1 ag_containsEmojiCharacter] == YES, emojiError);
    NSAssert([s2 ag_containsEmojiCharacter] == YES, emojiError);
    NSAssert([s1 ag_lengthOfEmojiCharacter] == 3, emojiError);
    NSAssert([s2 ag_lengthOfEmojiCharacter] == 1, emojiError);
    
    
    // length
    NSString *lengthError = @"字符长度判断错误！";
    NSAssert([s1 ag_lengthOfCharacter] == 17, lengthError);
    NSAssert([s2 ag_lengthOfCharacter] == 2, lengthError);
    NSAssert([s1 ag_isLengthOfCharacterInRange:NSMakeRange(0, 17)] == YES, lengthError);
    NSAssert([s1 ag_isLengthOfCharacterInRange:NSMakeRange(18, 19)] == NO, lengthError);
    
    NSAssert([s2 ag_isLengthOfCharacterInRange:NSMakeRange(2, 3)] == YES, lengthError);
    NSAssert([s2 ag_isLengthOfCharacterInRange:NSMakeRange(0, 1)] == NO, lengthError);
}

+ (instancetype)testNSStringViewController
{
    TestNSStringViewController *vc = [[TestNSStringViewController alloc] initWithNibName:NSStringFromClass(self) bundle:nil];
    return vc;
}

@end
