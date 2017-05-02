//
//  ZYViewController.m
//  ARCMVVMTest
//
//  Created by PC0667 on 17/5/2.
//  Copyright © 2017年 PC0667. All rights reserved.
//

#import "ZYViewController.h"
#import "ZYView.h"
#import "ZYViewModel.h"

@interface ZYViewController ()

@property (nonatomic, strong) ZYView *mainView;

@end

@implementation ZYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainView];
    
    [self.mainView.viewModel.cellClickSubject subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    // Do any additional setup after loading the view.
}

- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[ZYView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
