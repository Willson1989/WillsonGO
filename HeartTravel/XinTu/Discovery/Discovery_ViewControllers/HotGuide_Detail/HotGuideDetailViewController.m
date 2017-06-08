//
//  HotGuideDetailViewController.m
//  XinTu
//
//  Created by WillHelen on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "HotGuideDetailViewController.h"

#define OTHER_TOTAL_HEIGHT 89.0f

@interface HotGuideDetailViewController ()<TopNavigationViewDelegate,UITableViewDataSource,UITableViewDelegate,MONActivityIndicatorViewDelegate,FunctionViewDelegate>

@end

@implementation HotGuideDetailViewController

-(void)dealloc{
    
    [self.topNavView release];
    [self.myTableView release];
    [self.hGuide release];
    [self.pGuide release];
    [self.topImageV release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.appeared = NO;
    [self getGuideDetailDataByAFN];
    [self setupTableView];
    [self setupNavigationView];
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
    [self.MONAView release];
}

-(UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView circleBackgroundColorAtIndex:(NSUInteger)index{
    return SELECT_COLOR;
}

-(void)setupNavigationView{
    self.topNavView = [[TopNavigationView alloc]initWithFrame:CGRectMake(0, 0, TOP_IMAGE_WIDTH, 64)];
    self.topNavView.myDelegate = self;
    [self.topNavView setAlphaforSubViews:1.0];
    [self.view addSubview:self.topNavView];
    [self.topNavView.rightButton setImage:[UIImage imageNamed:MORE_IMAGE] forState:UIControlStateNormal];
    self.funcView = [[FunctionView alloc]initWithFrame:CGRectMake(MYWIDTH,
                                                                  64,
                                                                  60*WIDTHR,
                                                                  80*HEIGHTR)];
    [self.view addSubview:self.funcView];
    self.funcView.myDelegate = self;
    [self hideButtons];
}

-(void)navigationViewRightButtonClicked{
    if (self.appeared == NO) {
        self.appeared = YES;
        [self showFuncView];
    }
    else{
        self.appeared = NO;
        [self hideFuncView];
    }
}

-(void)hideButtons{
    self.topNavView.rightButton.hidden = YES;
    self.topNavView.rightButton.userInteractionEnabled = NO;
}

-(void)showButtons{
    self.topNavView.rightButton.hidden = NO;
    self.topNavView.rightButton.userInteractionEnabled = YES;
}

-(void)showFuncView{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect tempFrame = self.funcView.frame;
        tempFrame.origin.x = MYWIDTH - self.funcView.frame.size.width;
        self.funcView.frame = tempFrame;
    }];
}
    
-(void)hideFuncView{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect tempFrame = self.funcView.frame;
        tempFrame.origin.x = MYWIDTH;
        self.funcView.frame = tempFrame;
    }];
}

-(void)doShare{
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"557fc76c67e58e929b004b07"
                                      shareText:[NSString stringWithFormat:@"在#心途APP#上发现了一个有趣的当地特色【%@】", self.hGuide.title]
                                     shareImage:self.topImageV.image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
                                       delegate:self];
}

-(void)doCollect{
    
    NSMutableDictionary *dic = [[SQLDataHandle shareDataHandle] selectFeatureDollectList:self.hGuide.title];
    
    if ([dic.allKeys containsObject:self.hGuide.title]) {
        
        UIAlertView *errorAler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已收藏" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:NULL, nil];
        [errorAler show];
    }else{
        
        [[SQLDataHandle shareDataHandle] insertFeatureDollectList:self.hGuide.title andId:self.guideID];
        
        UIAlertView *successAler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收藏成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:NULL, nil];
        [successAler show];
        
    }
}

