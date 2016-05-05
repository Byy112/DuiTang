//
//  FoundViewController.m
//  Duitang
//
//  Created by lanouhn on 15/6/17.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "FoundViewController.h"
#import "ListOfProductsViewCell.h"
#import "ScrollCollectionViewCell.h"
#import "StoreViewCell.h"
#import "SearchViewController.h"
#import "ClassificationViewController.h"

#import "PreferentialViewController.h"
#import "Manager.h"
#import "FoundModel.h"
#import "ScrollView.h"
#import "HeaderView.h"

#define NavigationBarHight 60.0f
#define ImageHeight [UIScreen mainScreen].bounds.size.width / 2

@interface FoundViewController ()

//指定数组存储对应的DataModel对象
@property (nonatomic, retain)NSMutableArray *dataSource;
//创建集合视图属性，接收创建的集合视图的对象
//@property (nonatomic, retain)UICollectionView *collectionView;
@property (nonatomic, retain)NSArray * nameArr;
@property (nonatomic, retain)NSArray * iconArr;
@property (nonatomic, retain)UIImageView * imageView;
@property (nonatomic, retain)Manager * foundManger;

@end

@implementation FoundViewController
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray new];
        
    }
    return _dataSource;
    
    
}
- (NSMutableArray *)dataList {
    if (_dataList == nil) {
        self.dataList = [NSMutableArray new];
    }
    return _dataList;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"";

    [Manager sharedManager].navigationController = self.navigationController;
//    self.hidesBottomBarWhenPushed = YES;
    self.dataList = [@[@"fagag",@"GREGE",@"AAA",@"FEWWE"] mutableCopy];
    self.iconArr = [NSArray arrayWithObjects:@"category_5.png",@"category_1.png",@"category_2.png",@"category_3.png",@"category_4.png",@"category_6.png", nil];
    self.nameArr = [NSArray arrayWithObjects:@[@"美食菜谱",@"家居生活",@"影音书"],@[@"壁纸",@"头像",@"表情"],@[@"时尚搭配",@"美容美发",@"美发造型"],@[@"文字句子",@"手工DIY",@"插画绘画"],@[@"婚纱婚礼",@"旅行",@"摄影"],@[@"人物明星",@"动画漫画",@"萌物萌娃"], nil];
    
    [self creatSearchBar];
    [self createCollectView];
    
    //进行网络数据的请求
    NetWorkRequest * requst = [[NetWorkRequest alloc] init];
    
    //开始进行网络数据
    [requst startNetWorkRequestWithURL:@"http://www.duitang.com/napi/index/groups/?app_code=gandalf&app_version=4.6.2%20rv%3A461319&device_name=iPhone%205&device_platform=iPhone5%2C3&locale=zh_CN&platform_name=iPhone%20OS&platform_version=8.3&screen_height=568&screen_width=320" method:@"GET" parameters:nil kind:0 orContainChinese:
     NO];
    //设置代理人
    requst.delegate = self;
    [requst release];
  
}

- (void)getDataSuccessWithObject:(id)object kind:(NSInteger)kind {
  
    NSMutableArray * arr = object[@"data"];
    for (NSDictionary * dic in arr) {
        FoundModel * model = [FoundModel createFoundModelWithDic:dic];
        [self.dataSource addObject:model];
        //[model release];
    }
    
  
    [self.collectView reloadData];
   
}


- (void)createCollectView {
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width / 2 - 5, self.view.bounds.size.height / 5);
    
    flowLayout.itemSize = CGSizeMake(190, 220);
    flowLayout.sectionInset = UIEdgeInsetsMake(0 , 9, 2, 9);
    flowLayout.minimumLineSpacing = 2;
    flowLayout.minimumInteritemSpacing = 2;

    self.collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 45) collectionViewLayout:flowLayout];
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1.0];
    
    self.collectView.contentInset = UIEdgeInsetsMake(ImageHeight, 0, 0, 0);
    
    [self.view addSubview:self.collectView];
    
    //self.collectView.tableFooterView = [UIView new];
    
    self.zoomImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"5.jpg"]];
    self.zoomImageView.frame = CGRectMake(0, -ImageHeight, self.view.frame.size.width, ImageHeight);
    self.zoomImageView.contentMode = UIViewContentModeScaleAspectFill; //(不设置那将只会被纵向拉伸)
    
    
    self.zoomImageView.autoresizesSubviews = YES; //让子类自动布局

//    HeaderView *headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 100)];
//    [self.zoomImageView addSubview:headerView];
    [self.collectView addSubview:self.zoomImageView];
    [self.zoomImageView release];
    [self.collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectView registerClass:[ScrollCollectionViewCell class] forCellWithReuseIdentifier:@"scrollCell"];
    [self.collectView registerClass:[ListOfProductsViewCell class] forCellWithReuseIdentifier:@"listCell"];
    [self.collectView registerClass:[StoreViewCell class] forCellWithReuseIdentifier:@"storeCell"];
    
}
- (void)creatSearchBar {
    //创建一个UISearch
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 18,self.view.frame.size.width - 20, 3)];
    self.searchBar.backgroundColor = [UIColor whiteColor];
    //设置样式
    self.searchBar.barStyle = UIBarStyleDefault;
