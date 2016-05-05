//
//  WaterViewController.m
//  shiyan
//
//  Created by lanouhn on 15/6/18.
//  Copyright (c)

#import "HotViewController.h"
#import "UICollectionViewWaterfallLayout.h"

#import "HotModel.h"
#import "NetWorkRequest.h"
#import "HotDetailViewController.h"
#import "RefreshCollectionViewCell.h"

#import "HotListsCollectionViewCell.h"

#import "HotListsViewController.h"

#import "SDCycleScrollView.h"
#import "HeaderModel.h"
#import "TopicViewController.h"
#import "Manager.h"
#import "TransformToTaoBaoViewController.h"

#define kItemWidth ([UIScreen mainScreen].bounds.size.width / 2 - 15) //item的宽度

@interface HotViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateWaterfallLayout,NetWorkRequestDelegate,SDCycleScrollViewDelegate>

@property (nonatomic, retain)NSMutableArray *dataArr; //存储数据
@property (nonatomic, retain)NSMutableArray *headerArr;//存储头部数据
@property (nonatomic, retain)NSMutableArray * titlesArr;

@property (nonatomic, retain)UICollectionView *collectionView;
@property (nonatomic)NSInteger loadCount;//加载的次数
//创建刷新控件
@property (nonatomic, retain)UIRefreshControl *refresh;
@property (nonatomic, copy)NSString *album_id;
@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"热门";

    [Manager sharedManager].navigationController = self.navigationController;
    
    NetWorkRequest *manager = [[NetWorkRequest alloc] init];
    manager.delegate = self;
    
    [manager startNetWorkRequestWithURL:@"http://www.duitang.com/napi/index/hot/?include_fields=sender%2Calbum%2Cicon_url%2Clike_count%2Creply_count&__dtac=%257B%2522_r%2522%253A%2520%2522465200%2522%257D&start=0&limit=24" method:nil parameters:nil kind:0 orContainChinese:NO];
    
    NetWorkRequest *request = [[NetWorkRequest alloc]init];
    request.delegate = self;
    [request startNetWorkRequestWithURL:@"http://www.duitang.com/napi/ad/banner/week/" method:nil parameters:nil kind:2 orContainChinese:NO];
    
    [self createCollectionView];
    [manager release];
    [request release];
    [self.collectionView registerClass:[RefreshCollectionViewCell class] forCellWithReuseIdentifier:@"refresh"];
    [self setupViews];
    
    //刷新
    self.refresh = [[UIRefreshControl alloc]init];
    
    //设置刷新操作时显示的内容
    self.refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"加载中"];
    
    //refresh.tintColor = [UIColor redColor];

    //为刷新控件添加事件
    [self.refresh addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.collectionView addSubview:self.refresh];
    self.collectionView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);//设置偏移量
    [self.refresh release];
    
}

- (void)refreshAction:(UIRefreshControl *)refresh {
    
    //执行网络数据请求
    NetWorkRequest *request = [[NetWorkRequest alloc]init];
    //开始进行网络数据请求
    [request startNetWorkRequestWithURL:@"http://www.duitang.com/napi/index/hot/?include_fields=sender%2Calbum%2Cicon_url%2Clike_count%2Creply_count&__dtac=%257B%2522_r%2522%253A%2520%2522465200%2522%257D&start=0&limit=24" method:nil parameters:nil kind:0 orContainChinese:NO];
    
    //设置代理
    request.delegate = self;
    [request release];
}

#pragma mark - NetWorkRequestDelegate
- (void)getDataSuccessWithObject:(id)object kind:(NSInteger)kind{
    
    if (kind == 0) {
        //停止刷新操作
        [self.refresh endRefreshing];
        //清空数组数据
        [self.dataArr removeAllObjects];
    }
    if (kind == 2) {
        NSArray *arr = object[@"data"];
        [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            HeaderModel *model = [HeaderModel createModelWithDic:obj];
            [self.headerArr addObject:model];
        }];
    }
    if (kind == 0 || kind == 1) {
        NSArray *arr = object[@"data"][@"object_list"];
        //使用block遍历数组
        [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            HotModel *model = [HotModel createModelWithDic:obj];
            [self.dataArr addObject:model];
        }];
    }
    [self setupViews];
    [self.collectionView reloadData];
}

