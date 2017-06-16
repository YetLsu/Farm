//
//  NFCardFlowLayout.m
//  farm
//
//  Created by guest on 17/2/17.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFCardFlowLayout.h"

CGFloat ActiveDistance = 480; //垂直缩放除以系数
CGFloat ScaleFactor = 0.35;     //缩放系数  越大缩放越大
@implementation NFCardFlowLayout

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset{
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    //目标区域中包含的cell
    NSArray *attriArray = [super layoutAttributesForElementsInRect:targetRect];
    //collectionView落在屏幕中点的x坐标
    CGFloat horizontalCenterX = proposedContentOffset.x + (self.collectionView.bounds.size.width/2.0);
    CGFloat offsetAdjustment = CGFLOAT_MAX;
    
    for (UICollectionViewLayoutAttributes *layoutAttributes in attriArray) {
        CGFloat itemHorizontalCenterX = layoutAttributes.center.x;
        if (fabs(itemHorizontalCenterX-horizontalCenterX) < fabs(offsetAdjustment)) {
            //比较谁离中心点更近
            offsetAdjustment = itemHorizontalCenterX-horizontalCenterX;
        }
    }
    CGPoint point = CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
    return point;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    for (UICollectionViewLayoutAttributes *attributes in array) {
        CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
        CGFloat normalizedDistance = fabs(distance/ActiveDistance);
        CGFloat zoom = 1 - ScaleFactor * normalizedDistance;
        attributes.transform3D = CATransform3DMakeScale(1.0, zoom, 1.0);
        
        attributes.zIndex = 1;
    }
    
    return array;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

/**
 * 这个方法的返回值，就决定了collectionView停止滚动时的偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    CGRect rect;
    rect.origin.x = proposedContentOffset.x;
    rect.origin.y = 0;
    rect.size = self.collectionView.frame.size;
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    CGFloat minDelta = CGFLOAT_MAX;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }
    
    proposedContentOffset.x += minDelta;
    
    return proposedContentOffset;
}



@end
