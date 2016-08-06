//
//  EditADADsViewController.m
//  众商智推
//
//  Created by 杨 on 16/5/11.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "EditADADsViewController.h"
#import "EditADADsTypeViewController.h"
#import "TypeOneViewController.h"
#import "TypeTwoViewController.h"
#import "TypeThreeViewController.h"
#import "TypeFourViewController.h"
#import "TypeFiveViewController.h"

//五中广告的cell
#import "ADOneTableViewCell.h"
#import "ADTwoTableViewCell.h"
#import "ADThreeTableViewCell.h"
#import "ADFourTableViewCell.h"
#import "ADFiveTableViewCell.h"
//五种广告的模型
#import "AdtypeOneModel.h"
#import "AdtypeTwoModel.h"
#import "AdtypeThreeModel.h"
#import "AdtypeFourModel.h"
#import "AdtypeFiveModel.h"

@interface EditADADsViewController ()<UITableViewDelegate,UITableViewDataSource>

//显示用户编辑的广告
@property (strong, nonatomic) UIButton *showBtn;
//编辑
@property (strong, nonatomic) UIButton *editADTypeBtn;
//删除
@property (strong, nonatomic) UIButton *removeADTypeBtn;
//沙盒中存储的用户输入的广告语
@property (strong, nonatomic) NSString *adContent;
//显示用户编辑的广告
@property (strong, nonatomic) UITableView *userADTableView;
@property (strong,nonatomic) NSArray * adTypeName;

//保存数据模型的arr
@property (strong,nonatomic) NSMutableArray * modelArr1;
@property (nonatomic,strong) NSMutableArray * modelArr2;
@property (nonatomic,strong) NSMutableArray * modelArr3;
@property (nonatomic,strong) NSMutableArray * modelArr4;
@property (nonatomic,strong) NSMutableArray * modelArr5;

//将转化之后模型数组在同一装进字典（因为字典的value可以为空，加入某广告条类型为空，用数组会使其后面的元素提前，以至于只有四个并且顺序呗打乱）
@property (strong,nonatomic) NSMutableDictionary * modelDic;

@property (nonatomic,strong) NSArray * adTypeControllers;

//存储一个数组有section使用indexpath.section
@property (strong,nonatomic) NSArray * sectionArr;
@end

@implementation EditADADsViewController
{
    TypeOneViewController * oneCTL;
    TypeTwoViewController * twoCTL;
    TypeThreeViewController * threeCTL;
    TypeFourViewController * fourCTL;
    TypeFiveViewController * fiveCTL;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.adTypeName = [NSArray arrayWithObjects:@"广告类型1",@"广告类型2",@"广告类型3",@"广告类型4",@"广告类型5", nil];
    self.modelArr1 = [NSMutableArray array];
    self.modelArr2 = [NSMutableArray array];
    self.modelArr3 = [NSMutableArray array];
    self.modelArr4 = [NSMutableArray array];
    self.modelArr5 = [NSMutableArray array];
    self.modelDic  = [NSMutableDictionary dictionary];
    
    oneCTL = [[TypeOneViewController alloc] init];
    twoCTL = [[TypeTwoViewController alloc] init];
    threeCTL = [[TypeThreeViewController alloc] init];
    fourCTL = [[TypeFourViewController alloc] init];
    fiveCTL = [[TypeFiveViewController alloc] init];
//    self.adTypeControllers = [NSArray arrayWithObjects:oneCTL, twoCTL,threeCTL,fourCTL,fiveCTL, nil];
    
    
    //每个组别在plist文件中对应的key
    self.sectionArr = [NSArray arrayWithObjects:@"ad1",@"ad2",@"ad3",@"ad4",@"ad5", nil];
    //从本地plist文件加载广告数据
    [self requestForDataFromPath:[NSString stringWithFormat:@"%@ADInfo.plist",kPath]];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"profileBackImage.png"]]];
    //顶部view
    [self createHeadUI];
    //创建内容的控件
    [self createContentUI];
    //用来显示用户的广告类型
