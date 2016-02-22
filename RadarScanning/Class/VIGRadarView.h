//
//  VIGRadarView.h
//  RadarScanning
//
//  Created by Jiang on 16/2/22.
//  Copyright © 2016年 Jiang Bin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIGRadarView : UIView

@property (nonatomic, assign) CGFloat scanSpeed;

- (void)start;
- (void)stop;
- (void)reset;
- (void)resetRadarImageViewImage:(UIImage *)image;

@end
