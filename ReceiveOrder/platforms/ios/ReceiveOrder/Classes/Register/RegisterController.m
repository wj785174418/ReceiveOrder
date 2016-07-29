//
//  RegisterController.m
//  ReceiveOrder
//
//  Created by HuayuNanyan on 16/7/28.
//
//

#import "RegisterController.h"
#import "FirstStep.h"
#import "SecondStep.h"
#import "ThirdStep.h"
#import "FourthStep.h"
#import <UIView+MJExtension.h>


@interface RegisterController ()<UIScrollViewDelegate>
@property (weak, nonatomic)ThirdStep *thirdStep;
@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelRegister)];
    
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.scrollView];
    
    self.scrollView.delegate = self;
    
    [self addRegisterSteps];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    if (offset.x == self.view.mj_w) {
        self.thirdStep.welcomeLabel.text = [NSString stringWithFormat: @"%@您好请选择您的能力类型(可多选)",self.userName];
    }
}

- (void)addRegisterSteps{
    FirstStep *firstStep = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"firstStep"];
    
    SecondStep *secondStep = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"secondStep"];
    
    ThirdStep *thirdStep = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"thirdStep"];
    self.thirdStep = thirdStep;
    
    FourthStep *fourthStep = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"fourthStep"];
    
    //添加第二步view
    [self addChildViewController:secondStep];
    secondStep.view.mj_x = self.view.mj_w;
    [self.scrollView addSubview:secondStep.view];
    
//    NSLog(@"scroll:(%f,%f,%f,%f)",self.scrollView.mj_x,self.scrollView.mj_y,self.scrollView.mj_w,self.scrollView.mj_h);
//    
//    NSLog(@"scroll:(%f,%f,%f,%f)",secondStep.view.mj_x,secondStep.view.mj_y,secondStep.view.mj_w,secondStep.view.mj_h);
    //添加第一步view
    [self addChildViewController:firstStep];
    [self.scrollView addSubview:firstStep.view];
    
    //添加第三步view
    [self addChildViewController:thirdStep];
    thirdStep.view.mj_x = self.view.mj_w*2;
    [self.scrollView addSubview:thirdStep.view];
    
    //添加第四步view
    [self addChildViewController:fourthStep];
    fourthStep.view.mj_x = self.view.mj_w*3;
    [self.scrollView addSubview:fourthStep.view];
}


/**
 *  取消注册,弹出提示
 */
- (void)cancelRegister{
    [self.view endEditing:YES];
    
    UIAlertController *cancelRegister = [UIAlertController alertControllerWithTitle:@"取消注册" message:@"输入的信息将不被保留,确定要退出么" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [cancelRegister addAction:actionOK];
    [cancelRegister addAction:actionCancel];
    
    [self presentViewController:cancelRegister animated:YES completion:nil];
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
