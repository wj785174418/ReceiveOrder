//
//  SecondStep.m
//  ReceiveOrder
//
//  Created by HuayuNanyan on 16/7/26.
//
//

#import "SecondStep.h"

@interface SecondStep ()

@end

@implementation SecondStep

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
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
