//
//  ReplyCollectionViewCell.m
//  ATM
//
//  Created by binbin.c on 2025/9/8.
//

#import "ReplyCollectionViewCell.h"
@interface ReplyCollectionViewCell ()
@property (nonatomic, strong) UILabel* titleLabel;
@end
@implementation ReplyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupTitleLabel];
    }
    return self;
}

- (void)setupTitleLabel {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.userInteractionEnabled = YES;
    self.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:self.titleLabel];
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    _titleLabel.text = titleStr;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = self.bounds;
}

@end
