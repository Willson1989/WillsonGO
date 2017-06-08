//
//  RecommTravelViewController.m
//  XinTu
//
//  Created by WillHelen on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "RecommTravelViewController.h"

@interface RecommTravelViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation RecommTravelViewController

-(void)dealloc{

    [self.myTableView release];
    [self.travelListArray release];
    self.myDelegate = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperties];
    [self getRecomTravelDataByAFN];
}

-(void)initProperties{
    self.firstLoad = YES;
    self.isUpLoad = NO;
    self.page = 1;
    self.travelListArray = [NSMutableArray array];
}

-(void)setupTableView{
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,TOP_BAR_HEIGHT + 64 , CGRectGetWidth([[UIScreen mainScreen]bounds]), CGRectGetHeight([[UIScreen mainScreen]bounds]) - TOP_BAR_HEIGHT) style:UITableViewStylePlain];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.view addSubview:self.myTableView];
    [self addFooterRefresher];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.travelListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"trCell";
    RecomTravelListCell * rtCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (rtCell == nil) {
        rtCell = [[RecomTravelListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    rtCell.myTravel = [self.travelListArray objectAtIndex:indexPath.row];
    return rtCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return TRAVEL_LIST_HEIGHT;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *urlStr = [[self.travelListArray objectAtIndex:indexPath.row] view_url];
    [self.myDelegate gotoTravelDetailPageWithURL:urlStr];
}

-(void)getRecomTravelDataByAFN{
    NSString * urlStr = [NSString stringWithFormat:RECOM_TRAVEL_LIST_URL,self.idType,self.itemID,self.page,self.recommandType,self.itemType];
    [PublicFunction getDataByAFNetWorkingWithURL:urlStr Success:^(id data) {
        NSArray * dataArray = [(NSMutableDictionary*)data objectForKey:@"data"];
        for (NSDictionary * dic  in dataArray) {
            RecomTravel * rTravel = [[RecomTravel alloc]init];
            [rTravel setValuesForKeysWithDictionary:dic];
            [self.travelListArray addObject:rTravel];
            [rTravel release];
        }
        if (self.firstLoad == YES) {
            self.firstLoad = NO;
            if (self.travelListArray.count == 0) {
                [self setupNoneView];
            }
            else{
                [self setupTableView];
                if (self.travelListArray.count < 20) {
                    [self.myTableView removeFooter];
                }
            }
        }
        else{
            [self.myTableView reloadData];
            [self.myTableView footerEndRefreshing];
        }
    }];
}

-(void)addFooterRefresher{
    [self.myTableView addFooterWithCallback:^{
        if (self.travelListArray.count >= 60 ) {
            [self.myTableView footerEndRefreshing];
            [self.myTableView removeFooter];
        }
        else{
            self.page++;
            [self getRecomTravelDataByAFN];
        }
    }];
}



-(void)setupNoneView{
    NoneView * nView = [[NoneView alloc]initWithFrame:[[UIScreen mainScreen]bounds] withTitle:@"没有相关推荐行程"];
    [self.view addSubview:nView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
