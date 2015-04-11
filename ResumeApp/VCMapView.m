//
//  VCMapView.m
//  ResumeApp
//
//  Created by zhulin on 15-4-9.
//  Copyright (c) 2015年 china10s. All rights reserved.
//

#import "VCMapView.h"

@interface VCMapView ()

@end

@implementation VCMapView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.frame = [[UIScreen mainScreen] bounds];
    _ArryPoint = [[NSMutableArray alloc] init];
    //初始化地图控件
    [self IniMapCtrl ];
    //初始化标注
    [self IniAnnotation ];
    //初始化路径
    [self IniRoute ];
    //初始化弹出表格
    [self IniPopTable];
    //初始化顶部区域
    [self IniTopLabel];
    //初始化项目内容框
    [self IniContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//初始化顶部区域
- (void)IniTopLabel{
    _CtrlVTopLabel = [[VTopLabel alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_CtrlVTopLabel];
    [_CtrlVTopLabel SetLabel:@"职业轨迹" isBackButtonShow:TRUE];
    _CtrlVTopLabel.DelBack = self;
}

//初始化地图控件
- (void)IniMapCtrl{
    _VMapView = [[MKMapView alloc] init];
    [self.view addSubview:_VMapView];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_VMapView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.view ,_VMapView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_VMapView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.view ,_VMapView)]];
    [_VMapView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //中心点
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = 27.044238062827986f;
    theCoordinate.longitude = 113.09854203250137f;
    
    //区域
    MKCoordinateSpan theSpan;
    theSpan.latitudeDelta=14.5939488f;
    theSpan.longitudeDelta=9.5161656f;
    
    MKCoordinateRegion theRegion ;
    theRegion.center = theCoordinate;
    theRegion.span = theSpan;
    
    //显示
    [_VMapView setRegion:theRegion animated:YES];
    
    _VMapView.delegate = self;
}

//初始化弹出表格
- (void)IniPopTable{
    _VCProgramView = [[VCProgramView alloc] init];
    _VCProgramView.DelegProgram = self;
}

//初始化标注
- (void)IniAnnotation{
    //添加荆州
    _theJzCoodinate = CLLocationCoordinate2DMake(30.339180511115558f, 112.22288246043766f);
    MKPointAnnotation *annJz = [[MKPointAnnotation alloc] init];
    annJz.coordinate = _theJzCoodinate;
    [annJz setTitle:@"荆州"];
    [annJz setSubtitle:@"2008-2012"];
    [_VMapView addAnnotation:annJz];
    [_ArryPoint addObject:[[CLLocation alloc] initWithLatitude:_theJzCoodinate.latitude longitude:_theJzCoodinate.longitude]];
    
    //添加武汉
    _theWhCoodinate = CLLocationCoordinate2DMake(30.51667f, 114.31667f);
    MKPointAnnotation *annWh = [[MKPointAnnotation alloc] init];
    annWh.coordinate = _theWhCoodinate;
    [annWh setTitle:@"武汉"];
    [annWh setSubtitle:@"2012-2014"];
    [_VMapView addAnnotation:annWh];
    [_ArryPoint addObject:[[CLLocation alloc] initWithLatitude:_theWhCoodinate.latitude longitude:_theWhCoodinate.longitude]];
    
    
    //添加深圳
    _theSzCoodinate = CLLocationCoordinate2DMake(22.61667f, 114.06667f);
    MKPointAnnotation *annSz = [[MKPointAnnotation alloc] init];
    annSz.coordinate = _theSzCoodinate;
    [annSz setTitle:@"深圳"];
    [annSz setSubtitle:@"2014-"];
    [_VMapView addAnnotation:annSz];
    [_ArryPoint addObject:[[CLLocation alloc] initWithLatitude:_theSzCoodinate.latitude longitude:_theSzCoodinate.longitude]];
}

//初始化路径
- (void)IniRoute{
    CLLocationCoordinate2D* pointArr = malloc(sizeof(CLLocationCoordinate2D)*3);
    pointArr[0] = _theJzCoodinate;
    pointArr[1] = _theWhCoodinate;
    pointArr[2] = _theSzCoodinate;
    _routeLine = [MKPolyline polylineWithCoordinates:pointArr count:3];
    //加载到地图上
    [self.VMapView addOverlay:self.routeLine];
}

