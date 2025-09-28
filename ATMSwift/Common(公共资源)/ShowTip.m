//
//  ShowTip.m
//  ATM
//
//  Created by binbin.c on 2025/9/7.
//

#import "ShowTip.h"
#import <MBProgressHUD.h>
static CGFloat ballWidth = 12.0f;
static CGFloat ballSpeed = 0.7f;
static CGFloat ballZoomScale = 0.25;
static CGFloat pauseSecond = 0.18;

typedef NS_ENUM(NSInteger,BallMoveDirection){
    BallMoveDirectionPositive = 1,
    BallMoveDirectionNegative = -1
};


@interface ShowTip ()
@property (nonatomic, strong) UIView *Bg;
@property (nonatomic, strong) UIView *ballContainer;
@property (nonatomic, strong) UIView *redBall;
@property (nonatomic, strong) UIView *blackBall;
@property (nonatomic, strong) UIView *greenBall;
@property (nonatomic, assign) BallMoveDirection ballMoveDirection;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) BOOL bRegister;
- (void)startAnimated;
- (void)stopAnimated;
@end

@implementation ShowTip

+ (instancetype)showLoading
{
    [self hideLoading];
    UIView *view = [UIApplication sharedApplication].windows[0];
    ShowTip *loading = [[ShowTip alloc]initWithFrame:view.bounds];
    [view addSubview:loading];
    [loading startAnimated];
    return loading;
}



+ (void)hideLoadingMessage:(NSString *)msg
{
    UIView *view = [UIApplication sharedApplication].windows[0];
    NSEnumerator *subViewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subViews in subViewsEnum) {
        if ([subViews isKindOfClass:self]) {
            ShowTip *loading = (ShowTip *)subViews;
            [loading stopAnimated];
            if (loading.displayLink) {
                [loading.displayLink invalidate];
                loading.displayLink = nil;
                loading.bRegister = NO;
            }
            [loading removeFromSuperview];
            return;
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           [ShowTip showMessage:msg];
          });
    
    
}
+ (void)hideLoading
{
    UIView *view = [UIApplication sharedApplication].windows[0];
    NSEnumerator *subViewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subViews in subViewsEnum) {
        if ([subViews isKindOfClass:self]) {
            ShowTip *loading = (ShowTip *)subViews;
            [loading stopAnimated];
            if (loading.displayLink) {
                [loading.displayLink invalidate];
                loading.displayLink = nil;
                loading.bRegister = NO;
            }
            [loading removeFromSuperview];
            return;
        }
    }
    
}

+ (void)showMessageText:(NSString *)text delay:(NSInteger)delay
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].windows[0] animated:YES];
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = UIColor.redColor;
  //  UIColorFromHexAlpha(0x111111, 0.4);
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    [hud hideAnimated:YES afterDelay:delay];
}

+ (void)showMessage:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].windows[0] animated:YES];
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithRed:17/255 green:17/255 blue:17/255 alpha:0.4];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    [hud hideAnimated:YES afterDelay:1];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
   
    self.Bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    self.Bg.backgroundColor = [UIColor colorWithRed:17/255 green:17/255 blue:17/255 alpha:0.4];
    self.Bg.center = [self center];
    self.Bg.layer.cornerRadius = 8;
    self.Bg.layer.masksToBounds = YES;
    [self addSubview:self.Bg];
    
    self.ballContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2.1*ballWidth, 2*ballWidth)];
    self.ballContainer.center = [self center];
    [self addSubview:self.ballContainer];
    
    self.greenBall = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ballWidth, ballWidth)];
    self.greenBall.center = CGPointMake(ballWidth/2.0f, self.ballContainer.bounds.size.height/2.0f);
    self.greenBall.layer.cornerRadius = ballWidth/2.0f;
    self.greenBall.layer.masksToBounds = true;
    self.greenBall.backgroundColor = [UIColor greenColor];
    [self.ballContainer addSubview:self.greenBall];
    
    
    self.redBall = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ballWidth, ballWidth)];
    self.redBall.center = CGPointMake(self.ballContainer.bounds.size.width - ballWidth/2.0f, self.ballContainer.bounds.size.height/2.0f);
    self.redBall.layer.cornerRadius = ballWidth/2.0f;
    self.redBall.layer.masksToBounds = true;
    self.redBall.backgroundColor = [UIColor redColor];
    [self.ballContainer addSubview:self.redBall];

    self.blackBall = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ballWidth, ballWidth)];
    self.blackBall.backgroundColor =[UIColor blackColor];
    self.blackBall.layer.cornerRadius = ballWidth/2.0f;
    self.blackBall.layer.masksToBounds = true;
    [self.greenBall addSubview:self.blackBall];
    

    self.ballMoveDirection = BallMoveDirectionPositive;
    self.bRegister = NO;

    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateBallAnimations)];
}


