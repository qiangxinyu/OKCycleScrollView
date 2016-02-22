//
//  OKCycleScrollView.h
//  OKCycleScroll
//
//  Created by 杨赛 on 16/2/21.
//  Copyright © 2016年 oil knight. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OKCycleScrollView;

@protocol OKCycleScrollViewDelegate <NSObject>

-(void)clickImageWithOKCycleScrollView:(OKCycleScrollView*) view imageIndex:(NSInteger) index;

@end


@interface OKCycleScrollView : UIView

@property (nonatomic, assign) id<OKCycleScrollViewDelegate> delegate;



+ (instancetype)createOKCycleScrollViewInView:(UIView* )view Frame:(CGRect)frame delegate:(id<OKCycleScrollViewDelegate>)delegate images:(NSArray*) images;


@end
