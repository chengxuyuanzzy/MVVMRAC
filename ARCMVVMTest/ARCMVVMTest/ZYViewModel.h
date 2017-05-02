//
//  ZYViewModel.h
//  ARCMVVMTest
//
//  Created by PC0667 on 17/5/2.
//  Copyright © 2017年 PC0667. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYModel.h"

@interface ZYViewModel : NSObject

@property (nonatomic, strong) RACCommand *refreshDataCommand;

@property (nonatomic, strong) RACSubject *refreshEndSubject;

@property (nonatomic, strong) RACCommand *nextPageCommand;

@property (nonatomic, strong) ZYModel *model;

@property (nonatomic, strong) RACSubject *cellClickSubject;


@end
