#import "../YTVideoOverlay/Header.h"
#import "../YTVideoOverlay/Init.x"
#import <YouTubeHeader/YTMainAppVideoPlayerOverlayViewController.h>
#import <YouTubeHeader/YTMainAppControlsOverlayView.h>
#import <YouTubeHeader/YTInlinePlayerBarContainerView.h>
#import <YouTubeHeader/QTMIcon.h>
#import <roothide.h>

#define TweakKey @"YouNerdStats"

@interface UIView (YouNerdStats)
- (UIViewController *)_viewControllerForAncestor;
@end

@interface YTMainAppVideoPlayerOverlayViewController (YouNerdStats)
- (void)didPressNerdStats:(id)arg;
@end

@interface YTMainAppControlsOverlayView (YouNerdStats)
- (void)didPressYouNerdStats:(id)arg;
@end

@interface YTInlinePlayerBarContainerView (YouNerdStats)
- (void)didPressYouNerdStats:(id)arg;
@end

static NSBundle *YouNerdStatsBundle() {
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *tweakBundlePath = [[NSBundle mainBundle] pathForResource:TweakKey ofType:@"bundle"];
        if (tweakBundlePath) {
            bundle = [NSBundle bundleWithPath:tweakBundlePath];
        } else {
            bundle = [NSBundle bundleWithPath:[NSString stringWithFormat:jbroot(@"/Library/Application Support/%@.bundle"), TweakKey]];
        }
    });
    return bundle;
}

static NSBundle *tweakBundle = nil;

static UIImage *iconImage() {
    return [%c(QTMIcon) imageWithName:@"youtube_outline/statistics_graph_24pt" color:[UIColor whiteColor]];
}

%group Top
%hook YTMainAppControlsOverlayView
- (UIImage *)buttonImage:(NSString *)tweakId {
    return [tweakId isEqualToString:TweakKey] ? iconImage() : %orig;
}
%new(v@:@)
- (void)didPressYouNerdStats:(id)arg {
    YTMainAppVideoPlayerOverlayViewController *mainOverlayController = (YTMainAppVideoPlayerOverlayViewController *)self._viewControllerForAncestor;
    [mainOverlayController didPressNerdStats:arg];
}
%end
%end

%group Bottom
%hook YTInlinePlayerBarContainerView
- (UIImage *)buttonImage:(NSString *)tweakId {
    return [tweakId isEqualToString:TweakKey] ? iconImage() : %orig;
}
%new(v@:@)
- (void)didPressYouNerdStats:(id)arg {
    YTMainAppVideoPlayerOverlayViewController *mainOverlayController = (YTMainAppVideoPlayerOverlayViewController *)self._viewControllerForAncestor;
    [mainOverlayController didPressNerdStats:arg];
}
%end
%end

%ctor {
    tweakBundle = YouNerdStatsBundle();
    initYTVideoOverlay(TweakKey, @{
        AccessibilityLabelKey: @"YouNerdStats",
        SelectorKey: @"didPressYouNerdStats:",
    });
    %init(Top);
    %init(Bottom);
}