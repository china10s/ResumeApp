//
//  VCMapView.h
//  ResumeApp
//
//  Created by zhulin on 15-4-9.
//  Copyright (c) 2015年 china10s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "VCProgramView.h"
#import "VTopLabel.h"
#import "VCContentView.h"
#import "CGetData.h"

@interface VCMapView : UIViewController<MKMapViewDelegate,ProBack,UIProgramDelegate>
@property (nonatomic,strong)id<ProBack> DelBack;
@property (nonatomic,strong)VTopLabel                       *CtrlVTopLabel;
@property (nonatomic,strong)VCContentView                   *VContentView;
@property (nonatomic,strong)MKMapView                       *VMapView;
@property (nonatomic,strong)UITapGestureRecognizer          *RecTap;
@property (nonatomic,strong)MKPolygon                       *routeLine;
@property (nonatomic,assign)CLLocationCoordinate2D          theSzCoodinate;
@property (nonatomic,assign)CLLocationCoordinate2D          theWhCoodinate;
@property (nonatomic,assign)CLLocationCoordinate2D          theJzCoodinate;
@property (nonatomic,strong)MKPolylineView                  *routeLineView;
@property (nonatomic,strong)VCProgramView                   *VCProgramView;
@property (nonatomic,strong)NSMutableArray                  *ArryPoint;
- (void)BackClick:(id)sender;
- (void)SelProgram:(NSString*)strProName;
@end
