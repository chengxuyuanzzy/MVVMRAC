//
//  ZYViewModel.m
//  ARCMVVMTest
//
//  Created by PC0667 on 17/5/2.
//  Copyright © 2017年 PC0667. All rights reserved.
//

#import "ZYViewModel.h"
#import "ZYModel.h"

@interface ZYViewModel ()

@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation ZYViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self zy_initialize];
    }
    return self;
}

- (void)zy_initialize {
    self.cellClickSubject = [RACSubject subject];
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        self.model.titleString = x;
        [self.refreshEndSubject sendNext:@"end"];
    }];
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        NSLog(@"asdfsdaf");
    }];
    
    [self.nextPageCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        self.model.titleString = x;
        [self.refreshEndSubject sendNext:@"end"];
    }];
}

- (RACCommand *)refreshDataCommand {
    if (!_refreshDataCommand) {
        
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @weakify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //请求数据
                @strongify(self);
                self.currentPage = 1;
                [NSThread sleepForTimeInterval:1];
                NSString *string = @"哈哈哈哈";
                [subscriber sendNext:string];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _refreshDataCommand;
}

- (ZYModel *)model {
    if (!_model) {
        _model = [[ZYModel alloc] init];
    }
    return _model;
}

- (RACSubject *)refreshEndSubject {
    if (!_refreshEndSubject) {
        _refreshEndSubject = [RACSubject subject];
    }
    return _refreshEndSubject;
}

- (RACCommand *)nextPageCommand {
    if (!_nextPageCommand) {
        _nextPageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @weakify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //下一页
                @strongify(self);
                self.currentPage ++;
                [NSThread sleepForTimeInterval:1];
                NSString *string = [NSString stringWithFormat:@"嘎嘎嘎+%ld", self.currentPage];
                [subscriber sendNext:string];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _nextPageCommand;
}

@end
