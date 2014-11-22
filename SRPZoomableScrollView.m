
#import "SRPZoomableScrollView.h"
#import <QuartzCore/QuartzCore.h>

@interface SRPZoomableScrollView ()
@property (nonatomic, strong) UIView *testView;
@end

@implementation SRPZoomableScrollView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;

        self.maximumZoomScale = 20;

        self.containerView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.containerView.backgroundColor = [UIColor blueColor];
        self.containerView.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.containerView.layer.borderWidth = 2.f;
        [self.containerView setImage:[UIImage imageNamed:@"01"]];

        [self addSubview:self.containerView];
      
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        tapGesture.numberOfTapsRequired = 2;
        [self addGestureRecognizer:tapGesture];
        
        
        scaleLevel = CGFLOAT_MIN;
    }
    return self;
}



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.containerView;
}



#pragma mark TapDetectingImageViewDelegate methods

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    // single tap does nothing for now
}

#define SCALE_FACTOR 2

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer
{
    // double tap zooms in
    float newScale = [self zoomScale] * SCALE_FACTOR;
   
    if ([self zoomScale] == SCALE_FACTOR) {
        newScale = 1;
    }
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    [self zoomToRect:zoomRect animated:YES];
    scaleLevel = newScale;

    
    
}



#pragma mark Utility methods

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates.
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [self frame].size.height / scale;
    zoomRect.size.width  = [self frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}


@end
