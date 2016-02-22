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


/**
 *  添加轮播图到指定视图上
 *
 *  @param view                         指定视图
 *  @param frame                        在视图上的Frame
 *  @param delegate                     设置代理
 *  @param images                       加载的图片
 *
 *  @return 轮播图实例对象
 */
+ (instancetype)createOKCycleScrollViewInView:(UIView* )view Frame:(CGRect)frame delegate:(id<OKCycleScrollViewDelegate>)delegate images:(NSArray*) images;


@end
