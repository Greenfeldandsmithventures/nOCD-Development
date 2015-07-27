//
//  MyActivityViewController.m
//  nOCD
//
//  Created by Admin on 7/4/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "MyActivityViewController.h"

@interface MyActivityViewController ()<PNChartDelegate> {
    
    __weak IBOutlet UIView *viewFooter;
    __weak IBOutlet PNLineChart *lineChart;
    __weak IBOutlet MDPopupButton *btnTypeFilter;
    __weak IBOutlet MDPopupButton *btnFilter;
}

@end

@implementation MyActivityViewController

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
    [self createLeftButton];
    [self createRightButton];
    self.title = @"My Activity";
    
    [btnTypeFilter setTitle:@"All EPISODES" forState:UIControlStateNormal rightImage:[UIImage imageNamed:@"btnBottom"]];
    [btnFilter setTitle:@"BY DAY" forState:UIControlStateNormal rightImage:[UIImage imageNamed:@"btnBottom"]];
    
    [[AppManager sharedInstance] scaleFontSizes:viewFooter];
    
    [[AppManager sharedInstance] scaleFontSizes:lineChart];
    
    lineChart.yLabelFormat = @"%1.0f";
    lineChart.backgroundColor = [UIColor clearColor];
    
    lineChart.showCoordinateAxis = NO;
    lineChart.chartCavanWidth = screenWidth;
    //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    //Only if you needed
    lineChart.yFixedValueMax = 320.0;
    lineChart.yFixedValueMin = 0.0;
    lineChart.axisWidth = screenWidth;
    
    lineChart.xLabelColor = UIColorFromRGB(0x5e6d81);
    lineChart.xLabelFont = [UIFont fontWithName:@"GothamBold" size:11.0f*deviceScale];
    [lineChart setXLabels:@[@"MON",@"TUE",@"WED",@"THU",@"FRI",@"SAT",@"SUN"] withWidth:45.0f*deviceScale];
    
    [lineChart setYLabels:@[
                                 @"",
                                 @"",
                                 @"",
                                 @"",
                                 @"",
                                 @"",
                                 @"",
                                 ]
     ];
    
    // Line Chart #2
    NSArray * data02Array = @[@5.0, @160.1, @0.0, @320.0, @8.2, @127.2, @5.0];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.dataTitle = @"Beta";
    data02.color = UIColorFromRGB(0x8d96a3);
    data02.pointColor = PNGreen;
    data02.strokeColor = UIColorFromRGB(0xf6f6f6);
    data02.alpha = 1.0f;
    data02.lineWidth = 2.5f*deviceScale;
    data02.itemCount = data02Array.count;
    data02.inflexionPointStyle = PNLineChartPointStyleCircle;
    data02.inflexionPointWidth = 17.0f*deviceScale;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChart.chartData = @[data02];
    [lineChart strokeChart];
    lineChart.delegate = self;
    
    lineChart.legendStyle = PNLegendItemStyleStacked;
    lineChart.legendFont = [UIFont fontWithName:@"GothamBold" size:12.0f*deviceScale];
    lineChart.legendFontColor = [UIColor redColor];
    
    UIView *legend = [lineChart getLegendWithMaxWidth:320];
    [legend setFrame:CGRectMake(30, 380, legend.frame.size.width, legend.frame.size.width)];
//    [self.view addSubview:legend];
}

- (void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex pointIndex:(NSInteger)pointIndex{
    NSLog(@"Click Key on line %f, %f line index is %d and point index is %d",point.x, point.y,(int)lineIndex, (int)pointIndex);
}

- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
    NSLog(@"Click on line %f, %f, line index is %d",point.x, point.y, (int)lineIndex);
}

@end