- (void)getDataFail {
    
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查当前网络是否连接" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertV show];
    [alertV release];
}
- (void)createCollectionView {
    
    UICollectionViewWaterfallLayout *waterFlow = [[UICollectionViewWaterfallLayout alloc]init];
    waterFlow.itemWidth = kItemWidth;
    
    
    //设置每个分区的缩进量
    waterFlow.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    //设置代理，用来动态返回每一个item的高度
    waterFlow.delegate = self;
    //设置最小行间距
    waterFlow.minLineSpacing = 10;
    
    self.collectionView = [[[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:waterFlow] autorelease];
    self.collectionView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1.0];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    [waterFlow release];
    
    [self.collectionView registerClass:[HotListsCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}
//头部滚动视图
- (void)setupViews
{
    SDCycleScrollView *adScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -200, [UIScreen mainScreen].bounds.size.width, 200) imageURLStringsGroup:nil];
    NSMutableArray *imageURLString = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *titles =[NSMutableArray arrayWithCapacity:0];
    [self.headerArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        HeaderModel *model = (HeaderModel *)obj;
        [imageURLString addObject:model.image_url];
        [titles addObject:model.descriptions];
    }];
    self.titlesArr = titles;
    adScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;//设置圆点的坐标
    adScrollView.pageControlDotSize = CGSizeMake(5, 5);//设置圆点的大小
    adScrollView.titlesGroup = titles;//设置标题
    adScrollView.autoScrollTimeInterval = 2.0;//轮播的时常
    adScrollView.delegate = self; //设置代理
    adScrollView.backgroundColor = [UIColor whiteColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        adScrollView.imageURLStringsGroup = imageURLString;
    });
    
    [self.collectionView addSubview:adScrollView];
}
#pragma mark SGFocusImageFrameDelegate
//头部滚动视图的点击事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
 
    HeaderModel *model = self.headerArr[index];
    
    if ([model.target containsString:@"topic_id="]) {
        TopicViewController *top = [[TopicViewController alloc] init];
        top.target = model.target;
        top.title = self.titlesArr[index];
        [self.navigationController pushViewController:top animated:YES];
        
    } else if ([model.target containsString:@"guide/event"]) {
        TransformToTaoBaoViewController *transformVC = [[TransformToTaoBaoViewController alloc] init];
        transformVC.source_link = model.target;
        transformVC.title = self.titlesArr[index];
        [self.navigationController pushViewController:transformVC animated:YES];
        
    } else {
        
    
        HotListsViewController *hotdetail = [[HotListsViewController alloc]init];
        hotdetail.target = model.target;
        hotdetail.nav = self.navigationController;
        hotdetail.title = self.titlesArr[index];
        
        [self.navigationController pushViewController:hotdetail animated:YES];
    }
    
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}
//设置分区item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
        return self.dataArr.count + 1 ;
}

//返回cell对象
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.dataArr.count) {
        HotListsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"forIndexPath:indexPath];
        cell.model = self.dataArr[indexPath.row];
        cell.myNav = self.navigationController;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else {
        
        RefreshCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"refresh" forIndexPath:indexPath];
        return cell;
    }
}

//cell将要展示到可视区域时触发
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

        if (indexPath.row == self.dataArr.count) {
            RefreshCollectionViewCell *refreshCell = (RefreshCollectionViewCell *)cell;
            [refreshCell.activityIndicatorV startAnimating];
            //执行网络请求
            NetWorkRequest *request = [[NetWorkRequest alloc]init];
            
            self.loadCount = self.loadCount + 24;
            NSString *url1 = @"http://www.duitang.com/napi/index/hot/?include_fields=sender%2Calbum%2Cicon_url%2Clike_count%2Creply_count&__dtac=%257B%2522_r%2522%253A%2520%2522465200%2522%257D&";
            NSString *url2 = [NSString stringWithFormat:@"start=%ld&limit=24",(long)self.loadCount];
            NSString *url = [url1 stringByAppendingString:url2];
            
            //开始进行网络数据请求(kind来判断当前操作是加载还是刷新，0代表刷新，1代表加载)
            [request startNetWorkRequestWithURL:url method:nil parameters:nil kind:1 orContainChinese:NO];
            request.delegate = self;
            [request release];
        }
}

#pragma mark - UICollectionViewDelegateWaterfallLayout
//动态返回每个item的高度
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewWaterfallLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    //根据对应的Model对象, 动态计算出每个item的高度,
    //按比例进行缩放,得到最终缩放之后的高度,返回
    if (indexPath.row < self.dataArr.count) {
        
        HotModel *model = self.dataArr[indexPath.row ];
        
        CGRect rect = [model.msg boundingRectWithSize:CGSizeMake(300, 100) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
        
        return kItemWidth *model.photo_height.floatValue / model.photo_width.floatValue + rect.size.height + 80;
    }else {
        return 0;
    }
}

- (NSMutableArray *)dataArr {
    
    if (!_dataArr) {
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return [[_dataArr retain] autorelease];
}
- (NSMutableArray *)headerArr {

    if (!_headerArr) {
        self.headerArr = [NSMutableArray arrayWithCapacity:0];
    }
    return [[_headerArr retain] autorelease];
}
- (void)dealloc {
    
    self.collectionView = nil;
    self.dataArr = nil;
    self.refresh = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
// Dispose of any resources that can be recreated.
}
//- (void)viewWillAppear:(BOOL)animated {
//    
//    
//    self.hidesBottomBarWhenPushed = YES;
//}
//- (void)viewDidDisappear:(BOOL)animated {
//    self.hidesBottomBarWhenPushed = NO;
//    
//}
/*
 #pragma mark - Navigation


 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
