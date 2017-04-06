//
//  BrokerDelegateViewController.m
//  HSApp
//
//  Created by cbwl on 16/5/1.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "BrokerDelegateViewController.h"
#import "publicResource.h"

@interface BrokerDelegateViewController ()

{
    UIScrollView *scrollview;
}

@property (nonatomic,retain) UIView *TitleView;

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@end

@implementation BrokerDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ViewBgColor;
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
        _titleLabel.text = @"经纪人协议";
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
    
    scrollview = [[UIScrollView alloc]init];
    scrollview.frame = self.view.bounds;
    if (SCREEN_HEIGHT ==480){
        scrollview.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 2850);
    }
    else if (SCREEN_HEIGHT ==568){
        scrollview.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 2850);
    }
    else if (SCREEN_HEIGHT ==667){
         scrollview.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 2550);
    }
    else if (SCREEN_HEIGHT ==736){
        scrollview.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 2350);
    }
   
    [self.view addSubview:scrollview];
    
    NSString *A = @"    在您向雏燕科技服务平台（以下简称雏燕）提交自由经纪人注册申请之前，您应当仔细阅读本协议方便注册。本协议将成为您和雏燕之间具有法律效应的文件。";
    NSString *B = @"    自由经纪人系具备完全民事行为能力的自然人。自由经纪人申请注册并经雏燕审核通过后，通过雏燕科技服务平台自主选择接受、完成任务事项，并在事项完成后获得任务事项信息发布方给付的相应报酬。自由经纪人自愿利用闲暇时间并根据自己的行程安排，自主选择是否接受雏燕科技服务平台上的任务事项信息，为雏燕用户提供服务完成任务事项；自由经纪人应当审慎、合理的选择雏燕科技服务平台上的任务事项信息，并自行承担因此产生的风险及损失，包括但不限于人身、财产损失等，自由经纪人确认因前述行为产生的风险及相应损失与雏燕科技服务平台无关。";
    NSString *C = @"    雏燕科技服务平台作为信息发布、服务平台，仅为平台用户提供信息服务，供用户自主选择发布、接受任务事项信息。雏燕不对任务事项信息的真实性或准确性及所涉物品的质量、安全或合法性等提供担保。您应自行谨慎判断确定相关信息的真实性、合法性和有效性，并自行承担因此产生的责任与损失。用户对本平台上任何信息资料的选择、接受，取决于用户自己并由其自行承担所有风险和责任。";
    NSString *D = @"    请您仔细阅读本条款，您勾选我已了解并接受 《自由经纪人注册协议》并经雏燕审核成功申请成为自由经纪人后，本协议条款即构成了对双方具有法律约束力的文件。";
    
    NSString * E = @"    一：自由经纪人业务操作流程";
    NSString * F = @"    1、每日登陆雏燕手机终端，时刻关注附近任务事项信息；";
    NSString * G = @"    2、根据自身行程和时间安排，选择是否接受任务事项；";
    NSString * H = @"    3、确认“接受”任务事项操作后，及时按系统提供的服务类型进行上门服务；";
    NSString * I = @"       3.1、代购服务";
    NSString * J = @"          3.1.1、接单后立即电联用户核实购买物品的价格、地址以及送达时间，是否需要小票等";
    NSString * K = @"          3.1.2、购买商品后需在手机端对应代购订单中点击“已购买”，并输入购买商品的实际费用（尽量索要购买商品的小票或票据，以便证明商品实际费用），送达后需在手机端所对应的代购订单中点击“请求确认”；";
    NSString * L = @"          3.1.3、请代购的用户在手机端所对应的代购订单中点击“收货确认”，然后跳转至支付界面进行在线支付；";
    NSString * M =@"           3.1.4、支付费用为代购商品费用和经纪人小费，完成在线支付后手机将收到系统即时推送的“已付款”消息。";
    NSString * N =@"           3.1.5、用户将对本次服务的自由经纪人做出评价后流程结束。";
    NSString * O =@"        3.2、代送服务";
    NSString * P =@"           3.2.1、接单后立即联系发货人核实订单真实性、告知到达时间、提醒发货人不要对货物封装需对其进行拍照验货；";
    NSString * Q =@"           3.2.2、按照预约时间并及时上门取货（如超时取货将可能被停用接单功能），并用手机自带相机功能对货物进行拍照验货；";
    NSString * R =@"           3.2.3、取货成功后，需立即致电收货人核实收货地址、约定送达时间后上门送货，完成送货后需在手机端所对应的代送订单中点击“请求确认”；";
    NSString * S =@"           3.2.4、请发布代送的用户在手机端所对应的代送订单中点击“收货确认”；然后跳转至支付界面经行在线支付；";
    NSString * T =@"           3.2.5、支付费用为经纪人小费，完成在线支付后手机将收到系统即时推送的“已付款”消息。";
    NSString * U =@"           3.2.6、用户将对本次服务的自由经纪人做出评价后流程结束。";
    
    NSString * V = @"        3.3、代办服务";
    NSString * W = @"           3.3.1、接单后立即电联用户核实代办事项（如代排队、代喝酒、代修车等）及具体办理时间要求等；";
    NSString * X = @"           3.3.2、按照代办的要求时间及时提供相应服务；";
    NSString * Y = @"           3.3.3、完成代办事项后，需在手机端所对应的代办订单中点击“请求确认”；";
    NSString * Z = @"           3.3.4、请发布代办的用户在手机端所对应的代办订单中点击“完成确认”；然后跳转至支付界面经行在线支付；";
    NSString * str1 = @"         3.3.5、支付费用为经纪人小费，完成在线支付后手机将收到系统即时推送的“已付款”消息。";
    NSString * str2 = @"         3.3.6、用户将对本次服务的自由经纪人做出评价后流程结束。";
    NSString * str3 = @"    4、完成任务事项过程中遇到异常问题可视情况先与信息发布方或者发布方指定的单位或个人进行协商，协商解决未果时，应及时反馈雏燕按照相关规定进行处理；";
    NSString * str4 = @"    5、自由经纪人如遇到信息发布方指定的单位或个人拒绝接受任务事项所涉物品或无法与其取得联系，导致任务事项延误等问题的，应主动与信息发布方或其指定的单位或个人协商解决，协商未果，应及时反馈雏燕协调处理。";
    NSString * str5 = @"    二：自由经纪人注意事项：";
    NSString * str6 = @"    1.有必要的电联：接单后及时联系用户核对服务需求，上门后及时联系用户收货；";
    NSString * str7 = @"    2.服务及时：按照用户要求的时间完成服务；";
    NSString * str8 = @"    3.接单前注意查看经纪人小费、收发货地址及重要提示（如体积较大的货物对自由经纪人的交通工具会有要求）；";
    NSString * str9 = @"    4.上门收货注意查验禁寄品；";
    NSString * str10 = @"    5.取消接单需谨慎：自由经纪人无故取消接单，两次将被停用接单功能；";
    NSString * str11 = @"    6.提倡一对一接单：平台提倡一对一接单，如无特殊情况，不要叫客户下楼来取，必须到收货地址当面确认；";
    NSString * str12 = @"    7. 禁止转单及私下接单，账号不得转借他人使用；接单后需本人完成派送；自由经纪人只能接雏燕平台上的订单，如果私下与发货客户进行联系将被立即停用相关功能；";
    NSString * str13=@"     8.其它注意事项";
    NSString * str14=@"      ①接单取货时将可能出现发货人拒绝开箱裸拍，所以自由经纪人在接单后致电客户提前说明需要验货拍照要求不要进行封装，预防此类情况的出现几率；如到达发货地址遇到发货人不同意开箱裸拍的，自由经纪人可向客户解释开箱验视并拍照的重要性，如对方仍然不同意开箱裸拍，自由经纪人可礼貌拒绝并向客服人员反映此情况；同时订单未开箱裸拍实物的自由经纪人，将可能被停用自由经纪人业务；②派单过程中，如两次不接听客服来电将可能被停用接单业务；";
    NSString * str15=@"      三、自由经纪人的报酬结算";
    NSString * str16=@"      1、	费用生成：基本小费+加价，费用是用户根据完成任务事项的难易程度，通过系统所发布的小费报酬；加价是客户为了使自己的订单能被自由经纪人尽快接单而主动增加的费用；";
    NSString * str17=@"      2、	代购：需要自由经纪人垫付商品费用，物品送达后由用户在线支付商品费用及经纪人小费；";
    NSString * str18=@"      3、	费用支付方式：信息发布方通过支付宝等方式在线支付报酬至雏燕账户，由雏燕收到经纪人的提现申请后，并扣除一定比例的技术服务费后向自由经纪人支付；";
    NSString * str19=@"      4、	提现：按照自由经纪人绑定的银行账号或其他账号信息（如支付宝等），直接对账户余额进行提现申请操作（提现的手续费由经纪人自行承担）；具体解释权归雏燕所有。";
    
    UILabel *a =[[UILabel alloc]init];
    a.frame = CGRectMake(10,10, SCREEN_WIDTH-20,[self rectWithStr:A]);
    a.text =A;
    [self WithLabel:a];
    
    UILabel *b =[[UILabel alloc]init];
    [self floatWithLabel:b WithStr:B WhichLab:a];
    b.text =B;
    [self WithLabel:b];
    
    UILabel *c =[[UILabel alloc]init];
    [self floatWithLabel:c WithStr:C WhichLab:b];
    c.text =C;
    [self WithLabel:c];
    
    UILabel *d =[[UILabel alloc]init];
    [self floatWithLabel:d WithStr:D WhichLab:c];
    d.text =D;
    [self WithLabel:d];
    
    UILabel *e =[[UILabel alloc]init];
    [self floatWithLabel:e WithStr:E WhichLab:d];
    e.text =E;
    [self WithLabel:e];
    
    UILabel *f =[[UILabel alloc]init];
    [self floatWithLabel:f WithStr:F WhichLab:e];
    f.text =F;
    [self WithLabel:f];
    
    UILabel *g =[[UILabel alloc]init];
    [self floatWithLabel:g WithStr:G WhichLab:f];
    g.text =G;
    [self WithLabel:g];
    
    UILabel *h =[[UILabel alloc]init];
    [self floatWithLabel:h WithStr:H WhichLab:g];
    h.text =H;
    [self WithLabel:h];
    
    UILabel *i =[[UILabel alloc]init];
    [self floatWithLabel:i WithStr:I  WhichLab:h];
    i.text =I;
    [self WithLabel:i];
    
    UILabel *j =[[UILabel alloc]init];
    [self floatWithLabel:j WithStr:J WhichLab:i];
    j.text =J;
    [self WithLabel:j];
    
    UILabel *k =[[UILabel alloc]init];
    [self floatWithLabel:k WithStr:K WhichLab:j];
    k.text =K;
    [self WithLabel:k];
    
    UILabel *l =[[UILabel alloc]init];
    [self floatWithLabel:l WithStr:L WhichLab:k];
    l.text =L;
    [self WithLabel:l];
    
    UILabel *m = [[UILabel alloc]init];
    [self floatWithLabel:m WithStr:M WhichLab:l];
    m.text =M;
    [self WithLabel:m];
    
    UILabel *n = [[UILabel alloc]init];
    [self floatWithLabel:n WithStr:N WhichLab:m];
    n .text =N;
    [self WithLabel:n];
    
    UILabel *o = [[UILabel alloc]init];
    [self floatWithLabel:o WithStr:O WhichLab:n];
    o.text =O;
    [self WithLabel:o];
    
    UILabel *p =[[UILabel alloc]init];
    [self floatWithLabel:p WithStr:P WhichLab:o];
    p.text =P;
    [self WithLabel:p];
    
    UILabel *q =[[UILabel alloc]init];
    [self floatWithLabel:q WithStr:Q WhichLab:p];
    q.text =Q;
    [self WithLabel:q];
    
    UILabel *r =[[UILabel alloc]init];
    [self floatWithLabel:r WithStr:R WhichLab:q];
    r .text =R;
    [self WithLabel:r];
    
    UILabel *s =[[UILabel alloc]init];
    [self floatWithLabel:s WithStr:S WhichLab:r];
    s.text =S;
    [self WithLabel:s];
    
    UILabel *t =[[UILabel alloc]init];
    [self floatWithLabel:t WithStr:T WhichLab:s ];
    t.text =T;
    [self WithLabel:t];
    
    UILabel *u =[[UILabel alloc]init];
    [self floatWithLabel:u WithStr:U WhichLab:t ];
    u .text =U;
    [self WithLabel:u];
    
    UILabel *v =[[UILabel alloc]init];
    [self floatWithLabel:v WithStr:V WhichLab:u ];
    v.text =V;
    [self WithLabel:v];
    
    UILabel *w =[[UILabel alloc]init];
    [self floatWithLabel:w WithStr:W WhichLab:v ];
    w.text =W;
    [self WithLabel:w];
    
    UILabel *x =[[UILabel alloc]init];
    [self floatWithLabel:x WithStr:X WhichLab:w ];
    x.text =X;
    [self WithLabel:x];
    
    UILabel *y =[[UILabel alloc]init];
    [self floatWithLabel:y WithStr:Y WhichLab:x ];
    y .text =Y;
    [self WithLabel:y];
    
    UILabel *z =[[UILabel alloc]init];
    [self floatWithLabel:z WithStr:Z WhichLab:y ];
    z.text =Z;
    [self WithLabel:z];
    
    UILabel *lab1 =[[UILabel alloc]init];
    [self floatWithLabel:lab1 WithStr:str1 WhichLab:z ];
    lab1.text =str1;
    [self WithLabel:lab1];
    
    UILabel *lab2 =[[UILabel alloc]init];
    [self floatWithLabel:lab2 WithStr:str2 WhichLab:lab1 ];
    lab2.text =str2;
    [self WithLabel:lab2];
    
    UILabel *lab3 =[[UILabel alloc]init];
    [self floatWithLabel:lab3 WithStr:str3 WhichLab:lab2 ];
    lab3.text =str3;
    [self WithLabel:lab3];
    
    UILabel *lab4 =[[UILabel alloc]init];
    [self floatWithLabel:lab4 WithStr:str4 WhichLab:lab3 ];
    lab4.text =str4;
    [self WithLabel:lab4];
    
    UILabel *lab5 =[[UILabel alloc]init];
    [self floatWithLabel:lab5 WithStr:str5 WhichLab:lab4 ];
    lab5.text =str5;
    [self WithLabel:lab5];
    
    UILabel *lab6 =[[UILabel alloc]init];
    [self floatWithLabel:lab6 WithStr:str6 WhichLab:lab5 ];
    lab6.text =str6;
    [self WithLabel:lab6];
    
    UILabel *lab7 =[[UILabel alloc]init];
    [self floatWithLabel:lab7 WithStr:str7 WhichLab:lab6 ];
    lab7.text =str7;
    [self WithLabel:lab7];
    
    UILabel *lab8 =[[UILabel alloc]init];
    [self floatWithLabel:lab8 WithStr:str8 WhichLab:lab7 ];
    lab8.text =str8;
    [self WithLabel:lab8];
    
    UILabel *lab9 =[[UILabel alloc]init];
    [self floatWithLabel:lab9 WithStr:str9 WhichLab:lab8 ];
    lab9.text =str9;
    [self WithLabel:lab9];
    
    UILabel *lab10 =[[UILabel alloc]init];
    [self floatWithLabel:lab10 WithStr:str10 WhichLab:lab9 ];
    lab10.text =str10;
    [self WithLabel:lab10];
    
    UILabel *lab11 =[[UILabel alloc]init];
    [self floatWithLabel:lab11 WithStr:str11 WhichLab:lab10 ];
    lab11.text =str11;
    [self WithLabel:lab11];
    
    UILabel *lab12 =[[UILabel alloc]init];
    [self floatWithLabel:lab12 WithStr:str12 WhichLab:lab11 ];
    lab12.text =str12;
    [self WithLabel:lab12];
    
    UILabel *lab13 =[[UILabel alloc]init];
    [self floatWithLabel:lab13 WithStr:str13 WhichLab:lab12 ];
    lab13.text =str13;
    [self WithLabel:lab13];
    
    UILabel *lab14 =[[UILabel alloc]init];
    [self floatWithLabel:lab14 WithStr:str14 WhichLab:lab13 ];
    lab14.text =str14;
    [self WithLabel:lab14];
    
    UILabel *lab15 =[[UILabel alloc]init];
    [self floatWithLabel:lab15 WithStr:str15 WhichLab:lab14 ];
    lab15.text =str15;
    [self WithLabel:lab15];
    
    UILabel *lab16 =[[UILabel alloc]init];
    [self floatWithLabel:lab16 WithStr:str16 WhichLab:lab15 ];
    lab16.text =str16;
    [self WithLabel:lab16];
    
    UILabel *lab17 =[[UILabel alloc]init];
    [self floatWithLabel:lab17 WithStr:str17 WhichLab:lab16 ];
    lab17.text =str17;
    [self WithLabel:lab17];
    
    UILabel *lab18 =[[UILabel alloc]init];
    [self floatWithLabel:lab18 WithStr:str18 WhichLab:lab17 ];
    lab18.text =str18;
    [self WithLabel:lab18];
    
    UILabel *lab19 =[[UILabel alloc]init];
    [self floatWithLabel:lab19 WithStr:str19 WhichLab:lab18 ];
    lab19.text =str19;
    [self WithLabel:lab19];
    
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

- (void)IntWithCode:(int)code
{
    
}

- (CGFloat )rectWithStr:(NSString *)str{
  CGRect rect = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:TextMainCOLOR} context:nil];
      return rect.size.height;
}

- (void)WithLabel:(UILabel *)label{
    
    label.textColor = TextMainCOLOR;
    label.numberOfLines = 0 ;
    label.lineBreakMode = UILineBreakModeCharacterWrap;
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = UITextAlignmentLeft;
    [scrollview addSubview:label];
}

- (void )floatWithLabel:(UILabel *)label WithStr:(NSString *)Str WhichLab:(UILabel *)WL{
    
    label.frame = CGRectMake(10,10+WL.frame.origin.y+WL.frame.size.height, SCREEN_WIDTH-20,[self rectWithStr:Str]);
}

- (void)leftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
