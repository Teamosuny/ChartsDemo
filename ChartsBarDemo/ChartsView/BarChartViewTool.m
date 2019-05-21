//
//  BarChartViewTool.m
//  iseasoftCompany
//
//  Created by 张恒宇 on 2019/5/17.
//  Copyright © 2019 hycrazyfish. All rights reserved.
//

#import "BarChartViewTool.h"
#import "XAxisValueFormatter.h"

@interface BarChartViewTool()<ChartViewDelegate>
@property (nonatomic, strong) BarChartView *chartView;
@property (nonatomic ,strong) XAxisValueFormatter *xAxisValueFormatter;
@end

@implementation BarChartViewTool

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadContent];
    }
    return self;
}

- (void)loadContent{
    
    _chartView = [[BarChartView alloc]initWithFrame:CGRectMake(0, 0, APP_WIDTH,250)];
    _chartView.delegate = self;
    _chartView.drawBarShadowEnabled = NO;                 // 是否绘制阴影背景
    _chartView.drawValueAboveBarEnabled = YES;            // 数值显示是否在条柱上面
    _chartView.maxVisibleCount = 50;                      // Y轴的数字最大值
    _chartView.doubleTapToZoomEnabled = NO;               // 双击不可缩放
    _chartView.legend.enabled = NO;                       // 不显示下方的小方格
    [_chartView setChartDescription:nil];                 // 显示描述默认显示Description Label
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;       // X轴的显示位置
    xAxis.labelFont = [UIFont systemFontOfSize:12.f];     // X轴显示文字Font
    xAxis.labelTextColor = [UIColor getHEXRGB:@"999999"]; // X轴显示文字颜色
    xAxis.drawGridLinesEnabled = NO;                      // 是否绘制网格
    xAxis.granularity = 1.0;                              // only intervals of 1 day
    xAxis.labelCount = 10;                                // X轴的数字个
    xAxis.wordWrapEnabled = YES;                          // 文字换行
    [xAxis setLabelRotationAngle:20];                     // 设置文字倾斜角度
    self.xAxisValueFormatter = [[XAxisValueFormatter alloc] init];// 自定义Formatter实现底部显示文字
    xAxis.valueFormatter = self.xAxisValueFormatter;
    
    NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init]; // 坐标数值样式
    leftAxisFormatter.minimumFractionDigits = 0;                             // Y轴坐标最少为0位小数
    leftAxisFormatter.maximumFractionDigits = 1;                             // Y轴坐标最多为1位小数
    leftAxisFormatter.negativeSuffix = @"";
    leftAxisFormatter.positiveSuffix = @"";
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.labelCount = 5;
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;                  // 坐标数值的位置
    leftAxis.spaceTop = 0.15;                                                 // 最大值到顶部的范围比
    leftAxis.axisMinimum = 0.0;                                               // this replaces startAtZero = YES
    
    
    //分别有左右两个Y轴方向的数字展示
    ChartYAxis *rightAxis = _chartView.rightAxis;
    rightAxis.enabled = YES;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
    rightAxis.labelCount = 5;
    rightAxis.spaceTop = 0.15;
    rightAxis.axisMinimum = 0.0;                                              // this replaces startAtZero = YES
    [self addSubview:_chartView];
    [self setDataCount:10 range:50];
   
    
}

- (void)setDataCount:(int)count range:(double)range
{
    double start = 1.0;
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = start; i < start + count + 1; i++)
    {
        int mult = (range + 1);
        int val =  (arc4random_uniform(mult));
        if (arc4random_uniform(100) < 25) {
            [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val icon: [UIImage imageNamed:@""]]];
        } else {
            [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val]];
        }
    }
    
    BarChartDataSet *set1 = nil;
    if (_chartView.data.dataSetCount > 0){
        set1 = (BarChartDataSet *)_chartView.data.dataSets[0];
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
        
    }else{
        set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@""];
        [set1 setColors:[self getBarItemBGColor]];                        // 设置柱状图的颜色数组,按顺序循环复用
        [set1 setValueColors:[self getBarItemBGColor]];                   // 设置柱状图的文字颜色数组,按顺序循环复用
        set1.drawIconsEnabled = NO;                                       // 是否绘制icon
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
        data.barWidth = 0.5f;                                             // 柱状图和间隔的比例.
        _xAxisValueFormatter.xAxisDatas = [self setBottomTexts];          // 底部文字数组(模拟数组).
        _chartView.data = data;                                           // 数据赋值
        [_chartView setVisibleXRangeMaximum:6];                           // 设置一页最多显示多少个柱状图,超过可以滑动
    }
}

#pragma mark - ChartViewDelegate
- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight{
    NSLog(@"chartValueSelected%.0f",entry.x);
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView{
    NSLog(@"chartValueNothingSelected");
}

//设置一页柱状图颜色(我这里设置的一页最多展示6个柱状图)
- (NSArray <UIColor *>*)getBarItemBGColor{
    return @[[UIColor getHEXRGB:@"66A6E7"],
             [UIColor getHEXRGB:@"EDB86C"],
             [UIColor getHEXRGB:@"E27964"],
             [UIColor getHEXRGB:@"5ABF98"],
             [UIColor getHEXRGB:@"6C96EF"],
             [UIColor getHEXRGB:@"EB593A"]];
}

//模拟底部文字数组.
- (NSArray *)setBottomTexts{
     return @[@"中国大区地球村大区美国县政府",@"华东大区",@"日本省",@"台湾市",@"美国县",@"地球村"];
}

@end
