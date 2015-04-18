//
//  VCMenuView.h
//  ResumeApp
//
//  Created by zhulin on 15-4-9.
//  Copyright (c) 2015年 china10s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCMapView.h"
#import "VTopLabel.h"
#import "VCContentView.h"
#import "UCCell.h"

@interface VCMenuView : UIViewController<ProBack,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,assign)NSInteger               iButtonCount;
@property (nonatomic,strong)VTopLabel               *CtrlVTopLabel;
@property (nonatomic,strong)UIImageView             *CtrlImageView;
@property (nonatomic,strong)NSMutableArray          *MAButtonView;
@property (nonatomic,strong)VCMapView               *VCMapViewInstance;
@property (nonatomic,strong)UICollectionView        *CtrlElement;
@property (nonatomic,strong)NSMutableArray          *ArrBtnName;
@property (nonatomic,strong)VCContentView           *CtrlContentView;
@property (nonatomic,strong)UIScrollView            *CtrlScroll;
- (void)BackClick:(id)sender;
@end
