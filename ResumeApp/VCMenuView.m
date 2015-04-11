//
//  VCMenuView.m
//  ResumeApp
//
//  Created by zhulin on 15-4-9.
//  Copyright (c) 2015年 china10s. All rights reserved.
//

#import "VCMenuView.h"
#import "HPublic.h"

#define BUTTONMARGIN 27
#define BUTTONGAP 10
#define BUTTONSIDE 100
#define BUTTONTOP 250+LABELHEIGHT

@interface VCMenuView ()

@end

@implementation VCMenuView



- (void)viewDidLoad {
    self.view.frame = [UIScreen mainScreen].bounds;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _iButtonCount = 0;
    //初始化顶部区域
    [self IniTopLabel];
    //初始化上部图片
    [self IniImageCtrl];
    //初始化下部按钮区域
    [self IniButtonCtrl];
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
    [_CtrlVTopLabel SetLabel:@"个人简介" isBackButtonShow:FALSE];
    _CtrlVTopLabel.DelBack = self;
}

//初始化上部图片
- (void)IniImageCtrl{
    _CtrlImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"liuqiangdong.jpg"] ];
    _CtrlImageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:_CtrlImageView];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_CtrlImageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.view,_CtrlImageView)]];
    NSString * strVImage = [NSString stringWithFormat:@"V:|-%d-[_CtrlImageView(==200)]",LABELHEIGHT];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:strVImage options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.view,_CtrlImageView)]];
    [_CtrlImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
}

//初始化下部按钮区域
- (void)IniButtonCtrl{
    _ArrBtnName = [[NSMutableArray alloc] initWithObjects:@"轨迹",@"自我介绍",@"基本信息",@"职业规划",@"业余爱好", nil];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100,100);
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _CtrlElement = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, 350, 350) collectionViewLayout:layout];
    [self.view addSubview:_CtrlElement];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_CtrlImageView][_CtrlElement]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_CtrlImageView,_CtrlElement)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_CtrlElement]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.view,_CtrlElement)]];
    [_CtrlElement setTranslatesAutoresizingMaskIntoConstraints:NO];
    _CtrlElement.dataSource = self;
    _CtrlElement.delegate = self;
    [_CtrlElement registerClass:[UCCell class] forCellWithReuseIdentifier:@"UCCell"];
    _CtrlElement.backgroundColor = [UIColor whiteColor];
}


//收到返回按钮消息
- (void)BackClick:(id)sender{
    [self dismissViewControllerAnimated:_VCMapViewInstance completion:nil];
}

//按钮数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

//每个item信息
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UCCell * cell = [[_CtrlElement dequeueReusableCellWithReuseIdentifier:@"UCCell" forIndexPath:indexPath] init];
    if (!cell) {
        cell = [[UCCell alloc] init];
    }
    
    NSString* strIcoName = [NSString stringWithFormat:@"cell_icon%ld.png",[indexPath row]+1];
    cell.CtrlImage.image = [UIImage imageNamed:strIcoName];
    cell.CtrlLabel.text = [_ArrBtnName objectAtIndex:[indexPath row]];
    return cell;
}

//选中某个按钮
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [indexPath row];
    UCCell *cell = [_CtrlElement cellForItemAtIndexPath:indexPath];
    NSInteger index = [indexPath row];
    switch (index) {
        case 0:
            [self ShowMapView];
            break;
        case 1:
        case 2:
        case 3:
        case 4:
        {
            NSMutableDictionary * dicTitle = [CGetData GetTitleContent:index];
            if (!dicTitle || dicTitle <= 0) {
                break;
            }
            for(NSString* strTitle in [dicTitle allKeys]){
                NSString *strContent = [dicTitle objectForKey:strTitle];
                [self ShowContentView:strTitle strContent:strContent];
                break;
            }
            break;
        }
        default:
            break;
    }
}

//显示地图框
- (void)ShowMapView{
    if (!_VCMapViewInstance) {
        _VCMapViewInstance = [[VCMapView alloc] initWithNibName:@"VCMapView" bundle:[NSBundle mainBundle]];
        _VCMapViewInstance.DelBack = self;
    }
    [_VCMapViewInstance setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
    [self presentViewController:_VCMapViewInstance animated:YES completion:nil];
}

//显示内容框
- (void)ShowContentView:(NSString*)strTitle strContent:(NSString*)strContent{
    if (!_CtrlContentView) {
        _CtrlContentView = [[VCContentView alloc] initWithNibName:@"VCContentView" bundle:[NSBundle mainBundle]];
        _CtrlContentView.DelBack = self;
    }
    [_CtrlContentView SetContent:@"" strContent:@""];
    [_CtrlContentView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:_CtrlContentView animated:YES completion:^(void){
        [_CtrlContentView SetContent:strTitle strContent:strContent];
    }];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 120);
}




@end
