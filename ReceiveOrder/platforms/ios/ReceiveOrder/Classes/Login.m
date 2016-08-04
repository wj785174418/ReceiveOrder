//
//  ViewController.m
//  ReceiveOrder
//
//  Created by HuayuNanyan on 16/7/25.
//
//

#import "Login.h"
#import "TabBarController.h"
#import "UIView+MJExtension.h"
#import "CustomViews/WJPromptLabel.h"
#import "UIView+MJExtension.h"
#import "Macro/Keys.h"
#import "FirstStep.h"
#import "RegisterController.h"
#import "AppDelegate.h"

@interface Login ()
@property (weak, nonatomic) IBOutlet UITextField *txtUser;
@property (weak, nonatomic) IBOutlet UITextField *txtValidation;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIButton *btnValidation;
//验证码倒计时定时器
@property (strong, nonatomic) NSTimer *countdown;
//验证码倒计时
@property (assign, nonatomic) int countdownNum;
//提示label
@property (weak, nonatomic) WJPromptLabel *promptLabel;

//登录名
@property (copy, nonatomic) NSString *loginName;
//验证码
@property (copy, nonatomic) NSString *validationCode;

@property (weak, nonatomic) AFHTTPSessionManager *manager;

@property (strong, nonatomic) NSString *loginBaseURL;

@end

@implementation Login

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    //隐藏返回导航按钮
    self.navigationItem.hidesBackButton = YES;
    
    //在通知中心注册键盘弹入弹出通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeViewCenter:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeViewCenter:) name:UIKeyboardWillHideNotification object:nil];
    
    self.promptLabel = [WJPromptLabel sharedPromptLabel];
    
    //注册按钮加下划线
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.btnRegister.currentTitle];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [self.btnRegister setAttributedTitle:str forState:UIControlStateNormal];
    
    self.manager = [AppDelegate sharedHTTPManager];
    
    self.loginBaseURL = @"http://dws.nnwg121.com/Engineer/api/Engineer/";
}

- (void)changeViewCenter:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    
    //键盘弹入、弹出后frame
    NSValue *value = userInfo[UIKeyboardFrameEndUserInfoKey];
    
    CGFloat keyBoardEndY = value.CGRectValue.origin.y;
    
    CGPoint center;
    
    if (keyBoardEndY == ScreenHeight) {
        center = CGPointMake(ScreenWidth/2, ScreenHeight/2);
    }else{
        CGFloat loginBtnMaxY = self.btnLogin.mj_y+self.btnValidation.mj_h+ScreenHeight/2;
        
        CGFloat coverH = -(keyBoardEndY - loginBtnMaxY - 20);
        
        if (coverH <= 0) {
            return;
        }
        center = CGPointMake(ScreenWidth/2, ScreenHeight/2-coverH);
    }
    
    NSNumber *duration = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    
    [UIView animateWithDuration:duration.doubleValue animations:^{
        self.view.center = center;
    }];
}

#pragma -mark sendValidationCode

- (IBAction)sendValidation:(id)sender {
    
    NSString *userName = self.txtUser.text;
    
    if (userName.length == 0) {
        self.promptLabel.text = @"ITCode或手机号码为空";
        return;
    }
    
    //点击验证码按钮后设置相关属性
    [sender setEnabled:NO];
    [sender setBackgroundColor:[UIColor lightGrayColor]];

    [sender setTitle:@"发送中..." forState:UIControlStateNormal];
    
    self.loginName = userName;
    [self pushValidationForUser:userName];
}

/**
 *  推送验证码
 *
 *  @param userName 用户名
 */
- (void)pushValidationForUser:(NSString *)userName{
    NSString *sendValidationURL = [self.loginBaseURL stringByAppendingString:@"PostSendSMS"];
    
    [self.manager POST:sendValidationURL parameters:@{@"LoginName":userName} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self pushValidationCodeSuccessWithResult:responseObject];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self sendValidationFailure];
        }
    }];
}
/**
 *  发送验证码请求得到返回数据
 *
 *  @param response 网络请求返回信息
 */
- (void)pushValidationCodeSuccessWithResult:(NSDictionary *)response{
    
    if ([response[@"Flag"]intValue]) {
        [self sendValidationSuccess];
        self.validationCode = response[@"ResultObj"][@"Code"];
        NSLog(@"%@,%@",self.loginName,self.validationCode);
    }else{
        [self sendValidationFailure];
    }
}

/**
 *  验证码发送成功
 */
- (void)sendValidationSuccess{
    
    //启动定时器
    self.promptLabel.text = @"验证码已发送";
    self.countdownNum = 31;
    self.countdown = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(validationCountdown) userInfo:nil repeats:YES];
    [self.countdown fire];
}
/**
 *  验证码发送失败
 */
- (void)sendValidationFailure{
    self.promptLabel.text = @"验证码发送失败";
    [self.btnValidation setTitle:@"重新发送" forState:UIControlStateNormal];
    self.btnValidation.enabled = YES;
}
/**
 *  发送验证码倒计时
 */
- (void)validationCountdown{
    if (self.countdownNum == 0) {
        [self.countdown invalidate];
        [self.btnValidation setTitle:@"重新发送" forState:UIControlStateNormal];
        self.btnValidation.enabled = YES;
    }else{
        self.countdownNum -= 1;
        [self.btnValidation setTitle:[NSString stringWithFormat:@"%02ds",self.countdownNum] forState:UIControlStateNormal];
    }
}

- (void)viewWillLayoutSubviews{
    //将logo设为圆形
    [super viewWillLayoutSubviews];
    self.logo.layer.cornerRadius = self.logo.mj_h/2;
}

#pragma -mark Login
/**
 *  登录按钮事件
 *
 *  @param sender 登录按钮
 */
- (IBAction)login:(id)sender {
    
    NSString *userName = self.txtUser.text;
    NSString *validation = self.txtValidation.text;
    
    if (userName.length == 0) {
        self.promptLabel.text = @"ITCode或手机号码为空";
        return;
    }
    
    if (validation.length == 0) {
        self.promptLabel.text = @"验证码不能为空";
        return;
    }
    
    if (!self.loginName) {
        [self loginFailure];
        return;
    }
    
    [sender setEnabled:NO];
    
    NSString *loginURL = [self.loginBaseURL stringByAppendingString:@"PostLogin"];
    
    [self.manager POST:loginURL parameters:@{@"LoginName":self.loginName,@"Code":validation} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self loginRequestSuccessWithResult:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self loginFailure];
        }
    }];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loginRequestSuccessWithResult:(NSDictionary *)response{
    if ([response[@"Flag"]intValue]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setValue:response[@"ResultObj"][@"ITCode"] forKey:@"ITCode"];
        [self loginSuccess];
    }else{
        [self loginFailure];
    }
}

- (void)loginSuccess{
    [self.countdown invalidate];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loginFailure{
    self.btnLogin.enabled = YES;
    self.promptLabel.text = @"登录失败,请检查登录名和验证码";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

/**
 *  点击注册按钮事件
 *
 *  @param sender 注册按钮
 */
- (IBAction)registerUser:(id)sender {
    RegisterController *registerControl = [[RegisterController alloc]init];
    
    [self.navigationController pushViewController:registerControl animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
}

- (void)dealloc{
    NSLog(@"login dealloc");
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
