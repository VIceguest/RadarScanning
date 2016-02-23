//
//  VIGRadarView.m
//  RadarScanning
//
//  Created by Jiang on 16/2/22.
//  Copyright © 2016年 Jiang Bin. All rights reserved.
//

#import "VIGRadarView.h"

@interface VIGRadarView ()

@property (nonatomic, strong) UIImageView *radarImageView;
@property (nonatomic, strong) UILabel *startLoadingLabel;

@property (nonatomic, copy) NSArray *radiusArray;
@property (nonatomic, strong) NSMutableArray *threePointsArray;
@property (nonatomic, copy) NSString *myPointString;

@property (nonatomic, strong) UIImageView *floatingImageView;
@property (nonatomic, strong) UIImageView *triangleImageView;

@end

@implementation VIGRadarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureSelfView];
    }
    return self;
}

- (void)removeFromSuperview
{
    [self.radarImageView removeFromSuperview];
    self.radarImageView = nil;
}

#pragma mark - Configure

- (void)configureSelfView
{
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.15f];
    [self configureRadiusArray];
}

- (void)configureRadiusArray
{
    if (!self.radiusArray) {
        self.radiusArray = @[
                             @64,
                             @106,
                             @155
                             ];
    }
}

-(UIImageView *)radarImageView
{
    if (!_radarImageView) {
        _radarImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _radarImageView.backgroundColor = [UIColor clearColor];
        _radarImageView.image = [UIImage imageNamed:@"scanPartCircle"];
        [_radarImageView setContentMode:UIViewContentModeCenter];
        [self addSubview:_radarImageView];
    }
    return _radarImageView;
}

-(UILabel *)startLoadingLabel
{
    if (!_startLoadingLabel) {
        NSString *labelText = @"正在搜索...";
        CGFloat labelWidth = [self characterWidth:labelText withFont:[UIFont systemFontOfSize:11]];
        
        _startLoadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, 20)];
        _startLoadingLabel.center = self.radarImageView.center;
        _startLoadingLabel.textAlignment = NSTextAlignmentCenter;
        _startLoadingLabel.backgroundColor = [UIColor clearColor];
        _startLoadingLabel.textColor = [UIColor whiteColor];
        _startLoadingLabel.font = [UIFont systemFontOfSize:11];
        _startLoadingLabel.text = labelText;
        [self addSubview:_startLoadingLabel];
    }
    return _startLoadingLabel;
}

- (void)removeStartLoadingLabel
{
    if (self.startLoadingLabel) {
        [self.startLoadingLabel removeFromSuperview];
        self.startLoadingLabel = nil;
    }
}

- (void)dispatchAllPoint
{
    UIImage *myImage = [UIImage imageNamed:@"me"];
    UIImageView *myLocationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 27, 27)];
    myLocationImageView.center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
    myLocationImageView.image = myImage;
    [self addSubview:myLocationImageView];
    
    NSString *meString = @"我的位置";
    
    UILabel *meLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                 0,
                                                                 [self characterWidth:meString withFont:[UIFont systemFontOfSize:9]],
                                                                 [self characterHeight:meString withFont:[UIFont systemFontOfSize:9]])];
    meLabel.center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2 + 26);
    meLabel.backgroundColor = [UIColor clearColor];
    meLabel.font = [UIFont systemFontOfSize:9];
    meLabel.textAlignment = NSTextAlignmentCenter;
    meLabel.text = @"我的位置";
    meLabel.textColor = [UIColor whiteColor];
    [self addSubview:meLabel];
    
    [self dispatchAnotherPoints];
}