//初始化项目内容框
- (void)IniContentView{
    _VContentView = [[VCContentView alloc] initWithNibName:@"VCContentView" bundle:[NSBundle mainBundle]];
    _VContentView.DelBack = self;
}


//点击
- (void)TapSender:(UIGestureRecognizer*)sender{
    CGPoint touchPoint = [sender locationInView:_VMapView];
    //判断点击了哪个点
    NSInteger iIndex = [self PointIndex:touchPoint];
    if (iIndex < 0) {
        return;
    }
    NSMutableDictionary *dicProSummary = [CGetData GetProgramSummary:iIndex];
    
    //居中
    touchPoint.y += 10;
    CLLocationCoordinate2D touchMapCoordinate = [_VMapView convertPoint:touchPoint toCoordinateFromView:_VMapView];
    [_VMapView setCenterCoordinate:touchMapCoordinate animated:YES];
    
    //弹框
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if (!_VCProgramView.superview) {
        [self.view addSubview:_VCProgramView];
    }
    [_VCProgramView SetLocation:dicProSummary];
    [UIView commitAnimations];
    
}

//两点之间距离
- (NSInteger)PointIndex:(CGPoint)pnt{
    CLLocationCoordinate2D touchCur = [_VMapView convertPoint:pnt toCoordinateFromView:_VMapView];
    CLLocation *locaCur = [[CLLocation alloc] initWithLatitude:touchCur.latitude longitude:touchCur.longitude];
    CLLocationDistance dis = 0;
    for (NSInteger iIndex = 0; iIndex < _ArryPoint.count ; ++iIndex) {
        CLLocation *loca = [_ArryPoint objectAtIndex:iIndex];
        dis = [locaCur distanceFromLocation:loca];
        if (dis <= 100000) {
            return iIndex;
        }
    }
    return -1;
}

- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *pinView = nil;
    
    static NSString *defaultPinID = @"com.invasivecode.pin";
    pinView = (MKPinAnnotationView *)[_VMapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if ( pinView == nil )
        pinView = [[MKPinAnnotationView alloc]
                                      initWithAnnotation:annotation reuseIdentifier:defaultPinID];
    pinView.pinColor = MKPinAnnotationColorRed;
    pinView.canShowCallout = YES;
    pinView.animatesDrop = YES;
    _RecTap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(TapSender:)];
    _RecTap.numberOfTapsRequired = 1;
    [pinView addGestureRecognizer:_RecTap];
    return pinView;
}


- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id )overlay
{
    MKOverlayView* overlayView = nil;
    
    if(overlay == self.routeLine)
    {
        //if we have not yet created an overlay view for this overlay, create it now.
        if(nil == self.routeLineView)
        {
            self.routeLineView = [[MKPolylineView alloc] initWithPolyline:self.routeLine] ;
            self.routeLineView.fillColor = [UIColor redColor];
            self.routeLineView.strokeColor = [UIColor redColor];
            self.routeLineView.lineWidth = 10;
        }
        overlayView = self.routeLineView;
    }
    return overlayView;
    
}


//弹框消失
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    if ([_VCProgramView superview]) {
        [_VCProgramView removeFromSuperview];
    }
}


//返回按钮被点击
- (void)BackClick:(id)sender{
    if ([sender class] == [_VContentView class]) {
        [self dismissViewControllerAnimated:_VContentView completion:nil];
    }
    else{
        [_DelBack BackClick:self];
    }
    
}


//选中某个项目
- (void)SelProgram:(NSString*)strProName{
    //弹框消失
    if ([_VCProgramView superview]) {
        [_VCProgramView removeFromSuperview];
    }
    
    NSString* strContent = [CGetData GetProgramContent:strProName];
    [_VContentView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [_VContentView SetContent:@"" strContent:@""];
    [self presentViewController:_VContentView animated:YES completion:^(void){
        [_VContentView SetContent:strProName strContent:strContent];
    }];
}




@end
