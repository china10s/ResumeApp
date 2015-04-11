//
//  UCElement.m
//  ResumeApp
//
//  Created by zhulin on 15-4-11.
//  Copyright (c) 2015年 china10s. All rights reserved.
//

#import "UCElement.h"

@implementation UCElement

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UCCell * cell = [[UCCell alloc] init];
    cell.CtrlImage.image = [UIImage imageNamed:@"cell_icon"];
    cell.CtrlLabel.text = @"轨迹";
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(96, 100);
}

@end