#pragma mark - 创建TableView
-(void)setupTableView{
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MYWIDTH, CGRectGetHeight([[UIScreen mainScreen] bounds])) style:UITableViewStylePlain];
    self.myTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    CGFloat guideHeight = IMAGE_HEIGHT - 20;
    self.myTableView.contentInset = UIEdgeInsetsMake(guideHeight, 0, 0, 0);
    self.topImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, -guideHeight, MYWIDTH, guideHeight)];
    self.topImageV.clipsToBounds = NO;
    [self.myTableView addSubview:self.topImageV];
    [self.view addSubview:self.myTableView];
    [self.topImageV release];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else{
        return self.hGuide.pointArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGFloat height = [PublicFunction heightForSubView:self.hGuide.guideDesc andWidth:[[UIScreen mainScreen]bounds].size.width - 15*2 andFontOfSize:COMMON_FONT_SIZE - 1];
        return (height + OTHER_TOTAL_HEIGHT + 20);
    }
    else{
        PointGuide * pGuide = [[PointGuide alloc]init];
        pGuide = [self.hGuide.pointArray objectAtIndex:indexPath.row];
        CGFloat detailHeight = [PublicFunction heightForSubView:pGuide.pointDesc andWidth:[[UIScreen mainScreen]bounds].size.width - 15*2 andFontOfSize:GUIDE_DETAIL_FONT_SIZE];
        return (detailHeight + GUIDE_DETAIL_IMAGE_HEIGHT + 25);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSString * titleID = @"titleCell";
        GuideListTitleCell * titleCell = [tableView dequeueReusableCellWithIdentifier:titleID];
        if (titleCell == nil) {
            titleCell = [[GuideListTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleID];
        }
        titleCell.hotGuide = self.hGuide;
        [self.view bringSubviewToFront:titleCell];
        titleCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return titleCell;
    }
    else {
        NSString * detailID = @"detailCell";
        GuideDetailCell * detailCell = [tableView dequeueReusableCellWithIdentifier:detailID];
        if (detailCell == nil) {
            detailCell = [[GuideDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailID];
        }
        detailCell.poiGuide = [self.hGuide.pointArray objectAtIndex:indexPath.row];
        detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return detailCell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WayPointDetailViewController * wpDetailVC = [[WayPointDetailViewController alloc]init];
    wpDetailVC.poi_id = [[self.hGuide.pointArray objectAtIndex:indexPath.row] pointID];
    [self.navigationController pushViewController:wpDetailVC animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = (self.myTableView.contentOffset.y - self.myTableView.frame.origin.y + IMAGE_HEIGHT)/SCROLL_HEIGHT*2.3;
    CGFloat alpha = 0.9 * y;
    [self.topNavView setAlphaforSubViews:alpha];
    [PublicFunction ChangeFrameOfTopImageView1:self.topImageV andTableView:self.myTableView];
}

-(void)getGuideDetailDataByAFN{
    NSString * urlStr = [NSString stringWithFormat:GUIDE_DETAIL_URL,self.guideID,self.page];
    [PublicFunction getDataByAFNetWorkingWithURL:urlStr Success:^(id data) {
        NSMutableDictionary * dataDic = [(NSMutableDictionary *)data objectForKey:@"data"];
        NSMutableArray * poiArray = [dataDic objectForKey:@"pois"];
        self.hGuide = [[HotGuide alloc]init];
        [self.hGuide setValuesForKeysWithDictionary:dataDic];
        self.topImageV.image = [PublicFunction requestImageWithURL:self.hGuide.photo];
        for (NSDictionary * dic  in poiArray) {
            PointGuide * pGuide = [[PointGuide alloc]init];
            [pGuide setValuesForKeysWithDictionary:dic];
            [self.hGuide.pointArray addObject:pGuide];
        }
        [self reloadTableView];
        [self showButtons];
        [self.MONAView stopAnimating];
        [self.topNavView setAlphaforSubViews:0.0];
        [self.myTableView footerEndRefreshing];
        
    } failure:^{
        [self.MONAView stopAnimating];
        [PublicFunction showAlertViewWithTitle:@"提示" andMessage:@"网络连接失败" forViewController:self cancelButtonTitle:nil];
    }];
    
}

-(void)reloadTableView{
    if (self.myTableView != nil) {
        [self.myTableView reloadData];
    }
}

-(void)navigationViewReturnButtonClicked{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)addFooterRefresher{
    [self.myTableView addFooterWithCallback:^{
        self.page++;
        [self getGuideDetailDataByAFN];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
