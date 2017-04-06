//
//  COrderDynamicViewController.m
//  HSApp
//
//  Created by xc on 15/11/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "COrderDynamicViewController.h"

#import "DynamicOrderTableViewCell.h"
#import "DynamicOrderCommentTableViewCell.h"
#import "DynamicPersonCommentTableViewCell.h"

#import "COrderDynamicCommentViewController.h"

#import "CommentViewController.h"

#import "UITableView+SDAutoTableViewCellHeight.h"

@interface COrderDynamicViewController ()<OrderDynamicDelegate,DynamicCommentDelegate>
{
    Out_OrderDynamicBody *_tempModel;
    
    long _lastDate;
    long _lastorderid;
    NSMutableArray *_commentArray;
}
@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITableView *dynamicTableView;

@property (nonatomic, strong) UIView *praiseView;//点赞用户头像区
@property (nonatomic, strong) UIScrollView *praiseScrollView;
@property (nonatomic, strong) UIImageView *praiseImg;//点赞


@property (strong, nonatomic)   AVAudioPlayer    *player;
@property (nonatomic, strong) UIView *maskView;//背景view
@property (nonatomic, strong) COrderDynamicCommentViewController *dynamicCommentVC;

@end

@implementation COrderDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WhiteBgColor;
    
    //添加头部菜单栏
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, 0, 150, 36)];
        _titleView.backgroundColor = [UIColor clearColor];
    }
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 150, 36)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = MiddleFont;
        _titleLabel.textColor = TextMainCOLOR;
        _titleLabel.text = @"呼单动态";
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleView addSubview:_titleLabel];
    }
    self.navigationItem.titleView = _titleView;
    
    UIButton *leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    leftItem.frame = CGRectMake(0, 0, 30, 30);
    [leftItem setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftItem addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItem];
    
    _commentArray = [[NSMutableArray alloc] init];
    
    //初始化table
    [self initdynamicTableView];
    [self.view addSubview:_dynamicTableView];
    
    _dynamicTableView.hidden = YES;
    
    //添加刷新控件
    [self.dynamicTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.dynamicTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    //点赞用户展示
    if (!_praiseView) {
        _praiseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _praiseView.backgroundColor = ViewBgColor;
    }
    
    if (!_praiseImg) {
        _praiseImg = [[UIImageView alloc] initWithFrame:CGRectMake(30, 12, 15, 15)];
        _praiseImg.image = [UIImage imageNamed:@"icon_dianzan"];
        [_praiseView addSubview:_praiseImg];
    }
    
    if (!_praiseScrollView) {
        _praiseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(50,0, SCREEN_WIDTH-50, 40)];
        _praiseScrollView.bounces = NO;
        _praiseScrollView.scrollEnabled = YES;
        _praiseScrollView.showsHorizontalScrollIndicator = NO;
        _praiseScrollView.showsVerticalScrollIndicator = NO;
        [_praiseView addSubview:_praiseScrollView];
    }
    
    
    //初始化录音提示页面
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44)];
        _maskView.backgroundColor = [UIColor lightGrayColor];
        _maskView.alpha = 0;
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maskViewTap)];
        [_maskView addGestureRecognizer:tapGesturRecognizer];
    }
    
    if (!_dynamicCommentVC) {
        _dynamicCommentVC = [[COrderDynamicCommentViewController alloc] init];
        _dynamicCommentVC.view.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 350);
        _dynamicCommentVC.view.backgroundColor = WhiteBgColor;
        _dynamicCommentVC.delegate = self;
    }

    [self getOrderDynamic];
    
    _lastDate = 0;
    _lastorderid = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_isGetOrder) {
        //生成顶部右侧按钮
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,50, 44)];
        UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 12, 50, 25)];
        [rightBtn setBackgroundColor:[UIColor clearColor]];
        [rightBtn setTitle:@"抢单" forState:UIControlStateNormal];
        [rightBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        rightBtn.titleLabel.font = MiddleFont;
        [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:rightBtn];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    }else
    {
        
    }
}

