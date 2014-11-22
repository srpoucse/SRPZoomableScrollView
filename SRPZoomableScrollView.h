
#import <UIKit/UIKit.h>

@interface SRPZoomableScrollView : UIScrollView <UIScrollViewDelegate>
{
    CGFloat scaleLevel;
}

@property (nonatomic, strong) UIImageView *containerView;

@end