//    [self showAddADType];
    [self.view addSubview:self.userADTableView];

    
}

-(void)viewWillAppear:(BOOL)animated{
    [self.userADTableView reloadData];
}
-(void)viewDidAppear:(BOOL)animated{
    [self requestForDataFromPath:kPath];
    NSLog(@"shijian:%@",[NSDate date]);
}

#pragma mark - 创建顶部View
- (void)createHeadUI
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    headView.backgroundColor = ZSColor(19, 143, 253);
    [self.view addSubview:headView];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 25, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];
    
    //标题按钮
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-60, 25, 120, 40)];
    titleLabel.text = @"我的广告列表";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
}
//退出此控制器返回到上级的控制器
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createContentUI
{
    //提示语Label
    UILabel *tiShiLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 80, 40)];
    tiShiLabel1.text = @"个人广告";
    tiShiLabel1.textAlignment = NSTextAlignmentLeft;
    tiShiLabel1.textColor = [UIColor whiteColor];
    tiShiLabel1.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:tiShiLabel1];
    //提示语Label
    UILabel *tiShiLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(90, 70, 150, 40)];
    tiShiLabel2.text = @"（个人推广用户创建）";
    tiShiLabel2.textAlignment = NSTextAlignmentLeft;
    tiShiLabel2.textColor = [UIColor whiteColor];
    tiShiLabel2.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:tiShiLabel2];
    
    UIButton *addPIADBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addPIADBtn.frame = CGRectMake(10, ScreenHeight - 60, ScreenWidth - 20, 40);
    addPIADBtn.backgroundColor = ZSColor(19, 143, 253);
    [addPIADBtn setImage:[UIImage imageNamed:@"addPIAD"] forState:UIControlStateNormal];
    [addPIADBtn setTitle:@"添加个人广告" forState:UIControlStateNormal];
    [addPIADBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addPIADBtn addTarget:self action:@selector(addPIADBtnClick) forControlEvents:UIControlEventTouchUpInside];
    addPIADBtn.layer.cornerRadius = 5;
    addPIADBtn.layer.masksToBounds = YES;
    [self.view addSubview:addPIADBtn]; 
}

- (void)addPIADBtnClick
{
    EditADADsTypeViewController *ADsTypeVC = [[EditADADsTypeViewController alloc] init];
    [self presentViewController:ADsTypeVC animated:YES completion:nil];
}


-(UITableView *)userADTableView
{
    if (!_userADTableView) {
        _userADTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, ScreenWidth, ScreenHeight-164) style:UITableViewStylePlain];
        _userADTableView.backgroundColor = [UIColor clearColor];
        _userADTableView.delegate = self;
        _userADTableView.dataSource = self;
        _userADTableView.tableFooterView = [[UIView alloc] init];
        _userADTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _userADTableView;
}


