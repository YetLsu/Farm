//
//  YYLineCollectionViewFlowLayout.m
//  farm
//
//  Created by wyy on 2016/12/7.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYLineCollectionViewFlowLayout.h"

@implementation YYLineCollectionViewFlowLayout

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

/**
 * 当collectionView的显示范围发生改变的时候，是否需要重新刷新布局
 * 一旦重新刷新布局，就会重新调用下面的方法：
 1.prepareLayout
 2.layoutAttributesForElementsInRect:方法
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
- (void)prepareLayout{
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置内边距
//    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
//    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat centerX = self.collectionView.frame.size.width * 0.5 + self.collectionView.contentOffset.x;
    
    for (UICollectionViewLayoutAttributes *attrs in array) {
        
        CGFloat delta = ABS(attrs.center.x - centerX);
//        YYLog(@"attrsCenterX=%f\ncenterX=%f", attrs.center.x, centerX);
        
        CGFloat scale = 1 - delta/3500;
        YYLog(@"%f", scale);
        attrs.transform = CGAffineTransformMakeScale(scale, scale);

    }
    
    return array;
    
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
