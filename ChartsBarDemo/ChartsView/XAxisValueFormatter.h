//
//  XAxisValueFormatter.h
//  iseasoftCompany
//
//  Created by 张恒宇 on 2019/5/20.
//  Copyright © 2019 hycrazyfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bridge-Swift.h"
#import "Charts-Swift.h"
NS_ASSUME_NONNULL_BEGIN

@interface XAxisValueFormatter : NSObject<IChartAxisValueFormatter>
@property (nonatomic, strong) NSArray *xAxisDatas;
@end

NS_ASSUME_NONNULL_END