- (void)dispatchAnotherPoints
{
    NSMutableArray *tempArray = [NSMutableArray new];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [UIImage imageNamed:@"other"];
        
        
        CGFloat angle = arc4random()%360;
        

        CGFloat fixedAngle = angle/360 * (M_PI * 2);
        
        if (i == 3 - 1) {
            if (fixedAngle >= 3 * M_PI_4 && fixedAngle <= 5 * M_PI_4) {
                fixedAngle = 6 * M_PI_4;
            }else if (fixedAngle >= 7 * M_PI_4 && fixedAngle <= 8 * M_PI_4){
                fixedAngle = 2 * M_PI_4;
            } else if (fixedAngle >=0 && fixedAngle <= M_PI_4){
                fixedAngle = 2 * M_PI_4;
            }
        }
        
        CGFloat X = CGRectGetWidth(self.bounds)/2 + ([self.radiusArray[i] floatValue]*cos(fixedAngle));
        CGFloat Y = CGRectGetHeight(self.bounds)/2 + ([self.radiusArray[i] floatValue]*sin(fixedAngle));
        
        
        imageView.center = CGPointMake(X, Y);
        
        NSString *point = NSStringFromCGPoint(imageView.center);
        [tempArray addObject:point];
        
        
        [self addSubview:imageView];
        
        NSString *subTitleText = @"";
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   [self characterWidth:subTitleText withFont:[UIFont systemFontOfSize:9]],
                                                                   [self characterHeight:subTitleText withFont:[UIFont systemFontOfSize:9]])];
        label.center = CGPointMake(imageView.center.x,
                                   imageView.center.y + 10 + [self characterHeight:subTitleText withFont:[UIFont systemFontOfSize:9]]/2 + 8);
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:9];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.text = subTitleText;
        [self addSubview:label];
    }
    
    self.threePointsArray = tempArray;

    if(self.threePointsArray.count > 0)
    {
        NSInteger count = [self.threePointsArray count];
        NSInteger index = rand() % count;
        
        if(index >= 0 && index < count)
        {
            [self configureTagImageViewWithIndex:index andPoint:CGPointFromString(self.threePointsArray[index])];
        }
    }
}

- (void)configureTagImageViewWithIndex:(NSInteger)index andPoint:(CGPoint)point
{
    [self configureTriangleImageView];
    
    self.triangleImageView.center = CGPointMake(point.x, point.y - 13);
    [self addSubview:self.triangleImageView];
    
    if (point.x > ((CGRectGetWidth(self.bounds) - CGRectGetWidth(self.floatingImageView.frame)/2) - 8)) {
        self.floatingImageView.center = CGPointMake(((CGRectGetWidth(self.bounds) - CGRectGetWidth(self.floatingImageView.frame)/2) - 8), point.y - CGRectGetHeight(self.floatingImageView.frame)/2 - 13 - 3);
    } else if (point.x < (CGRectGetWidth(self.floatingImageView.frame)/2 + 8)){
        self.floatingImageView.center = CGPointMake((CGRectGetWidth(self.floatingImageView.frame)/2 + 8), point.y - CGRectGetHeight(self.floatingImageView.frame)/2 - 13 - 3);
    } else {
        self.floatingImageView.center = CGPointMake(point.x, point.y - CGRectGetHeight(self.floatingImageView.frame)/2 -13 - 3);
    }
    [self addSubview:self.floatingImageView];
}

- (void)configureTriangleImageView
{
    if (!self.triangleImageView) {
        self.triangleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8.5, 7)];
        self.triangleImageView.backgroundColor = [UIColor clearColor];
        self.triangleImageView.image = [UIImage imageNamed:@"fukuang-1"];
    }
}

#pragma mark - calucate

- (CGSize)characterSize:(NSString *)string withFont:(UIFont *)font
{
    CGSize size = [string sizeWithAttributes:@{
                                               NSFontAttributeName:font
                                               }];
    return CGSizeMake(size.width + 16, size.height + 8);
}

- (CGFloat)characterHeight:(NSString *)string withFont:(UIFont *)font
{
    CGSize size = [string sizeWithAttributes:@{
                                               NSFontAttributeName:font
                                               }];
    return size.height;
}

- (CGFloat)characterWidth:(NSString *)string withFont:(UIFont *)font
{
    CGSize size = [string sizeWithAttributes:@{
                                               NSFontAttributeName:font
                                               }];
    return size.width;
}

#pragma mark - Public

- (void)start
{
    [self removeFromSuperview];
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = @0.0f;
    rotationAnimation.toValue = @(2 * M_PI);
    rotationAnimation.speed = self.scanSpeed;
    rotationAnimation.duration = 1.0;
    rotationAnimation.repeatCount = HUGE_VALF;
    
    [self.radarImageView.layer addAnimation:rotationAnimation forKey:@"radarAnimation"];
}

- (void)stop
{
    [self.radarImageView.layer removeAnimationForKey:@"radarAnimation"];
    [self.radarImageView setImage:[UIImage imageNamed:@"scanCircle"]];
    
    [self removeStartLoadingLabel];
    [self dispatchAllPoint];
}

- (void)reset{
    [self.radarImageView.layer removeAnimationForKey:@"radarAnimation"];
    
    [self removeFromSuperview];
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self.radarImageView setImage:[UIImage imageNamed:@"scanPartCircle"]];
}

- (void)resetRadarImageViewImage:(UIImage *)image
{
    if (self.radarImageView) {
        self.radarImageView.image = image;
    }
}

@end

