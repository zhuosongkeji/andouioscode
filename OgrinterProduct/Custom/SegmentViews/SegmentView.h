//
//  SegmentView.h
//
//  


#import <UIKit/UIKit.h>

@class SegmentView;

@protocol SegmentViewDelegate <NSObject>
- (void)segmentView:(SegmentView *)segmentView didSelectedSegmentAtIndex:(NSInteger)index;
@end

@interface SegmentView : UIView

- (id)initWithTitles:(NSArray *)titles;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) id<SegmentViewDelegate> delegate;

-(void)segemtBtnChange:(int)index;

@end
