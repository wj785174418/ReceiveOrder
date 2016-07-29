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

//测试用户名
@property (copy, nonatomic) NSString *user;
//测试后删除
@property (copy, nonatomic) NSString *validationCode;
@end

@implementation Login

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    //隐藏返回导航按钮
    self.navigationItem.hidesBackButton = YES;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeViewCenter:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeViewCenter:) name:UIKeyboardWillHideNotification object:nil];
    
    self.promptLabel = [WJPromptLabel sharedPromptLabel];
    
    //注册按钮加下划线
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.btnRegister.currentTitle];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [self.btnRegister setAttributedTitle:str forState:UIControlStateNormal];
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

- (IBAction)sendValidation:(id)sender {
    
    if (self.txtUser.text.length == 0) {
        self.promptLabel.text = @"ITCode或手机号码为空";
        return;
    }
    //点击验证码按钮后设置相关属性
    [sender setEnabled:NO];
    [sender setBackgroundColor:[UIColor lightGrayColor]];
    self.countdownNum = 30;
    [sender setTitle:[NSString stringWithFormat:@"%02ds",self.countdownNum] forState:UIControlStateNormal];
    //启动定时器
    self.countdown = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(validationCountdown) userInfo:nil repeats:YES];
    self.user = self.txtUser.text;
    [self pushValidation];
}
//测试
- (void)pushValidation{
    int validation = arc4random_uniform(900000) + 100000;
    self.validationCode = [NSString stringWithFormat:@"%d",validation];
    UIAlertController *validationAlert = [UIAlertController alertControllerWithTitle:@"验证码" message:self.validationCode preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.txtValidation.text = self.validationCode;
    }];
    
    [validationAlert addAction:actionOK];
    [self presentViewController:validationAlert animated:YES completion:nil];
}


/**
 *  验证码倒计时定时器方法
 */
- (void)validationCountdown{
    //倒计时结束相关处理
    if (self.countdownNum == 0) {
        [self.countdown invalidate];
        [self.btnValidation setTitle:@"验证码" forState:UIControlStateNormal];
        self.btnValidation.enabled = YES;
        self.btnValidation.selected = NO;
        return;
    }
    //倒计时-1
    self.countdownNum -= 1;
    [self.btnValidation setTitle:[NSString stringWithFormat:@"%02ds",self.countdownNum] forState:UIControlStateNormal];
}

- (void)viewWillLayoutSubviews{
    //将logo设为圆形
    self.logo.layer.cornerRadius = self.logo.mj_h/2;
}
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
    
    if ([userName isEqualToString:self.user] && [validation isEqualToString:self.validationCode]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        self.promptLabel.text = @"用户名或验证码错误";
        [sender setEnabled:YES];
    }
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