//初始化table
-(UITableView *)initdynamicTableView
{
    if (_dynamicTableView != nil) {
        return _dynamicTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height;
    
    self.dynamicTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _dynamicTableView.delegate = self;
    _dynamicTableView.dataSource = self;
    _dynamicTableView.backgroundColor = ViewBgColor;
    _dynamicTableView.showsVerticalScrollIndicator = NO;
    return _dynamicTableView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

///获取订单动态
- (void)getOrderDynamic
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"获取中";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSString *hamcString = [[communcation sharedInstance] hmac:_orderId withKey:userInfoModel.primaryKey];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_OrderDynamicModel *outModel = [[communcation sharedInstance] getOrderDynamicWithKey:userInfoModel.userId AndDigest:hamcString AndOrderId:_orderId];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                _tempModel = outModel.data;
                _praiseScrollView.contentSize = CGSizeMake(35*[_tempModel.zans count], 40);
                for (id obj in _praiseScrollView.subviews)  {
                    if ([obj isKindOfClass:[UIButton class]]) {
                        UIButton* theButton = (UIButton*)obj;
                        [theButton removeFromSuperview];
                    }
                }
                
                for (int i = 0; i < [_tempModel.zans count]; i++)
                {
                    OutZANSBody *model = [_tempModel.zans objectAtIndex:i];
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame = CGRectMake(25*i+10*i,7, 25, 25);
                    [btn setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.header]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon"]];
                    btn.tag = i;
                    btn.clipsToBounds = TRUE;
                    btn.layer.cornerRadius = 12;
                    btn.layer.borderWidth = 1.0;
                    btn.layer.borderColor =[UIColor clearColor].CGColor;
                    [_praiseScrollView addSubview:btn];
                    
                }
                [_dynamicTableView reloadData];
                _dynamicTableView.hidden = NO;
                [self getDynamicCommentList];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });
    
}

///获取评论列表
- (void)getDynamicCommentList
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];

    NSArray *dataArray = [[NSArray alloc] initWithObjects:_orderId,[NSString stringWithFormat:@"%ld",_lastDate],[NSString stringWithFormat:@"%ld",_lastorderid], nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];

    In_OrderDynamicCommentModel *inModel = [[In_OrderDynamicCommentModel alloc] init];
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.orderid = _orderId;
    inModel.lastDate = _lastDate;
    inModel.lastrowid = _lastorderid;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_OrderDynamicCommentModel *outModel = [[communcation sharedInstance] getOrderDynamicCommentListWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_dynamicTableView headerEndRefreshing];
            [_dynamicTableView footerEndRefreshing];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                if (_lastDate == 0) {
                    [_commentArray removeAllObjects];
                    for (int i = 0; i < outModel.data.count; i++) {
                        Out_OrderDynamicCommentBody *model = [outModel.data objectAtIndex:i];
                        [_commentArray addObject:model];
                    }
                }else
                {
                    if (outModel.data.count == 0) {
                        [[iToast makeText:@"没有啦！全部出来了!"] show];
                        return ;
                    }
                    for (int i = 0; i < outModel.data.count; i++) {
                        Out_OrderDynamicCommentBody *model = [outModel.data objectAtIndex:i];
                        [_commentArray addObject:model];
                    }
                }
                [_dynamicTableView reloadData];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}


