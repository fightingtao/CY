//
//  RegistDelegateViewController.m
//  HSApp
//
//  Created by cbwl on 16/5/1.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "RegistDelegateViewController.h"
#import "publicResource.h"

@interface RegistDelegateViewController ()

{
    UIScrollView *scrollview;
}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@end

@implementation RegistDelegateViewController

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
        _titleLabel.text = @"注册协议";
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
    scrollview.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 6500);
    if (SCREEN_HEIGHT == 667)
    {
        scrollview.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 5700);
    }
    if(SCREEN_HEIGHT == 736)
    {
        scrollview.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 5200);
    }
    
    [self.view addSubview:scrollview];
    
    NSString *A = @"    本服务条款是您与雏燕信息服务平台（包含雏燕网站、雏燕手机终端软件）的所有者-----“南京晟邦网络科技有限公司”（南京晟邦网络科技有限公司及其关联公司、雏燕信息服务平台在协议中统称为雏燕，通过雏燕信息服务平台为您提供服务）之间就雏燕提供的信息服务等相关事宜所订立的合约或合同。";
    NSString *B = @"    请您仔细阅读本条款，您勾选我已了解并接受《注册服务条款》并点击【立即注册】按钮注册成功后成为雏燕的正式会员，本服务条款即构成了对双方具有法律约束力的文件。";
    NSString *C = @"    第1条 定义";
    NSString *D = @"    雏燕信息服务平台，为提供及维护信息发布的服务平台。其为平台注册用户（信息发布方和接收方）提供信息中介和管理服务，并设计、开发信息服务产品，形成参考价格。";
    
    NSString * E = @"    平台注册用户是指通过雏燕信息服务平台完成全部注册程序后，使用雏燕信息服务平台服务的用户。";
    NSString * F = @"    自由经纪人，是指申请注册并经雏燕审核通过后，通过雏燕信息服务平台自主选择接受任务信息、完成任务事项，并在事项完成后获得信息发布方给付的相应报酬的平台注册用户。";
    NSString * G = @"    信息发布方，是指在雏燕信息服务平台上创建、发布任务事项信息的平台注册用户。";
    NSString * H = @"    信息接受方，是指在雏燕信息服务平台上勾选、接受已发布的任务事项信息的自由经纪人。";
    NSString * I = @"       第2条 服务条款的确认和接受";
    NSString * J = @"       2.1您应当在使用雏燕信息服务平台的服务之前认真阅读全部条款内容。如您对条款有任何疑问的，应向雏燕咨询。但无论您事实上是否在使用雏燕信息服务平台的服务之前认真阅读了本条款内容，只要您使用雏燕信息服务平台的服务，则本条款即对您产生约束，届时您不应以未阅读本条款的内容或者未获得雏燕对您问询的解答等理由，主张本条款无效，或要求撤销本条款。";
    NSString * K = @"       2.2用户必须完全同意所有服务条款并完成注册程序，才能成为雏燕的注册用户。在您按照注册页面提示填写信息、阅读并同意本条款并完成全部注册程序后或以其他雏燕允许的方式实际使用雏燕信息服务平台的服务时，您即受本条款的约束。";
    NSString * L = @"       2.3用户须确认，在完成注册程序或以其他雏燕允许的方式实际使用雏燕信息服务平台的服务时，应当是具备相应民事行为能力的自然人、法人或其他组织。如果不具备前述主体资格（如用户在18周岁以下），只能在父母或监护人的监护参与下才能使用雏燕创建或接受任务事项，且用户及其监护人应承担因此而导致的一切后果；雏燕有权注销该用户的账户。";
    NSString * M =@"        2.4当您在线下提供或接受服务的同时，您也承认了您拥有相应的权利能力和行为能力。您对提供或接受的任务事项的真实性、合法性负责，并能够独立承担法律责任。";
    NSString * N =@"        2.5用户确认：本协议条款是处理双方权利义务的当然约定依据，除非违反国家强制性法律，否则始终有效。";
    NSString * O =@"        2.6雏燕保留在中华人民共和国法律允许的范围内独自决定拒绝服务、关闭用户账户或取消任务事项的权利。";
    NSString * P =@"        2.7本协议内容包括协议正文及所有雏燕已经发布的或将来可能发布的各类规则。所有规则为本协议不可分割的组成部分，与协议正文具有同等法律效力。除另行明确声明外，任何雏燕及其关联公司提供的服务（以下称为雏燕信息服务平台的服务）均受本协议约束。您承诺接受并遵守本协议的约定。如果您不同意本协议的约定，您应立即停止注册程序或停止使用雏燕信息服务平台的服务。";
    NSString * Q =@"        2.8雏燕有权根据国家法律法规的更新、产品和服务规则的调整需要不时地制订、修改本协议或各类规则，并以网站公示的方式进行公示。如您继续使用雏燕信息服务平台的服务的，即表示您接受经修订的协议条款和规则。";
    NSString * R =@"        第3条 服务简介";
    NSString * S =@"        3.1用户在完全同意本协议条款及本信息服务平台规定的情况下，方才可以使用本信息服务平台的相关服务。";
    NSString * T =@"        3.2雏燕提供的服务为：搭建、提供及维护信息发布；为平台注册用户（信息发布方和接收方）提供信息中介和管理服务，并设计、开发信息服务产品，形成参考价格。具体包括：";
    NSString * U =@"        A、平台注册用户可以以信息发布方的身份通过雏燕信息服务平台上创建、发布任务事项信息，也申请注册成为自由经纪人（详见自由经纪人注册协议）后，作为信息接收方选择接受任务事项信息并完成任务事项。";
    
    NSString * V = @"       B、若作为信息接收方的自由经纪人同意为创建、发布任务事项信息的用户提供服务，则自由经纪人在雏燕信息服务平台上勾选接受该任务事项。";
    NSString * W = @"       C、接受任务事项的自由经纪人在向发布、创建任务事项信息的平台用户提供实际服务之前，双方均有权单方放弃任务事项；但雏燕有权根据平台注册用户放弃任务事项的情况，降低该用户相应的网站信用评级。";
    NSString * X = @"       3.3 信息发布方必须自行准备如下设备和承担如下开支：";
    NSString * Y = @"       A、上网设备，包括并不限于手机、电脑或者其他上网终端、调制解调器及其他必备的上网装置；";
    NSString * Z = @"       B、上网开支，包括并不限于网络接入费、上网设备租用费、手机流量费等。";
    NSString * str1 = @"    第4条 用户信息";
    NSString * str2 = @"    4.1用户应自行诚信向雏燕信息服务平台提供注册资料，用户保证其提供的注册资料真实、准确、完整、合法有效。用户注册资料如有变动的，应及时更新其注册资料。如果用户提供的注册资料不合法、不真实、不准确、不详尽的，需承担因此引起的相应责任及后果，并且雏燕保留终止其使用雏燕各项服务的权利。";
    NSString * str3 = @"    4.2用户在通过雏燕信息服务平台进行在线发布任务事项信息等活动时，涉及用户真实姓名/名称、履行地址、联系电话等隐私信息的，雏燕将予以严格保密，除非得到用户的授权或法律法规、本条款另有规（约）定外，雏燕不会向外界披露用户隐私信息。";
    NSString * str4 = @"    4.3用户注册成功后，将产生用户名和密码等账户信息，您可以根据雏燕信息服务平台的规定改变您的密码。用户应谨慎合理的保存、使用其用户名和密码并对通过您的账户和密码实施的所有行为、活动及事件负全责。用户若发现任何不当使用用户账号或存在安全漏洞等其他可能危及用户账户安全的情况，应当立即以有效方式通知雏燕，要求雏燕暂停相关服务，并向公安机关报案。您理解雏燕对您的请求采取行动需要合理时间，雏燕对在采取行动前已经产生的后果（包括但不限于您的任何损失）不承担任何责任。";
    NSString * str5 = @"    4.4雏燕或雏燕指定的区域管理公司对该区域内雏燕信息服务平台的运营进行监管。区管公司对在服务过程中了解到的其他用户的信息依照《中华人民共和国合同法》及相关协议的规定承担保密义务。自由经纪人只有在勾选“接受”任务事项后才能够看到信息发布方的详细信息。";
    NSString * str6 = @"   4.5用户同意：雏燕拥有通过邮件、短信、电话等形式，向在本平台注册的会员、区管公司、自由经纪人发送告知信息的权利。";
    
    NSString * str7 = @"   4.6用户不得将在本平台注册获得的账户借（租）给他人使用，否则用户应承担由此产生的全部责任，并与实际使用人承担连带责任。";
    NSString * str8 = @"   4.7用户同意：雏燕有权使用用户的注册信息、用户名、密码等信息，登陆进入用户的注册账户，进行证据保全，包括但不限于公证、见证等。";
    NSString * str9 = @"   4.8用户知悉并认可：雏燕可能会与第三方合作向用户提供相关的网络服务，在此情况下，如该第三方同意承担与雏燕同等的保护用户隐私的责任，则雏燕有权将用户的注册资料等提供给该第三方。另外，在不透露单个用户隐私资料的前提下，雏燕有权对整个用户数据库进行分析并对用户数据库进行商业上的利用。";
    NSString * str10 = @"  4.9您了解并同意，雏燕有权应政府部门（包括司法及行政部门）的要求，向其提供您在雏燕信息服务第5条 责任范围与责任限制";
    NSString * str11 = @"  第5条 责任范围与责任限制";
    NSString * str12=@"    5.1用户个人明确同意对网络服务的使用承担风险。雏燕对此不作任何类型的担保，不论是明确的或隐含的。包括但不限于：不担保服务一定能满足用户的要求，也不担保服务不会受中断，对服务的及时性，安全性，出错发生都不作担保；对在雏燕上以及相关产品得到的任何服务或交易进程，不作担保；对平台服务所涉及的技术及信息的有效性、准确性、正确性、可靠性、稳定性、完整性和及时性不作出任何承诺和保证；不担保平台服务的适用性、没有错误或疏漏、持续性、准确性、可靠性或适用于某一特定用途。";
    NSString * str13=@"    5.2用户理解并接受：雏燕信息服务平台作为信息发布、服务平台，无法控制每一任务事项所涉及的物品的质量、安全或合法性，任务事项内容的真实性或准确性，以及任务事项所涉各方履行任务事项的能力。您应自行谨慎判断确定相关信息的真实性、合法性和有效性，并自行承担因此产生的责任与损失。任何信息资料(下载或通过雏燕会员服务取得)，取决于用户自己并由其承担系统受损或资料丢失的所有风险和责任。";
    NSString * str14=@"    5.3除非法律法规明确要求，或出现以下情况，否则，雏燕没有义务对所有用户的信息数据、服务信息、任务发布行为以及与任务事项有关的其它事项进行事先审查：";
    NSString * str15=@"     （1）雏燕有合理的理由认为特定会员及具体任务事项可能存在重大违法或违约情形。";
    NSString * str16=@"     （2）雏燕有合理的理由认为用户在雏燕信息服务平台的行为涉嫌违法或不当。";
    NSString * str17=@"    5.4用户了解并同意，雏燕不对因下述情况而导致的任何损害赔偿承担责任，包括但不限于利润、商誉、使用、数据等方面的损失或其它无形损失的损害赔偿：";
    NSString * str18=@"     （1）使用或未能使用雏燕信息服务平台的服务；";
    NSString * str19=@"     （2）第三方未经批准地使用用户的账户或更改用户的数据；";
    NSString * str20=@"      (3）通过雏燕信息服务平台的服务购买或获取任何商品、样品、数据、信息等行为或替代行为产生的费用及损失;";
    NSString * str21=@"     （4）用户对雏燕信息服务平台的服务的误解；";
    NSString * str22=@"     （5）任何非因雏燕的原因而引起的与雏燕信息服务平台的服务有关的其它损失。";
    NSString * str23=@"      5.5如因不可抗力或其他雏燕无法控制的原因使雏燕系统崩溃或无法正常使用导致网上交易无法完成或丢失有关的信息、记录等，雏燕不承担责任。但是雏燕会尽可能合理地协助处理善后事宜，并努力使客户免受经济损失。";
    NSString * str24=@"      5.6用户同意在发现雏燕信息服务平台任何内容不符合法律规定，或不符合本用户协议条款规定的，有义务及时通知雏燕。如果用户发现个人信息被盗用或者其他权利被侵害，请将此情况告知雏燕并同时提供如下信息和材料：";
    NSString * str25=@"        (1）侵犯您权利的信息的网址，编号或其他可以找到该信息的细节；";
    NSString * str26=@"       (2）您的联系方式，包括联系人姓名，地址，电话号码和电子邮件；";
    NSString * str27=@"      （3）您的身份证复印件、营业执照等其他相关资料。经审查得到证实的，我们将及时删除相关信息。我们仅接受邮寄、电子邮件或传真方式的书面侵权通知。情况紧急的，您可以通过客服电话先行告知，我们会视情况采取相应措施。";
    NSString * str28 =@"     5.7用户应当严格遵守本协议及雏燕发布的其他协议条款、活动规则，因用户违反协议或规则的行为给第三方、或雏燕造成损失的，用户应当承担全部责任。 ";
    NSString * str29 =@"     第6条 对用户信息的存储和限制";
    NSString * str30 =@"     6.1雏燕不对用户所发布信息的删除或储存失败负责。雏燕有判定用户的行为是否符合雏燕服务条款的要求和精神的保留权利，如果用户违背了服务条款的规定，雏燕有中断对其提供网络服务的权利。";
    NSString * str31 =@"     6.2用户账户被注销后，雏燕没有义务为其保留或向其披露其账户中的任何信息，也没有义务向用户或第三方转发任何用户未曾阅读或发送过的信息。";
    NSString * str32 =@"     6.3用户同意，与雏燕的协议关系终止后，雏燕仍享有下列权利：";
    NSString * str33 =@"      （1）继续保存用户未及时删除的注册信息及使用雏燕信息服务平台的服务期间发布的所有信息至法律规定的记录保存期满。";
    NSString * str34 =@"       (2）用户在使用雏燕信息服务平台的服务期间存在违法行为或违反本协议和/或规则的行为的，雏燕仍可依据本协议向用户主张权利。";
    NSString * str35 =@"       第7条 网络服务内容的所有权";
    NSString * str36 = @"      7.1雏燕各项电子服务的所有权和运作权归雏燕。";
    NSString * str37 = @"      7.2雏燕网络服务内容包括：文字、软件、声音、图片、录像、图表、广告中的全部内容；电子邮件的全部内容；雏燕为用户提供的其他信息。所有这些内容受版权、商标、标签和其它财产所有权法律的保护。所以，用户只能在雏燕和广告商授权下才能使用这些内容，而不能擅自复制、再造这些内容、或创造与内容有关的派生产品。雏燕所有的文章版权归原文作者和雏燕共同所有，任何人需要转载本站的文章，必须征得原文作者或雏燕授权。";
    NSString * str38 = @"     7.3用户接受本协议条款，即表明该用户将其在雏燕网站发表的任何形式的信息的著作权，包括并不限于：复制权、发行权、出租权、展览权、表演权、放映权、广播权、信息网络传播权、摄制权、改编权、翻译权、汇编权以及应当由著作权人享有的其他可转让权利无偿独家转让给雏燕所有，同时表明该用户许可雏燕有权就任何主体侵权而单独提起诉讼，并获得全部赔偿。本协议效力及于用户在雏燕发布的任何受著作权法保护的作品内容，无论该内容形成于本协议签订前还是本协议签订后。同时，雏燕保留删除站内各类不符合规定的信息而不通知用户的权利。";
    NSString * str39 = @"     第8条 平台服务使用规范";
    NSString * str40 = @"    8.1用户无论是作为信息方发布方或接收方，须按照雏燕提供、发布的服务条款和操作规则严格执行。";
    NSString * str41 = @"    8.2在使用雏燕服务过程中，用户承诺遵守以下约定：";
    NSString * str42 = @"     （1）在使用雏燕信息服务平台的服务过程中实施的所有行为均遵守国家法律、法规等规范文件及雏燕信息服务平台的各项规则的规定和要求，不违背社会公共利益或公共道德，不损害他人的合法权益，不违反本协议及相关规则。您如果违反前述承诺，产生任何法律后果的，您应以自己的名义独立承担所有的法律责任，并确保雏燕免于因此产生任何损失。";
    NSString * str43 = @"     （2）不发布国家禁止发布的任务事项信息（除非取得合法且足够的许可），不发布涉嫌侵犯他人知识产权或其它合法权益的信息，不发布违背社会公共利益或公共道德、公序良俗的信息，不发布其它涉嫌违法或违反本协议及各类规则的信息。";
    NSString * str44 = @"      (3）不对雏燕信息服务平台上的任何数据作商业性利用，包括但不限于在未经雏燕事先书面同意的情况下，以复制、传播等任何方式使用雏燕信息服务平台上展示的资料。";
    NSString * str45 = @"      (4）不使用任何装置、软件或例行程序干预或试图干预雏燕信息服务平台的正常运作或正在雏燕信息服务平台上进行的任何活动。您不得采取任何将导致不合理的庞大数据负载加诸雏燕信息服务平台网络设备的行动。";
    NSString * str46 = @"     （5）不得发表、传送、传播、储存侵害他人知识产权、商业秘密权等合法权利的内容或包含病毒、木马、定时炸弹等可能对雏燕系统造成伤害或影响其稳定性的内容。";
    NSString * str47 = @"     （6）不得进行危害计算机网络安全的行为，包括但不限于：使用未经许可的数据或进入未经许可的服务器帐号；不得未经允许进入公众计算机网络或者他人计算机系统并删除、修改、增加存储信息；不得未经许可，企图探查、扫描、测试本平台系统或网络的弱点或其它实施破坏网络安全的行为；不得企图干涉、破坏本平台系统或网站的正常运行。 ";
    NSString * str48 = @"     8.3用户了解并同意： ";
    NSString * str49 = @"      （1）违反上述承诺时，雏燕有权依据本协议的约定，做出相应处理或终止向您提供服务，且无须征得您的同意或提前通知予您。";
    NSString * str50 = @"      （2）根据相关法令的指定或者雏燕服务规则的判断，用户的行为涉嫌违反法律法规的规定或违反本协议和/或规则的条款的，雏燕有权采取相应措施，包括但不限于直接屏蔽、删除侵权信息、降低信用值或直接停止提供服务。 ";
    NSString * str51 = @"      （3）对于用户在雏燕信息服务平台上实施的行为，包括未在雏燕信息服务平台上实施但已经对雏燕信息服务平台及其用户产生影响的行为，雏燕有权单方认定该行为的性质及是否构成对本协议和/或规则的违反，并据此采取相应的必要的处理措施。";
    NSString * str52 = @"      （4）对于用户涉嫌违反承诺的行为对任意第三方造成损害的，用户均应当以自己的名义独立承担所有的法律责任，并应确保雏燕免于承担因此产生的损失或增加的费用。";
    NSString * str53 = @"      （5）如用户涉嫌违反有关法律或者本协议之规定，使雏燕遭受任何损失，或受到任何第三方的索赔，或受到任何行政管理部门的处罚，用户应当赔偿雏燕因此造成的损失及发生的费用，包括合理的律师费用。";
    NSString * str54 = @"      第9条 法律管辖和适用";
    NSString * str55 = @"      本条款的订立、执行和解释及争议的解决均应适用中国法律。如双方就本条款内容或其执行发生任何争议，双方应尽力友好协商解决；协商不成时，任何一方均可向南京晟邦网络科技有限公司所在地的人民法院即南京市玄武区人民法院提起诉讼。";
    
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
    
    UILabel *lab20 =[[UILabel alloc]init];
    [self floatWithLabel:lab20 WithStr:str20 WhichLab:lab19 ];
    lab20.text =str20;
    [self WithLabel:lab20];
    
    UILabel *lab21 =[[UILabel alloc]init];
    [self floatWithLabel:lab21 WithStr:str21 WhichLab:lab20 ];
    lab21.text =str21;
    [self WithLabel:lab21];
    
    UILabel *lab22 =[[UILabel alloc]init];
    [self floatWithLabel:lab22 WithStr:str22 WhichLab:lab21 ];
    lab22.text =str22;
    [self WithLabel:lab22];
    
    UILabel *lab23 =[[UILabel alloc]init];
    [self floatWithLabel:lab23 WithStr:str23 WhichLab:lab22 ];
    lab23.text =str23;
    [self WithLabel:lab23];
    
    UILabel *lab24 =[[UILabel alloc]init];
    [self floatWithLabel:lab24 WithStr:str24 WhichLab:lab23 ];
    lab24.text =str24;
    [self WithLabel:lab24];
    
    UILabel *lab25 =[[UILabel alloc]init];
    [self floatWithLabel:lab25 WithStr:str25 WhichLab:lab24 ];
    lab25.text =str25;
    [self WithLabel:lab25];
    
    UILabel *lab26 =[[UILabel alloc]init];
    [self floatWithLabel:lab26 WithStr:str26 WhichLab:lab25 ];
    lab26.text =str26;
    [self WithLabel:lab26];
    
    UILabel *lab27 =[[UILabel alloc]init];
    [self floatWithLabel:lab27 WithStr:str27 WhichLab:lab26 ];
    lab27.text =str27;
    [self WithLabel:lab27];
    
    UILabel *lab28 =[[UILabel alloc]init];
    [self floatWithLabel:lab28 WithStr:str28 WhichLab:lab27 ];
    lab28.text =str28;
    [self WithLabel:lab28];
    
    UILabel *lab29 =[[UILabel alloc]init];
    [self floatWithLabel:lab29 WithStr:str29 WhichLab:lab28 ];
    lab29.text =str29;
    [self WithLabel:lab29];
    
    UILabel *lab30 =[[UILabel alloc]init];
    [self floatWithLabel:lab30 WithStr:str30 WhichLab:lab29 ];
    lab30.text =str30;
    [self WithLabel:lab30];
    
    UILabel *lab31 =[[UILabel alloc]init];
    [self floatWithLabel:lab31 WithStr:str31 WhichLab:lab30 ];
    lab31.text =str31;
    [self WithLabel:lab31];
    
    UILabel *lab32 =[[UILabel alloc]init];
    [self floatWithLabel:lab32 WithStr:str32 WhichLab:lab31 ];
    lab32.text =str32;
    [self WithLabel:lab32];
    
    UILabel *lab33 =[[UILabel alloc]init];
    [self floatWithLabel:lab33 WithStr:str33 WhichLab:lab32 ];
    lab33.text =str33;
    [self WithLabel:lab33];
    
    UILabel *lab34 =[[UILabel alloc]init];
    [self floatWithLabel:lab34 WithStr:str34 WhichLab:lab33 ];
    lab34.text =str34;
    [self WithLabel:lab34];
    
    UILabel *lab35 =[[UILabel alloc]init];
    [self floatWithLabel:lab35 WithStr:str35 WhichLab:lab34 ];
    lab35.text =str35;
    [self WithLabel:lab35];
    
    UILabel *lab36 =[[UILabel alloc]init];
    [self floatWithLabel:lab36 WithStr:str36 WhichLab:lab35 ];
    lab36.text =str36;
    [self WithLabel:lab36];
    
    UILabel *lab37 =[[UILabel alloc]init];
    [self floatWithLabel:lab37 WithStr:str37 WhichLab:lab36 ];
    lab37.text =str37;
    [self WithLabel:lab37];
    
    UILabel *lab38 =[[UILabel alloc]init];
    [self floatWithLabel:lab38 WithStr:str38 WhichLab:lab37 ];
    lab38.text =str38;
    [self WithLabel:lab38];
    
    UILabel *lab39 =[[UILabel alloc]init];
    [self floatWithLabel:lab39 WithStr:str39 WhichLab:lab38 ];
    lab39.text =str39;
    [self WithLabel:lab39];
    
    UILabel *lab40 =[[UILabel alloc]init];
    [self floatWithLabel:lab40 WithStr:str40 WhichLab:lab39 ];
    lab40.text =str40;
    [self WithLabel:lab40];
    
    UILabel *lab41 =[[UILabel alloc]init];
    [self floatWithLabel:lab41 WithStr:str41 WhichLab:lab40 ];
    lab41.text =str41;
    [self WithLabel:lab41];
    
    UILabel *lab42 =[[UILabel alloc]init];
    [self floatWithLabel:lab42 WithStr:str42 WhichLab:lab41 ];
    lab42.text =str42;
    [self WithLabel:lab42];
    
    
    UILabel *lab43 =[[UILabel alloc]init];
    [self floatWithLabel:lab43 WithStr:str43 WhichLab:lab42 ];
    lab43.text =str43;
    [self WithLabel:lab43];
    
    UILabel *lab44 =[[UILabel alloc]init];
    [self floatWithLabel:lab44 WithStr:str44 WhichLab:lab43 ];
    lab44.text =str44;
    [self WithLabel:lab44];
    
    UILabel *lab45 =[[UILabel alloc]init];
    [self floatWithLabel:lab45 WithStr:str45 WhichLab:lab44 ];
    lab45.text =str45;
    [self WithLabel:lab45];
    
    UILabel *lab46 =[[UILabel alloc]init];
    [self floatWithLabel:lab46 WithStr:str46 WhichLab:lab45 ];
    lab46.text =str46;
    [self WithLabel:lab46];
    
    UILabel *lab47 =[[UILabel alloc]init];
    [self floatWithLabel:lab47 WithStr:str47 WhichLab:lab46 ];
    lab47.text =str47;
    [self WithLabel:lab47];
    
    UILabel *lab48 =[[UILabel alloc]init];
    [self floatWithLabel:lab48 WithStr:str48 WhichLab:lab47 ];
    lab48.text =str48;
    [self WithLabel:lab48];
    
    UILabel *lab49 =[[UILabel alloc]init];
    [self floatWithLabel:lab49 WithStr:str49 WhichLab:lab48 ];
    lab49.text =str49;
    [self WithLabel:lab49];
    
    UILabel *lab50 =[[UILabel alloc]init];
    [self floatWithLabel:lab50 WithStr:str50 WhichLab:lab49 ];
    lab50.text =str50;
    [self WithLabel:lab50];
    
    UILabel *lab51 =[[UILabel alloc]init];
    [self floatWithLabel:lab51 WithStr:str51 WhichLab:lab50 ];
    lab51.text =str51;
    [self WithLabel:lab51];
    
    UILabel *lab52 =[[UILabel alloc]init];
    [self floatWithLabel:lab52 WithStr:str52 WhichLab:lab51 ];
    lab52.text =str52;
    [self WithLabel:lab52];
    
    UILabel *lab53 =[[UILabel alloc]init];
    [self floatWithLabel:lab53 WithStr:str53 WhichLab:lab52 ];
    lab53.text =str53;
    [self WithLabel:lab53];
    
    UILabel *lab54 =[[UILabel alloc]init];
    [self floatWithLabel:lab54 WithStr:str54 WhichLab:lab53 ];
    lab54.text =str54;
    [self WithLabel:lab54];
    
    UILabel *lab55 =[[UILabel alloc]init];
    [self floatWithLabel:lab55 WithStr:str55 WhichLab:lab54 ];
    lab55.text =str55;
    [self WithLabel:lab55];
    
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

- (void)leftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
