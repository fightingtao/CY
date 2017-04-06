//
//  OrderFeesChooseViewController.m
//  HSApp
//
//  Created by xc on 15/11/17.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "OrderFeesChooseViewController.h"

@interface OrderFeesChooseViewController ()

@property (nonatomic, strong) UITableView *feesTableView;
@property (nonatomic, strong) NSArray *tipsArray;

@end

@implementation OrderFeesChooseViewController
@synthesize delegate;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WhiteBgColor;
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH-40, 50)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = LittleFont;
        _titleLabel.textColor = TextMainCOLOR;
        _titleLabel.text = @"选择小费";
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_titleLabel];
    }
    
    if (!_cancalBtn) {
        _cancalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancalBtn.frame = CGRectMake(0,300, SCREEN_WIDTH-40, 50);
        [_cancalBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancalBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancalBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _cancalBtn.titleLabel.font = LittleFont;
        [self.view addSubview:_cancalBtn];
    }
    
    [self initpublishTableView];
    [self.view addSubview:_feesTableView];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!_tipsArray || _tipsArray.count == 0) {
        [self getTipsData];
    }
}
//初始化table
-(UITableView *)initpublishTableView
{
    if (_feesTableView != nil) {
        return _feesTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 50.0;
    rect.size.width = self.view.frame.size.width-40;
    rect.size.height = 250;
    
    self.feesTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _feesTableView.delegate = self;
    _feesTableView.dataSource = self;
    _feesTableView.backgroundColor = ViewBgColor;
    _feesTableView.showsVerticalScrollIndicator = NO;
    return _feesTableView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)getTipsData
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
    {
        NSString *hmacString = [[communcation sharedInstance] hmac:@"" withKey:userInfoModel.primaryKey];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            Out_TipsModel *outModel = [[communcation sharedInstance] getTipsWithKey:userInfoModel.key AndDigest:hmacString];
                dispatch_async(dispatch_get_main_queue(), ^{
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                    
                }else if (outModel.code ==1000)
                {
                    _tipsArray = outModel.data;
                    [_feesTableView reloadData];
                    
                }else{
                    [[iToast makeText:outModel.message] show];
                }
            });
                                       
        });
    }
    
   
}



#pragma tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_tipsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    for (id obj in cell.contentView.subviews)  {
        if ([obj isKindOfClass:[UILabel class]]) {
            UILabel* thelabel = (UILabel*)obj;
            [thelabel removeFromSuperview];
        }
    }
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH-40, 50)];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.font = LittleFont;
    contentLabel.textColor = TextMainCOLOR;
    contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:contentLabel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    OutTipsBody *model = [_tipsArray objectAtIndex:indexPath.section];
    contentLabel.text = [NSString stringWithFormat:@"%0.2f元",model.tip];
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OutTipsBody *model = [_tipsArray objectAtIndex:indexPath.section];
    [self.delegate chooseFeesWithModel:model];
    
}


- (void)cancelClick
{
    [self.delegate cancelFeesChoose];
}


@end
