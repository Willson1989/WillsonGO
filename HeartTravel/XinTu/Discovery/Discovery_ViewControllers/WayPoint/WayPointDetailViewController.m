//
//  WayPointDetailViewController.m
//  XinTu
//
//  Created by WillHelen on 15/6/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "WayPointDetailViewController.h"



@interface WayPointDetailViewController ()<UITableViewDataSource,UITableViewDelegate,TopNavigationViewDelegate,MONActivityIndicatorViewDelegate>

@end

@implementation WayPointDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperties];
    [self setupNavigationView];
    [self getWayPointDetailDataByAFN];
    [self setupNavigationItem];
    [self initMONA];
}


-(void)initMONA{
    self.MONAView = [[MONActivityIndicatorView alloc] init];
    self.MONAView.delegate = self;
    self.MONAView.numberOfCircles = 3;
    self.MONAView.radius = 10;
    self.MONAView.internalSpacing = 3;
    self.MONAView.center = self.view.center;
        [self.MONAView startAnimating];
    [self.view addSubview:self.MONAView];
    
}

-(UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView circleBackgroundColorAtIndex:(NSUInteger)index{
    return SELECT_COLOR;
}

-(void)initProperties{
    self.view.backgroundColor = [UIColor whiteColor];
    self.keyArray = [NSArray array];
    self.descDic = [NSMutableDictionary dictionary];
    self.isExtend = NO;
    self.isFirstLoad = YES;
}

-(void)setupNavigationItem{
    [PublicFunction setupNavigationBarforViewController:self];
    
}

-(void)setupTableView{
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    CGRectGetWidth([[UIScreen mainScreen]bounds]),
                                                                    CGRectGetHeight([[UIScreen mainScreen]bounds]))
                                                   style: UITableViewStylePlain];
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.view addSubview:self.myTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat guideHeight = IMAGE_HEIGHT ;

    self.myTableView.contentInset = UIEdgeInsetsMake(guideHeight, 0, 0, 0);
    self.topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -guideHeight, self.view.frame.size.width, guideHeight)];
    self.topImageView.clipsToBounds = NO;
    [self.myTableView addSubview:self.topImageView];
    [self.view addSubview:self.myTableView];
    [self.topImageView release];
}

-(void)setupNavigationView{
    self.topNavView = [[TopNavigationView alloc]initWithFrame:CGRectMake(0, 0, TOP_IMAGE_WIDTH, 64)];
    self.topNavView.myDelegate = self;
    [self.topNavView setAlphaforSubViews:1.0];
    self.topNavView.rightButton.hidden = YES;
    self.topNavView.rightButton.userInteractionEnabled = NO;

    [self.view addSubview:self.topNavView];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //self.myTableView.contentOffset.y总是从-20开始,有待调查
    CGFloat y = (self.myTableView.contentOffset.y - self.myTableView.frame.origin.y + IMAGE_HEIGHT - 20)/SCROLL_HEIGHT*2.3;
    CGFloat alpha = 0.9 * y;
    [self.topNavView setAlphaforSubViews:alpha];
    [PublicFunction ChangeFrameOfTopImageView1:self.topImageView andTableView:self.myTableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 1;
    }
    else{
        return self.descDic.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        self.cell0 = [[WayPointDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell0" andOption:0];
        self.cell0.wayPoint = self.wPoint;
        self.cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return  self.cell0;
    }
    else if (indexPath.section == 1){
        self.cell1 = [[WayPointDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1" andOption:1];
        self.cell1.wayPoint = self.wPoint;
        [self setHeightForLabel:self.cell1.introLabel];
        self.cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.cell1;
    }
    else if (indexPath.section == 2){
        WayPointDetailCell * descCell = [tableView dequeueReusableCellWithIdentifier:@"descCell"];
        if (!descCell) {
            descCell = [[WayPointDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"descCell" andOption:2];
        }
        self.keyArray = [self.descDic allKeys];
        NSString * key = [self.keyArray objectAtIndex:indexPath.row];
        descCell.descTitle.text = key;
        descCell.descContent.text = [self.descDic objectForKey:key];
        //高度自适应
        [self setHeightForLabel:descCell.descContent];
        self.cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return  descCell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen]bounds]);
    if (indexPath.section == 0) {
        return screenWidth/3.5;
    }
    else if (indexPath.section == 1){
        CGFloat normal_height = screenWidth/3.5 - WP_DETAIL_CELL_INSET*2 - screenWidth/10.5;
        NSString * content = self.wPoint.introduction;
        CGRect tempFrame = self.cell1.introLabel.frame;
        CGFloat height = [PublicFunction heightForSubView:content andWidth:screenWidth -WP_DETAIL_CELL_INSET*2 andFontOfSize:MAIN_FONT_SIZE];

        if (self.isExtend == YES) {
            if (height <= normal_height) {
                [self setHeightForLabel:self.cell1.introLabel];
                return screenWidth/3.5;
            }
            else{
                [self setHeightForLabel:self.cell1.introLabel];
                return (height + WP_DETAIL_CELL_INSET*2 + screenWidth/10.5);
            }
        }
        else{
            [self setHeightForLabel:self.cell1.introLabel];
            tempFrame.size.height = screenWidth/3.5 - WP_DETAIL_CELL_INSET*2 - screenWidth/10.5;
            self.cell1.introLabel.frame = tempFrame;
            return screenWidth/3.5;
        }
    }
    else{
        NSString * content = [self.descDic objectForKey:[self.keyArray objectAtIndex:indexPath.row]];
        CGFloat height = [PublicFunction heightForSubView:content andWidth:screenWidth - WP_DETAIL_CELL_INSET*2 andFontOfSize:MAIN_FONT_SIZE];
        CGFloat normal_height = screenWidth/3.5 - WP_DETAIL_CELL_INSET*2 - screenWidth/10.5;
        if (height <= normal_height) {
            return screenWidth/3.5;
        }
        else{
            return (height + WP_DETAIL_CELL_INSET*3 + screenWidth/10.5);
        }
    }
}


-(void)setHeightForLabel:(UILabel *)label{
    CGRect tempFrame = label.frame;
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen]bounds]) - WP_DETAIL_CELL_INSET*2;
    CGFloat height = [PublicFunction heightForSubView:label.text andWidth:width andFontOfSize:MAIN_FONT_SIZE];
    tempFrame.size.height = height;
    label.frame = tempFrame;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (self.isExtend == YES) {
            self.isExtend = NO;
        }
        else{
            self.isExtend = YES;
        }
        [tableView beginUpdates];
        [tableView endUpdates];
    }
}



