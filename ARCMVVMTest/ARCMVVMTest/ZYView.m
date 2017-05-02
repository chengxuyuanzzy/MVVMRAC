//
//  ZYView.m
//  ARCMVVMTest
//
//  Created by PC0667 on 17/5/2.
//  Copyright © 2017年 PC0667. All rights reserved.
//

#import "ZYView.h"

#import "ZYModel.h"
#import <MJRefresh/MJRefresh.h>

@interface ZYView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) ZYModel *model;

@end

@implementation ZYView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
        
        [self.viewModel.refreshDataCommand execute:nil];
        
        @weakify(self);
        [self.viewModel.refreshEndSubject subscribeNext:^(id x) {
            @strongify(self);
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }];
    }
    return self;
}

- (ZYViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZYViewModel alloc] init];
    }
    return _viewModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        __weak typeof(self) weSelf = self;
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weSelf.viewModel.refreshDataCommand execute:nil];
        }];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weSelf.viewModel.nextPageCommand execute:nil];
        }];
    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.textLabel.text = self.viewModel.model.titleString;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel.cellClickSubject sendNext:[NSString stringWithFormat:@"%ld", indexPath.row]];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
