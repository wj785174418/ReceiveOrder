//
//  FirstStep.m
//  ReceiveOrder
//
//  Created by HuayuNanyan on 16/7/26.
//
//

#import "FirstStep.h"
#import "UIButton+ChangeBgColor.h"
#import "SecondStep.h"

@interface FirstStep ()

@end

@implementation FirstStep

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = NO;
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelRegister)];
    
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
}

- (void)cancelRegister{
    UIAlertController *cancelRegister = [UIAlertController alertControllerWithTitle:@"取消注册" message:@"输入的信息将不被保留,确定要退出么" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [cancelRegister addAction:actionOK];
    [cancelRegister addAction:actionCancel];
    
    [self presentViewController:cancelRegister animated:YES completion:nil];
}

- (IBAction)nextStep:(id)sender {
    [sender setSelected:NO];
    SecondStep *secondStep = [[SecondStep alloc]init];
    [self.navigationController pushViewController:secondStep animated:YES];
}

- (IBAction)btnTouchDown:(id)sender {
    [sender setSelected:YES];
}

- (IBAction)btnDragEnter:(id)sender {
    [sender setSelected:YES];
}

- (IBAction)btnDragExit:(id)sender {
    [sender setSelected:NO];
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