-(void)getWayPointDetailDataByAFN{
    NSString * urlStr = [NSString stringWithFormat:WAYPOINT_DETAIL_URL,self.poi_id];
    [PublicFunction getDataByAFNetWorkingWithURL:urlStr Success:^(id data) {
        NSMutableDictionary * dataDic = [(NSMutableDictionary * )data objectForKey:@"data"];
        self.wPoint = [[WayPoint alloc]init];
        [self.wPoint setValuesForKeysWithDictionary:dataDic];
        [self setWayPointDescDicWithWayPoint:self.wPoint];
        [self setupTableView];
        [self.MONAView stopAnimating];
        self.topImageView.image = [PublicFunction requestImageWithURL:self.wPoint.photo];
        [self.topNavView setAlphaforSubViews:0.0];
        [self.view bringSubviewToFront:self.topNavView];
        self.topNavView.cnnameLabel.text = self.cname;
        self.topNavView.ennameLabel.text = self.ename;
        self.myTableView.contentOffset = CGPointMake(0, -240);
        
    } failure:^{
        [self.MONAView stopAnimating];
        [PublicFunction showAlertViewWithTitle:@"提示" andMessage:@"网络连接失败" forViewController:self cancelButtonTitle:nil];
    }];

}

-(void)setWayPointDescDicWithWayPoint:(WayPoint *)wpoi{
    
    self.descDic = [NSMutableDictionary dictionary];
    if (![wpoi.address isEqualToString:@""]) {
        [self.descDic setObject:wpoi.address forKey:@"地址"];
    }
    if (![wpoi.wayto isEqualToString:@""]) {
        [self.descDic setObject:wpoi.wayto forKey:@"路线"];
    }
    if (![wpoi.opentime isEqualToString:@""]) {
        [self.descDic setObject:wpoi.opentime forKey:@"开放时间"];
    }
    if (![wpoi.price isEqualToString:@""]) {
        [self.descDic setObject:wpoi.price forKey:@"门票"];
    }
    if (![wpoi.phone isEqualToString:@""]) {
        [self.descDic setObject:wpoi.phone forKey:@"电话"];
    }
    if (![wpoi.site isEqualToString:@""]) {
        [self.descDic setObject:wpoi.site forKey:@"网址"];
    }
    self.keyArray = [self.descDic allKeys];
}


-(void)navigationViewReturnButtonClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
