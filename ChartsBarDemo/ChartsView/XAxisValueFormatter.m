//
//  XAxisValueFormatter.m
//  iseasoftCompany
//
//  Created by 张恒宇 on 2019/5/20.
//  Copyright © 2019 hycrazyfish. All rights reserved.
//

#import "XAxisValueFormatter.h"

@implementation XAxisValueFormatter

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis{
    if ((int)value % 7 != 0) {
       return _xAxisDatas[((int)value % 7) - 1];
    }else{
       return _xAxisDatas[((int)value % 7)];
    }
}

@end
