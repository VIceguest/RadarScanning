//
//  UIColor+Hex.m
//  RadarScanning
//
//  Created by Jiang on 16/2/22.
//  Copyright © 2016年 Jiang Bin. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:alpha];
}

+ (UIColor *)colorWithHex:(UInt32)hex
{
    return [self colorWithHex:hex alpha:1.0];
}

+ (UIColor *)colorWithHexString:(id)hexString
{
    if (![hexString isKindOfClass:[NSString class]] || [hexString length] == 0) {
        return [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
    }
    
    const char *s = [hexString cStringUsingEncoding:NSASCIIStringEncoding];
    if (*s == '#') {
        ++s;
    }
    unsigned long long value = strtoll(s, nil, 16);
    int r, g, b, a;
    switch (strlen(s)) {
        case 2:
            // xx
            r = g = b = (int)value;
            a = 255;
            break;
        case 3:
            // RGB
            r = ((value & 0xf00) >> 8);
            g = ((value & 0x0f0) >> 4);
            b = ((value & 0x00f) >> 0);
            r = r * 16 + r;
            g = g * 16 + g;
            b = b * 16 + b;
            a = 255;
            break;
        case 6:
            // RRGGBB
            r = (value & 0xff0000) >> 16;
            g = (value & 0x00ff00) >>  8;
            b = (value & 0x0000ff) >>  0;
            a = 255;
            break;
        default:
            // RRGGBBAA
            r = (value & 0xff000000) >> 24;
            g = (value & 0x00ff0000) >> 16;
            b = (value & 0x0000ff00) >>  8;
            a = (value & 0x000000ff) >>  0;
            break;
    }
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.0f];
}

- (UInt32)hexValue {
    CGFloat r,g,b,a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    
    UInt32 ri = r*255.0;
    UInt32 gi = g*255.0;
    UInt32 bi = b*255.0;
    
    return (ri<<16) + (gi<<8) + bi;
}

@end