//去掉UItableview headerview黏性
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _userADTableView)
    {
        CGFloat sectionHeaderHeight = _userADTableView.sectionHeaderHeight;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.modelDic[self.sectionArr[section]] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 15, ScreenWidth)];
    label.text = self.adTypeName[section];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.backgroundColor = [UIColor clearColor];
    return label;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height;
    if ([self.modelDic[self.sectionArr[section]] count]) {
        height = 15;
    }else{
        height = 0;
    }
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * cell1 = @"cell1";
    static NSString * cell2 = @"cell2";
    static NSString * cell3 = @"cell3";
    static NSString * cell4 = @"cell4";
    static NSString * cell5 = @"cell5";
    UITableViewCell * cell;
    if (indexPath.section == 0) {
        ADOneTableViewCell * cellone = [tableView dequeueReusableCellWithIdentifier:cell1];
        if (!cellone) {
            cellone = [[ADOneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
        }
        [cellone loadDataWithModel:self.modelArr1[indexPath.row] indexPath:indexPath];
//        [tableView reloadData];
        cell = cellone;
    }else if (indexPath.section == 1){
        ADTwoTableViewCell * celltwo = [tableView dequeueReusableCellWithIdentifier:cell2];
        if (!celltwo) {
            celltwo = [[ADTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell2];
        }
        [celltwo loadDataWithModel:self.modelArr2[indexPath.row] indexPath:indexPath];
        cell = celltwo;
    }else if (indexPath.section == 2){
        ADThreeTableViewCell * cellthree = [tableView dequeueReusableCellWithIdentifier:cell3];
        if (!cellthree) {
            cellthree = [[ADThreeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell3];
        }
        [cellthree loadDataWithModel:self.modelArr3[indexPath.row] indexPath:indexPath];
        cell = cellthree;
    }else if (indexPath.section == 3){
        ADFourTableViewCell * cellfour = [tableView dequeueReusableCellWithIdentifier:cell4];
        if (!cellfour) {
            cellfour = [[ADFourTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell4];
        }
        [cellfour loadDataWithModel:self.modelArr4[indexPath.row] indexPath:indexPath];
        cell = cellfour;
    }else if (indexPath.section == 4){
        ADFiveTableViewCell * cellfive = [tableView dequeueReusableCellWithIdentifier:cell5];
        if (!cellfive) {
            cellfive = [[ADFiveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell5];
        }
        [cellfive loadDataWithModel:self.modelArr5[indexPath.row] indexPath:indexPath];
        cell = cellfive;
    }
    return cell;
}

#pragma mark 加载本地广告数据
-(void)requestForDataFromPath:(NSString*)path{
    //从本地plist文件中加载数据（由编辑广告条页面添加保存的数据）
    
    NSMutableDictionary * infoDic = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithFile:path];
//    NSLog(@"///////////%@",infoDic);
    if (infoDic[@"ad1"]) {
        NSMutableArray * modelarr = [NSMutableArray array];
        for (NSDictionary * dic in infoDic[@"ad1"]) {
            AdtypeOneModel * model = [[AdtypeOneModel alloc] initWithDictionary:dic];
            [modelarr addObject:model];
            NSLog(@"model数量%ld",self.modelArr1.count);
        }
        self.modelArr1 = [NSMutableArray arrayWithArray:modelarr];
    }

    if (infoDic[@"ad2"]) {
        NSMutableArray * modelarr = [NSMutableArray array];
        for (NSDictionary * dic in infoDic[@"ad2"]) {
            AdtypeTwoModel * model = [[AdtypeTwoModel alloc] initWithDictionary:dic];
            [modelarr addObject:model];
        }
        self.modelArr2 = [NSMutableArray arrayWithArray:modelarr];
    }
    if (infoDic[@"ad3"]) {
        NSMutableArray * modelarr = [NSMutableArray array];
        for (NSDictionary * dic in infoDic[@"ad3"]) {
            AdtypeThreeModel * model = [[AdtypeThreeModel alloc] initWithDictionary:dic];
            [modelarr addObject:model];
        }
        self.modelArr3 = [NSMutableArray arrayWithArray:modelarr];
    }
    if (infoDic[@"ad4"]) {
        NSMutableArray * modelarr = [NSMutableArray array];
        for (NSDictionary * dic in infoDic[@"ad4"]) {
            AdtypeFourModel * model = [[AdtypeFourModel alloc] initWithDictionary:dic];
            [modelarr addObject:model];
        }
        self.modelArr4 = [NSMutableArray arrayWithArray:modelarr];
    }
    if (infoDic[@"ad5"]) {
        NSMutableArray * modelarr = [NSMutableArray array];
        for (NSDictionary * dic in infoDic[@"ad5"]) {
            AdtypeFiveModel * model = [[AdtypeFiveModel alloc] initWithDictionary:dic];
            [modelarr addObject:model];
        }
        self.modelArr5 = [NSMutableArray arrayWithArray:modelarr];
    }
    
    if (![self.modelArr1 isKindOfClass:[NSNull class]]) {
        [self.modelDic setValue:self.modelArr1 forKey:@"ad1"];
    }else{
        [self.modelDic setValue:NULL forKey:@"ad1"];
    }
    
    if (![self.modelArr2 isKindOfClass:[NSNull class]]) {
        [self.modelDic setValue:self.modelArr2 forKey:@"ad2"];
    }else{
        [self.modelDic setValue:NULL forKey:@"ad2"];
    }
   
    if (![self.modelArr3 isKindOfClass:[NSNull class]]) {
        [self.modelDic setValue:self.modelArr3 forKey:@"ad3"];
    }else{
        [self.modelDic setValue:NULL forKey:@"ad3"];
    }
    
    if (![self.modelArr4 isKindOfClass:[NSNull class]]) {
        [self.modelDic setValue:self.modelArr4 forKey:@"ad4"];
    }else{
        [self.modelDic setValue:NULL forKey:@"ad4"];
    }
    
    if (![self.modelArr5 isKindOfClass:[NSNull class]]) {
        [self.modelDic setValue:self.modelArr5 forKey:@"ad5"];
    }else{
        [self.modelDic setValue:NULL forKey:@"ad5"];
    }
    [self.userADTableView reloadData];
}

#pragma mark cell的侧滑删除，编辑自定义按钮
- (NSArray*)tableView:(UITableView*)tableView editActionsForRowAtIndexPath:(NSIndexPath*)indexPath

{
    NSMutableDictionary * infoDic = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithFile:kPath];
    
    UITableViewRowAction * deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction*_Nonnullaction,NSIndexPath*_NonnullindexPath) {
        //删除实现的代码（先网络请求删除后台的数据，成功回调后再删除本地数据）
        switch (indexPath.section) {
            case 0:
                [self.modelArr1 removeObjectAtIndex:indexPath.row];
                [infoDic[@"ad1"] removeObjectAtIndex:indexPath.row];
                break;
               
            case 2:
                [self.modelArr2 removeObjectAtIndex:indexPath.row];
                [infoDic[@"ad2"] removeObjectAtIndex:indexPath.row];
                break;
                
            case 3:
                [self.modelArr3 removeObjectAtIndex:indexPath.row];
                [infoDic[@"ad3"] removeObjectAtIndex:indexPath.row];
                break;
                
            case 4:
                [self.modelArr4 removeObjectAtIndex:indexPath.row];
                [infoDic[@"ad4"] removeObjectAtIndex:indexPath.row];
                break;
                
            case 5:
                [self.modelArr5 removeObjectAtIndex:indexPath.row];
                [infoDic[@"ad5"] removeObjectAtIndex:indexPath.row];
                break;
                
            default:
                break;
        }
        
        [NSKeyedArchiver archiveRootObject:infoDic toFile:kPath];
        
    }];
    
    UITableViewRowAction * editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //编辑是用的代码（跳转对应的广告条界面，并重新编辑保存数据，并将编辑好的数据上传后台，成功则删除原来数据并保存新数据到本地，失败则提醒用户网络状况较差，稍后再试）
        switch (indexPath.section) {
            case 0:{
                [self presentViewController:oneCTL animated:YES completion:^{
                    oneCTL.orderNum = [infoDic[@"ad1"][indexPath.row][@"orderNum"] integerValue];
                    oneCTL.adTextField.text = infoDic[@"ad1"][indexPath.row][@"adTitle"];
                    oneCTL.linkTextField.text = infoDic[@"ad1"][indexPath.row][@"url"];
                    oneCTL.imgData = infoDic[@"ad1"][indexPath.row][@"bgImg"];
                    if (oneCTL.orderNum == 44) {
                        oneCTL.selectedImg.center = CGPointMake(CGRectGetMaxX(oneCTL.hiddenBtn.frame), CGRectGetMinY(oneCTL.hiddenBtn.frame));
                        
                        [oneCTL.hiddenBtn setBackgroundImage:[UIImage imageWithData:oneCTL.imgData] forState:UIControlStateNormal];
                        [oneCTL.selectedImg removeFromSuperview];
                        oneCTL.selectedImg.size = CGSizeMake(20,20);
                        oneCTL.selectedImg.center = CGPointMake(CGRectGetMaxX(oneCTL.hiddenBtn.frame), CGRectGetMinY(oneCTL.hiddenBtn.frame));
                        
                        CGSize size = CGSizeMake(0, 840);
                        oneCTL.scrollView.contentSize = size;
                        
                        CGRect frame = oneCTL.photoLibraryBtn.frame;
                        frame = CGRectMake(10, 685, ScreenWidth-20, 90);
                        oneCTL.photoLibraryBtn.frame = frame;
                        
                        CGRect saveFrame = oneCTL.saveMessageBtn.frame;
                        saveFrame = CGRectMake(10, 790, ScreenWidth-20, 50);
                        oneCTL.saveMessageBtn.frame = saveFrame;

                    }else if(oneCTL.orderNum == 11)
                    {
                        [oneCTL buttonSelected:oneCTL.background1];
                    }else if(oneCTL.orderNum == 22)
                    {
                        [oneCTL buttonSelected:oneCTL.background2];
                    }else if(oneCTL.orderNum == 33)
                    {
                        [oneCTL buttonSelected:oneCTL.background3];
                    }
                }];}
                break;
            case 1:{
                [self presentViewController:twoCTL animated:YES completion:^{
                    twoCTL.adTitleTextField.text = infoDic[@"ad2"][indexPath.row][@"adTitle"];
                    twoCTL.adIntroductionTextField.text = infoDic[@"ad2"][indexPath.row][@"adDescrible"];
                    twoCTL.imgData = infoDic[@"ad2"][indexPath.row][@"imgData"];
                    [twoCTL.pictureBtn setBackgroundImage:[UIImage imageWithData:twoCTL.imgData] forState:UIControlStateNormal];
                    twoCTL.linkTextField.text = infoDic[@"ad2"][indexPath.row][@"url"];
                }];}
                break;
            case 2:{
                [self presentViewController:threeCTL animated:YES completion:^{
                    threeCTL.orderNum = [infoDic[@"ad3"][indexPath.row][@"orderNum"] integerValue];
                    if (threeCTL.orderNum == 44) {
                        threeCTL.selectedImg.center = CGPointMake(CGRectGetMaxX(oneCTL.hiddenBtn.frame), CGRectGetMinY(threeCTL.hiddenBtn.frame));
                    }else if(threeCTL.orderNum == 11)
                    {
                        [threeCTL buttonSelected:threeCTL.background1];
                    }else if(threeCTL.orderNum == 22)
                    {
                        [threeCTL buttonSelected:threeCTL.background2];
                    }else if(threeCTL.orderNum == 33)
                    {
                        [threeCTL buttonSelected:threeCTL.background3];
                    }
                    threeCTL.adTextField.text = infoDic[@"ad1"][indexPath.row][@"adTitle"];
                    threeCTL.linkTextField.text = infoDic[@"ad1"][indexPath.row][@"url"];
                    threeCTL.imgData = infoDic[@"ad1"][indexPath.row][@"bgImg"];
                }];}
                break;
            case 3:{
                [self presentViewController:fourCTL animated:YES completion:^{
                    //
                }];}
                break;
            case 4:{
                [self presentViewController:fiveCTL animated:YES completion:^{
                    //
                }];}
                break;
                
            default:
                break;
        }
    }];
    
    NSArray * array = @[deleteAction,editAction];
    return array;
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