#pragma mark tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return [_commentArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 42;
    }else
    {
        return 10;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return _praiseView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
         //Class currentClass = [DynamicOrderTableViewCell class];
        Out_OrderDynamicBody *model = _tempModel;
        // 推荐使用此普通简化版方法（一步设置搞定高度自适应，性能好，易用性好）
        //NSLog(@"%f",[_dynamicTableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:currentClass contentViewWidth:[self cellContentViewWith]]);
        //return [_dynamicTableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[DynamicOrderTableViewCell class] contentViewWidth:[self cellContentViewWith]];
        
        DynamicOrderTableViewCell *cell = [[DynamicOrderTableViewCell alloc]init];
        return [cell cellHeightWithModel: model];
        

    }else
    {
        return [DynamicOrderCommentTableViewCell cellHeightWithModel:@"测试"];
    }
    
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *cellName = @"DynamicOrderTableViewCell";
        DynamicOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[DynamicOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.delegate = self;
        cell.model = _tempModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        static NSString *cellName = @"DynamicOrderCommentTableViewCell";
        DynamicOrderCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[DynamicOrderCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        Out_OrderDynamicCommentBody *model = [_commentArray objectAtIndex:indexPath.row];
        [cell setOrderContentWithModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        Out_OrderDynamicCommentBody *model = [_commentArray objectAtIndex:indexPath.row];
        [self.view addSubview:_maskView];
        [self.view addSubview:_dynamicCommentVC.view];
        [UIView animateWithDuration:0.3 animations:^{
            _maskView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            _maskView.alpha = 0.5;
            _dynamicCommentVC.view.frame = CGRectMake(0, SCREEN_HEIGHT-100, SCREEN_WIDTH, 350);
            _dynamicCommentVC.parent_comment_id = model.commentid;
            [_dynamicCommentVC.demandTextView becomeFirstResponder];
        } completion: ^(BOOL finish){
            _dynamicCommentVC.placeLabel.text = [NSString stringWithFormat:@"回复:%@",model.username];
            _dynamicCommentVC.demandTextView.frame = CGRectMake(0, 40, SCREEN_WIDTH, 100);
        }];
    }

}


//顶部刷新和底部刷新
- (void)headerRereshing{
    _lastDate = 0;
    _lastorderid = 0;
    [self getOrderDynamic];
}

- (void)footerRereshing{
    
    if (_commentArray.count == 0) {
        [[iToast makeText:@"暂无评论"] show];
        [_dynamicTableView footerEndRefreshing];
    }else
    {
        Out_OrderDynamicCommentBody *model = [_commentArray objectAtIndex:_commentArray.count-1];
        _lastDate = model.create_date;
        _lastorderid = model.row_id;
        [self getDynamicCommentList];
    }
}

//导航栏左右侧按钮点击

- (void)leftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightItemClick
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"正在抢单...";

    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,[NSString stringWithFormat:@"%f",app.staticlat],[NSString stringWithFormat:@"%f",app.staticlng],_orderId, nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    In_GetOrderModel *inModel = [[In_GetOrderModel alloc] init];
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.userId = userInfoModel.userId;
    inModel.orderid = _orderId;
    inModel.lat = [NSString stringWithFormat:@"%f",app.staticlat];
    inModel.lng = [NSString stringWithFormat:@"%f",app.staticlng];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_GetOrderModel *outModel = [[communcation sharedInstance] getOrderWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                [[iToast makeText:@"抢单成功，请耐心等待雇主确认!"] show];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}

//--------------------------------------------------------------------

///展示订单图片
- (void)showOrderImgWithModel:(Out_OrderDynamicBody*)model AndIndex:(int)index
{
    ImgBrowser *ib = [[ImgBrowser alloc]init];
    [ib setImgaeArray:model.picpaths AndType:0];
    ib.currentIndex = index;
    [ib show];
}


///呼单动态中点赞
- (void)orderPraiseWithModel:(Out_OrderDynamicBody*)model
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"加载中";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,model.orderId, nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_OrderPraiseModel *outModel = [[communcation sharedInstance] orderPraiseWithKey:userInfoModel.key AndDigest:hamcString AndOrderId:model.orderId];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                if (outModel.data.zan_flag == 0) {
                    [[iToast makeText:@"取消点赞!"] show];
                }else
                {
                    [[iToast makeText:@"已经点赞!"] show];
                }
                [self headerRereshing];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}


///播放语音内容
- (void)playOrderVoiceWithModel:(Out_OrderDynamicBody*)model
{
    NSURL *url=[NSURL URLWithString:model.voicePath];
    NSData *audioData = [NSData dataWithContentsOfURL:url];
    
    //根据当前时间生成文件名
    NSString *tempFileName = [self GetCurrentTimeString];
    //获取路径
    NSString *tempRecordFilePath = [self GetPathByFileName:tempFileName ofType:@"amr"];
    [audioData writeToFile:tempRecordFilePath atomically:YES];
    NSString *convertedPath = [self GetPathByFileName:[tempFileName stringByAppendingString:@"_AmrToWav"] ofType:@"wav"];
    if ([VoiceConverter ConvertAmrToWav:tempRecordFilePath wavSavePath:convertedPath]==1) {
        self.player = [[AVAudioPlayer alloc]init];
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        self.player = [self.player initWithContentsOfURL:[NSURL URLWithString:convertedPath] error:nil];
        [self.player play];
    }else
        [[iToast makeText:@"改语音不能识别并播放1"] show];

}

