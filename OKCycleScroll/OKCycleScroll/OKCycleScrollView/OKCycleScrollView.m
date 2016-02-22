//
//  OKCycleScrollView.m
//  OKCycleScroll
//
//  Created by 杨赛 on 16/2/21.
//  Copyright © 2016年 oil knight. All rights reserved.
//

#import "OKCycleScrollView.h"


@interface OKCycleScrollView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIPageControl* pageControl;
@property (nonatomic, strong) UIImageView* clickedImageView;
@property (nonatomic, strong) NSArray* images;
@property (nonatomic, strong) NSArray* urls;
@property (nonatomic, strong) NSTimer* timer;

@property (nonatomic, assign) NSInteger imageViewCount;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@end
@implementation OKCycleScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){
        _width = frame.size.width;
        _height =frame.size.height;
        _scrollView.backgroundColor = [UIColor orangeColor];
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = self.bounds;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate =self;
        _scrollView.contentSize = CGSizeMake(_width, 0);
        [self addSubview:_scrollView];
        
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, _height - 30, _width, 30)];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.5f];
        [self addSubview:_pageControl];
        
        
    }
    
    return self;
}


-(void)nextPage{
    NSInteger currPageNum = _pageControl.currentPage;
    currPageNum++;
    CGPoint offset =  CGPointMake((currPageNum +1) * _width, 0);
    
    if (currPageNum - 1 == 0) {
         _scrollView.contentOffset = CGPointMake(_width , 0);
    }
    
    [UIView animateWithDuration:1.0f animations:^{
        _scrollView.contentOffset = offset;
    }];
    
}

-(void)clearImageViews{
    for(UIView* view in _scrollView.subviews){
        [view removeFromSuperview];
    }
}
-(void)setImages:(NSArray *)images{
    
    _images = images;
    [self clearImageViews];
    
    _pageControl.numberOfPages = images.count;
    _pageControl.currentPage = 0;
    
    _imageViewCount = images.count + 2;
    _scrollView.contentSize = CGSizeMake(_width * _imageViewCount + 2, 0);
    _scrollView.contentOffset = CGPointMake(_width, 0.f);
    
    for (int i = 0; i < _imageViewCount; i++) {
       UIImageView* imageView =  [[UIImageView alloc]initWithFrame:CGRectMake(_width * i, 0, _width, _height)];
        
        if (i == 0) {
            imageView.image = images[images.count -1];
        }else if(i == _imageViewCount -1){
            imageView.image = images[0];
        }else{
            imageView.image = images[i -1];
        }
        
        imageView.userInteractionEnabled = YES;
        UIButton* button = [[UIButton alloc]initWithFrame:imageView.bounds];
        [button setBackgroundColor:[UIColor clearColor]];
        [button addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
       
        [imageView addSubview:button];
        [_scrollView addSubview:imageView];
        
        
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    int pageNum = (offset.x + _width * 0.5) / _width;
    if (pageNum == 0) {
        _pageControl.currentPage = _images.count - 1;
 
    }else if(pageNum == _images.count + 1){
        _pageControl.currentPage = 0;
        
    }else{
        _pageControl.currentPage = pageNum - 1;
        
    }

    
    if (offset.x > (_images.count + 1 ) * _width) {
        scrollView.contentOffset = CGPointMake( offset.x - (_images.count + 1) * _width + _width , 0);
    }
    
    if (offset.x <  0) {
        scrollView.contentOffset = CGPointMake(  offset.x +  _images.count * _width , 0);
    }

}

-(void)clickEvent:(UIButton*)button{
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    if([self.delegate respondsToSelector:@selector(clickImageWithOKCycleScrollView:imageIndex:) ]){
       
        [self.delegate clickImageWithOKCycleScrollView:self imageIndex:_pageControl.currentPage];
    }
}


+ (instancetype)createOKCycleScrollViewInView:(UIView* )view Frame:(CGRect)frame delegate:(id<OKCycleScrollViewDelegate>)delegate images:(NSArray *)images{
    
    OKCycleScrollView* cycleScrollView = [self createOKCycleScrollViewInView:view Frame:frame delegate:delegate];
    cycleScrollView.images = images;
    
    return cycleScrollView;
    
}

+(instancetype)createOKCycleScrollViewInView:(UIView *)view Frame:(CGRect)frame delegate:(id<OKCycleScrollViewDelegate>)delegate urls:(NSArray *)urls{
    
    OKCycleScrollView* cycleScrollView = [self createOKCycleScrollViewInView:view Frame:frame delegate:delegate];
    
    cycleScrollView.urls = urls;
    
    return cycleScrollView;
}


+(instancetype)createOKCycleScrollViewInView:(UIView *)view Frame:(CGRect)frame delegate:(id<OKCycleScrollViewDelegate>)delegate{
    
    OKCycleScrollView* cycleScrollView = [[OKCycleScrollView alloc]initWithFrame:frame];
    
    cycleScrollView.delegate = delegate;
    
    [view addSubview:cycleScrollView];
    
    return cycleScrollView;
}



-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    }
    
}


@end
