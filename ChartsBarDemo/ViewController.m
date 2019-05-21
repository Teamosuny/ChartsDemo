//
//  ViewController.m
//  ChartsBarDemo
//
//  Created by 张恒宇 on 2019/5/20.
//  Copyright © 2019 hycrazyfish. All rights reserved.
//

#import "ViewController.h"
#import "BarChartViewTool.h"
#import "BarChartViewCell.h"
@interface ViewController ()<UITableViewDelegate ,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BarChartViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BarChartViewCell class])];
    if (!cell) {
        cell = [[BarChartViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([BarChartViewCell class])];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 340;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