///评论
- (void)dynamicCommentWithModel:(Out_OrderDynamicBody*)model
{

//    [self.view addSubview:_maskView];
//    [self.view addSubview:_dynamicCommentVC.view];
//    [UIView animateWithDuration:0.3 animations:^{
//        _maskView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//        _maskView.alpha = 0.5;
//        _dynamicCommentVC.view.frame = CGRectMake(0, SCREEN_HEIGHT-100, SCREEN_WIDTH, 350);
//        _dynamicCommentVC.parent_comment_id = @"0";
//    } completion: ^(BOOL finish){
//        _dynamicCommentVC.placeLabel.text = @"输入您的评论";
//
//    }];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    CommentViewController *comment = [[CommentViewController alloc]init];
    comment.tempModel = _tempModel;
    [comment.demandTextView becomeFirstResponder];
    [app.menuViewController pushToNewViewController:comment animation:YES];
    
}

#pragma DynamicCommentDelegate 评论代理实现
- (void)cancelDynamicComment
{
    [UIView animateWithDuration:0.3 animations:^{
        _dynamicCommentVC.view.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 350);
        _maskView.alpha = 0;
    } completion: ^(BOOL finish){
        [_dynamicCommentVC.view removeFromSuperview];
        [_maskView removeFromSuperview];
    }];
}

- (void)addDynamciCommentWithContent:(NSString*)content AndParent_comment_id:(NSString*)parent_comment_id
{
//    NSLog(@"parent>>>>>>>>%@",parent_comment_id);
    [UIView animateWithDuration:0.3 animations:^{
        _dynamicCommentVC.view.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 350);
        _maskView.alpha = 0;
    } completion: ^(BOOL finish){
        [_dynamicCommentVC.view removeFromSuperview];
        [_maskView removeFromSuperview];
       
        
        MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        mbp.labelText = @"评论中...";
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSData *userData = [userDefault objectForKey:UserKey];
        UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        
        NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,_orderId,_dynamicCommentVC.parent_comment_id,content, nil];
        NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
        In_AddDynamicCommentModel *inModel = [[In_AddDynamicCommentModel alloc] init];
        inModel.key = userInfoModel.userId;
        inModel.digest = hamcString;
        inModel.user_id = userInfoModel.userId;
        inModel.order_id = _orderId;
        inModel.content = content;
        inModel.parent_comment_id = _dynamicCommentVC.parent_comment_id;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            Out_AllSameModel *outModel = [[communcation sharedInstance] addCommentToOrderDynamicWithModel:inModel];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                    
                }else if (outModel.code ==1000)
                {
                    [[iToast makeText:@"您已成功评论!"] show];
                    [self headerRereshing];
                }else{
                    [[iToast makeText:outModel.message] show];
                }
            });
            
        });

    }];
}

//----------------------------------------------------------------

- (void)commentFromList
{
    [self.view addSubview:_maskView];
    [self.view addSubview:_dynamicCommentVC.view];
    [UIView animateWithDuration:0.3 animations:^{
        _maskView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _maskView.alpha = 0.5;
        _dynamicCommentVC.view.frame = CGRectMake(0, SCREEN_HEIGHT-350, SCREEN_WIDTH, 350);
        _dynamicCommentVC.parent_comment_id = @"0";
        [_dynamicCommentVC.demandTextView becomeFirstResponder];
    } completion: ^(BOOL finish){
        _dynamicCommentVC.demandTextView.frame = CGRectMake(0, 40, SCREEN_WIDTH, 100);
         _dynamicCommentVC.placeLabel.text = @"输入您的评论";
    }];
}


- (void)maskViewTap
{
    [self cancelDynamicComment];
}
#pragma mark - 生成当前时间字符串
- (NSString*)GetCurrentTimeString{
    NSDateFormatter *dateformat = [[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMddHHmmss"];
    return [dateformat stringFromDate:[NSDate date]];
}

#pragma mark - 生成文件路径
- (NSString*)GetPathByFileName:(NSString *)_fileName ofType:(NSString *)_type{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];;
    NSString* fileDirectory = [[[directory stringByAppendingPathComponent:_fileName]
                                stringByAppendingPathExtension:_type]
                               stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return fileDirectory;
}

@end
