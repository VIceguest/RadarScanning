//
//  UIColor+Hex.h
//  RadarScanning
//
//  Created by Jiang on 16/2/22.
//  Copyright © 2016年 Jiang Bin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(UInt32)hex;
+ (UIColor *)colorWithHexString:(id)input;

- (UInt32)hexValue;

@end
