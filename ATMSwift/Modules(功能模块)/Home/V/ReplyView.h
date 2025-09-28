//
//  ReplyView.h
//  ATM
//
//  Created by binbin.c on 2025/9/8.
//

#import <UIKit/UIKit.h>


@class ReplyView;
@protocol ReplyViewDelegate <NSObject>

@optional
- (void)topLineView:(ReplyView *)topLine didSelectItemAtIndex:(NSInteger)index;
- (void)topLineView:(ReplyView *)topLine didScrollToIndex:(NSInteger)index;
@end

@interface ReplyView : UIView

@property (nonatomic, assign) CGFloat autoScrollTimeInterval;
@property (nonatomic, assign) BOOL infiniteLoop;
@property (nonatomic, assign) BOOL autoScroll;
@property (nonatomic, assign) BOOL enableDrag;
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;
@property (nonatomic, weak) id<ReplyViewDelegate> delegate;
@property (nonatomic, strong) NSArray *titlesGroup;

@end


