//
//  JXHIphoneTF.m
//  PickerView
//
//  Created by mac on 2016/10/20.
//  Copyright © 2016年 JXH. All rights reserved.
//

#import "JXHIphoneTF.h"
#import "NSString+Extension.h"
@implementation JXHIphoneTF


- (BOOL)valueChangeValueString:(NSString *)string shouldChangeCharactersInRange:(NSRange)range
{
    
    if (self.text.length == 13 && range.length == 0) {
        return NO;
    }
    
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    NSMutableString *mStr = [NSMutableString stringWithString:self.text];
    // 删减字符
    if(string.length == 0 && range.location < self.text.length) {
        NSString *removeTemp = [self.text substringWithRange:NSMakeRange(range.location, range.length)];
        
        NSString *removeTempFontier = @"";
        if(range.location >= 1) {
            removeTempFontier = [self.text substringWithRange:NSMakeRange(range.location - 1, range.length)];
        }
        if(![removeTemp isEqualToString:@" "]) {
            [mStr deleteCharactersInRange:NSMakeRange(range.location, range.length)];
            NSMutableString *tempMutableStr = [NSMutableString stringWithString:[mStr stringRemoveBlank]];
            
            if(tempMutableStr.length >= 4) {
                [tempMutableStr insertString:@" " atIndex:3];
            }
            if(tempMutableStr.length >= 9) {
                [tempMutableStr insertString:@" " atIndex:8];
            }
            
            [self setText:tempMutableStr];
        }
        
        // 判断当前位置往前一个字符是否为空格
        if([removeTempFontier isEqualToString:@" "]) {
            [self setTextRangeWithOffset:range.location - 1];
        } else {
            [self setTextRangeWithOffset:range.location];
        }
        return NO;
    }
    
    // 输入字符
    if(string.length >0) {
        [mStr deleteCharactersInRange:NSMakeRange(range.location, range.length)];
        NSUInteger location = range.location + 1;
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\\b"];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        if(location==1&&![string isEqualToString:@"1"]){
            return NO;
        }
        
        
        if(range.location == 3 || range.location == 8) {
            location += 1;
        }
        
        [mStr insertString:string atIndex:range.location];
        // 每次输入都先清除空格
        NSMutableString *noBlankString = [NSMutableString stringWithString:[mStr stringRemoveBlank]];
        
        // 插入空格
        if(noBlankString.length >= 4 && noBlankString.length < 8) {
            [noBlankString insertString:@" " atIndex:3];
        } else if(noBlankString.length > 7) {
            [noBlankString insertString:@" " atIndex:3];
            [noBlankString insertString:@" " atIndex:8];
        }
        [self setText:noBlankString];
        
        [self setTextRangeWithOffset:location];
        return NO;
    }
    return YES;
}

- (void)setTextRangeWithOffset:(NSUInteger)offset {
    UITextPosition* beginning = self.beginningOfDocument;
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:offset];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:offset];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

@end
