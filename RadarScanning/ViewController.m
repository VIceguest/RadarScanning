//
//  ViewController.m
//  RadarScanning
//
//  Created by Jiang on 16/2/22.
//  Copyright © 2016年 Jiang Bin. All rights reserved.
//

#import "ViewController.h"
#import "VIGRadarView.h"

@interface ViewController ()

@property (nonatomic, strong) VIGRadarView *radarView;

@end

@implementation ViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_cloud.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)onStartScanButtonTouchUpInside:(id)sender {
    [self.radarView start];
}

- (IBAction)onStopScanButtonTouchUpInside:(id)sender {
    [self.radarView stop];
}

#pragma mark - Getter and Setter

-(VIGRadarView *)radarView {
    if (!_radarView) {
        CGRect parentFrame = self.view.frame;
        _radarView = [[VIGRadarView alloc] initWithFrame:CGRectMake(0, 50, parentFrame.size.width, parentFrame.size.height -50)];
        _radarView.scanSpeed = 0.5;
        [self.view addSubview:_radarView];
    }
    return _radarView;
}

@end
