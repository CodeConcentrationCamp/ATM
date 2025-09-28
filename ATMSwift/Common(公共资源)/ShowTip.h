//
//  ShowTip.h
//  ATM
//
//  Created by binbin.c on 2025/9/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowTip : UIView
+(instancetype)showLoading;
+(void)showMessageText:(NSString *)text delay:(NSInteger)delay;
+(void)hideLoading;
+(void)showMessage:(NSString *)text;
+(void)hideLoadingMessage:(NSString *)msg;
@end

NS_ASSUME_NONNULL_END
