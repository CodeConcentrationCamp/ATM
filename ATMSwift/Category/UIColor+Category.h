

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Category)
+ (UIColor*)bb_hexColor:(NSString*)hex alpha:(CGFloat)alpha;

/**
  渐变颜色  从上到下
 */
+ (UIColor*)bb_gradientFromColor:(UIColor*)fromColor toColor:(UIColor*)toColor withHeight:(CGFloat)height;
/**
  渐变颜色  从左到右
 */
+ (UIColor*)bb_gradientFromColor:(UIColor*)fromColor toColor:(UIColor*)toColor withWidth:(int)width;
/**
  颜色转图片
 */
+ (UIImage*)createImageWithColor:(UIColor*) color;
+ (UIImage *)imageFromColor:(UIColor *)color withSize:(CGSize)size;
/**
  字符串 转颜色
 */
+ (UIColor *)colorWithString:(NSString *)color;
@end

NS_ASSUME_NONNULL_END
