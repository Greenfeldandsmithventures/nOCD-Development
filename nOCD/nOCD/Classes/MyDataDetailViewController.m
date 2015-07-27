//
//  MyDataDetailViewController.m
//  nOCD
//
//  Created by Admin on 7/7/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "MyDataDetailViewController.h"

@interface MyDataDetailViewController ()<PNChartDelegate> {
    
    __weak IBOutlet UIButton *btnViewSpecifics;
    __weak IBOutlet MDPopupButton *btnFilterType;
    __weak IBOutlet MDPopupButton *btnFilterDate;
    __weak IBOutlet PNBarChart *barChart;
}

@end

@implementation MyDataDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureViews {
    [self createRightButton];
    
    btnViewSpecifics.layer.borderColor = [UIColor whiteColor].CGColor;
    btnViewSpecifics.layer.borderWidth = 2.0f;
    btnViewSpecifics.layer.cornerRadius = 5.0f;
    
    [btnFilterDate setTitle:@"BY DAY" forState:UIControlStateNormal rightImage:[UIImage imageNamed:@"btnBottom"]];
    
    barChart.backgroundColor = [UIColor clearColor];
    barChart.yLabelFormatter = ^(CGFloat yValue){
        CGFloat yValueParsed = yValue;
        NSString * labelText = [NSString stringWithFormat:@"%0.f",yValueParsed];
        return labelText;
    };
    barChart.labelMarginTop = 20.0;
    barChart.showChartBorder = NO;
    barChart.showLabel = YES;
    barChart.chartMargin = 44.0f*deviceScale;
    barChart.barWidth = 56.0f;
    barChart.yChartLabelWidth = 20.0f;
    barChart.barRadius = 0.0f;
    barChart.barBackgroundColor = [UIColor clearColor];
    barChart.labelFont = [UIFont fontWithName:@"GothamBold" size:9.0f*deviceScale];
    [barChart setXLabels:@[@"OBSESSION",@"NOT SURE",@"COMPULSION"]];
    barChart.yLabels = @[@0,@1,@2,@3,@4,@5];
    [barChart setYValues:@[@5.0,@1.0,@3.0]];
    [barChart setStrokeColors:@[UIColorFromRGB(0x1fbba6),UIColorFromRGB(0xf27935),UIColorFromRGB(0x14b9d6)]];
    barChart.isGradientShow = NO;
    barChart.isShowNumbers = NO;
    
    [barChart strokeChart];
    
    barChart.delegate = self;
}
@end
