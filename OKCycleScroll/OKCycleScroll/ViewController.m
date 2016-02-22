//
//  ViewController.m
//  OKCycleScroll
//
//  Created by 杨赛 on 16/2/21.
//  Copyright © 2016年 oil knight. All rights reserved.
//

#import "ViewController.h"
#import "OKCycleScrollView.h"

@interface ViewController ()<OKCycleScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSMutableArray* array = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"img_0%d", i + 1]]];
    }
    
    [OKCycleScrollView createOKCycleScrollViewInView:self.view Frame:CGRectMake(0, 64, self.view.bounds.size.width, 200) delegate:self images:array];
    self.view.backgroundColor = [UIColor purpleColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)clickImageWithOKCycleScrollView:(OKCycleScrollView *)view imageIndex:(NSInteger)index{
   
    UIViewController* newVC = [[UIViewController alloc]init];
    newVC.view.backgroundColor = [UIColor greenColor];
    newVC.navigationItem.title = [NSString stringWithFormat:@"%ld", index];
    [self.navigationController pushViewController:newVC animated:YES];
}

@end