- (void)startAnimated
{
    if (!self.bRegister) {
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        self.bRegister = YES;
    }
}

- (void)stopAnimated
{
    if (self.bRegister) {
        [self.displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        self.bRegister = NO;
    }
}

- (void)pauseAnimated {
    [self stopAnimated];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(pauseSecond*NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self startAnimated];
    });
}


- (void)updateBallAnimations {
    if (self.ballMoveDirection == BallMoveDirectionPositive) {

        CGPoint center = self.greenBall.center;
        center.x += ballSpeed;
        self.greenBall.center = center;
        

        center = self.redBall.center;
        center.x -= ballSpeed;
        self.redBall.center = center;
        
   
        self.greenBall.transform = [self ballLargerTransformOfCenterX:center.x];
        self.redBall.transform = [self ballSmallerTransformOfCenterX:center.x];
        
     
        CGRect blackBallFrame = [self.redBall convertRect:self.redBall.bounds toCoordinateSpace:self.greenBall];
        self.blackBall.frame = blackBallFrame;
        self.blackBall.layer.cornerRadius = self.blackBall.bounds.size.width/2.0f;
        
       
        if (CGRectGetMaxX(self.greenBall.frame) >= self.ballContainer.bounds.size.width || CGRectGetMinX(self.redBall.frame) <= 0) {
          
            self.ballMoveDirection = BallMoveDirectionNegative;
          
            [self.ballContainer bringSubviewToFront:self.redBall];
            
            [self.redBall addSubview:self.blackBall];
         
            [self pauseAnimated];
        }
    }else if (self.ballMoveDirection == BallMoveDirectionNegative) {
      
        CGPoint center = self.greenBall.center;
        center.x -= ballSpeed;
        self.greenBall.center = center;
        
       
        center = self.redBall.center;
        center.x += ballSpeed;
        self.redBall.center = center;
        
       
        self.redBall.transform = [self ballLargerTransformOfCenterX:center.x];
        self.greenBall.transform = [self ballSmallerTransformOfCenterX:center.x];
        
      
        CGRect blackBallFrame = [self.greenBall convertRect:self.greenBall.bounds toCoordinateSpace:self.redBall];
        self.blackBall.frame = blackBallFrame;
        self.blackBall.layer.cornerRadius = self.blackBall.bounds.size.width/2.0f;
        
      
        if (CGRectGetMinX(self.greenBall.frame) <= 0 || CGRectGetMaxX(self.redBall.frame) >= self.ballContainer.bounds.size.width) {
            self.ballMoveDirection = BallMoveDirectionPositive;
            [self.ballContainer bringSubviewToFront:self.greenBall];
            [self.greenBall addSubview:self.blackBall];
            [self pauseAnimated];
        }
    }
}



- (CGAffineTransform)ballLargerTransformOfCenterX:(CGFloat)centerX {
    CGFloat cosValue = [self cosValueOfCenterX:centerX];
    return CGAffineTransformMakeScale(1 + cosValue*ballZoomScale, 1 + cosValue*ballZoomScale);
}

- (CGAffineTransform)ballSmallerTransformOfCenterX:(CGFloat)centerX {
    CGFloat cosValue = [self cosValueOfCenterX:centerX];
    return CGAffineTransformMakeScale(1 - cosValue*ballZoomScale, 1 - cosValue*ballZoomScale);
}


- (CGFloat)cosValueOfCenterX:(CGFloat)centerX {
    CGFloat apart = centerX - self.ballContainer.bounds.size.width/2.0f;
    CGFloat maxAppart = (self.ballContainer.bounds.size.width - ballWidth)/2.0f;
    CGFloat angle = apart/maxAppart*M_PI_2;
    return cos(angle);
}

@end
