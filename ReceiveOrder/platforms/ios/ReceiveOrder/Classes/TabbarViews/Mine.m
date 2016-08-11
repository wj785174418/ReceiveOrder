//
//  Mine.m
//  ReceiveOrder
//
//  Created by HuayuNanyan on 16/8/10.
//
//

#import "Mine.h"
#import "Login.h"

@interface Mine ()

@end

@implementation Mine

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)logout:(id)sender {
    UIAlertController *logout = [UIAlertController alertControllerWithTitle:@"退出登录" message:@"确定要退出当前账号吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:@"user"];
        
        Login *login = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
        [self.tabBarController.navigationController pushViewController:login animated:YES];
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [logout addAction:actionCancel];
    [logout addAction:actionOK];
    
    [self presentViewController:logout animated:YES completion:nil];
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