//    self.searchBar.showsScopeBar = YES;
//    self.searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"1",nil];
//    self.searchBar.selectedScopeButtonIndex = 0;
//    
    //设置
    self.searchBar.barTintColor = [UIColor orangeColor];
    //占位
    self.searchBar.placeholder = @"搜索感兴趣的内容...";
    self.textLabel.frame = CGRectMake(10, 18,self.view.frame.size.width - 20, 3);
    self.searchBar.layer.cornerRadius = 8;
    //设置是否显示取消按钮
    self.searchBar.showsCancelButton = NO;
    //设置代理
    self.searchBar.delegate = self;
    self.searchBar.tag = 122;
    self.searchBar.alpha = 1.0;
    [self.navigationController.navigationBar addSubview:self.searchBar];
    
    _searchController = [[SearchViewController alloc] initWithStyle:UITableViewStylePlain];
    [_searchController.view setFrame:CGRectMake(30, 10, 200, 0)];
    
    
    [self.view addSubview:_searchController.view];
    
}

//
- (void) setSearchControllerHidden:(BOOL)hidden {
    NSInteger height = hidden ? 0: 180;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2];
    
    [_searchController.view setFrame:CGRectMake(30, 36, 100, height)];
    [UIView commitAnimations];
}
//



#pragma mark - UISearchBarDelegate
//当搜索输入框变化时调用该方法
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    
    if (searchBar.selectedScopeButtonIndex == 0) {
        self.showData = nil;
        for (NSString * str in self.dataList) {
            if ([str rangeOfString:searchText options:NSCaseInsensitiveSearch].length > 0) {
                [self.showData addObject:str];
            }
        }
        [self.collectView reloadData];
        
    }
    
    if (_searchBar.text.length == 0) {
        [self setSearchControllerHidden:YES]; //控制下拉列表的隐现
    }else{
        [self setSearchControllerHidden:NO];
        
    }
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
    for(id cc in [searchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
    NSLog(@"shuould begin"); 
    return YES; 
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSLog(@"did end");
    searchBar.showsCancelButton = NO;

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"search clicked");
    searchBar.alpha = 0;
    
    [_searchBar resignFirstResponder];    //隐藏软键盘
//     [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//同上，也可以隐
    if (searchBar.text != nil && ![searchBar.text isEqualToString:@""]) {
        ClassificationViewController * classVC = [[ClassificationViewController alloc] init];
        NSString * str = [NSString stringWithFormat:@"kw=%@",searchBar.text];
        classVC.title = searchBar.text;
        classVC.target_id = str;
        
        searchBar.text = @"";
        [self.navigationController pushViewController:classVC animated:YES];
        
        
    }
    
}

//当点击取消按钮时调用
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [_searchBar resignFirstResponder];
    [self setSearchControllerHidden:YES];
    
}

//
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y + NavigationBarHight;
    if (y < -ImageHeight) {
        CGRect frame = self.zoomImageView.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        self.zoomImageView.frame = frame;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
    
}


//返回每一个cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        static NSString *identifier = @"scrollCell";
        ScrollCollectionViewCell * cell= [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        if (indexPath.row == 0) {
            if (self.dataSource.count != 0) {
                cell.backgroundColor = [UIColor yellowColor];
                cell.model = [self.dataSource objectAtIndex:1];
                
            }
        }
   
        
        return cell;
    }else if (indexPath.section == 1) {
        static NSString *identifier = @"storeCell";
        StoreViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        cell.clipsToBounds = YES;
        
        if (self.dataSource.count != 0) {
            FoundModel * model = [self.dataSource objectAtIndex:2];
            
            if (indexPath.row == 0) {
                
                cell.URL = model.target_idArr[0];
                [cell setImageViewWithImage:[UIImage imageNamed:@"category_shopping@2x"]];
                [cell setButtonTitle:@"良品购"];
                
            }else {
                cell.imageView.image = [UIImage imageNamed:@"category_sale@2x"];
                [cell setButtonTitle:@"特卖惠"];
                cell.URL = model.target_idArr[1];
                
            }
        }
        
        
        return cell;
        
    }else {
        static NSString *identifier = @"listCell";
        ListOfProductsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        NSArray * arr = self.nameArr[indexPath.row];
        
        [cell setImageViewWithImage:[UIImage imageNamed:self.iconArr[indexPath.row]]];
        [cell.button1 setTitle:arr[0] forState:UIControlStateNormal];
        [cell.button2 setTitle:arr[1] forState:UIControlStateNormal];
        [cell.button3 setTitle:arr[2] forState:UIControlStateNormal];
        cell.backgroundColor = [UIColor whiteColor];
        
        
        if (self.dataSource.count != 0) {
            FoundModel * model = [self.dataSource objectAtIndex:indexPath.row + 3];
            
            cell.model = model;
   
        }
      
        return cell;
     
        
        
    }

    
    
}


//返回每一个分区的行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
        if (section == 0) {
            return 1;
        } else if (section == 1) {
            return 2;
        } else {
            return 6;
        }
    
}
//返回每一个cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return CGSizeMake(self.view.frame.size.width, 160);
    } else if (indexPath.section == 1) {
        return CGSizeMake(self.view.frame.size.width / 2 - 10, 60);
        
    }
    return CGSizeMake(self.view.bounds.size.width / 2 - 10, self.view.bounds.size.height / 4 - 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return CGSizeMake(self.view.frame.size.width, 20);
    }else {
        return CGSizeMake(self.view.frame.size.width, 0);
    }
    
}

#pragma UICollectionViewDelegateFlowLayout
////返回每一个cell的尺寸
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(self.view.bounds.size.width / 2 - 7.5, self.view.bounds.size.height / 3 - 10);
//}
#pragma UICollectionViewDelegate


//点击cell响应点击操作
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)viewWillAppear:(BOOL)animated {
    self.searchBar.alpha = 1.0;
    
//     self.hidesBottomBarWhenPushed = YES;
}
//- (void)viewDidDisappear:(BOOL)animated {
//    self.hidesBottomBarWhenPushed = NO;
//    
//}
- (void)dealloc {
    self.dataSource = nil;
    self.collectView = nil;
    self.nameArr = nil;
    [super dealloc];
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

@end
