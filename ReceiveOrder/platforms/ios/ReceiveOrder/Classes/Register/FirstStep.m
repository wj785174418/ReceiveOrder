//
//  FirstStep.m
//  ReceiveOrder
//
//  Created by HuayuNanyan on 16/7/26.
//
//

#import "FirstStep.h"
#import "RegisterController.h"
#import <UIView+MJExtension.h>
#import "WJPromptLabel.h"

@interface FirstStep ()
@property (weak, nonatomic)WJPromptLabel *promptLabel;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtUserPhoneNum;
@end

@implementation FirstStep

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.promptLabel = [WJPromptLabel sharedPromptLabel];
}

- (IBAction)nextStep:(id)sender {
    
//    NSString *userName = self.txtUserName.text;
//    NSString *userPhoneNum = self.txtUserPhoneNum.text;
//    
//    if (userName.length == 0) {
//        self.promptLabel.text = @"姓名不能为空";
//        return;
//    }
//    
//    if (userPhoneNum.length != 11) {
//        self.promptLabel.text = @"手机号码输入不正确";
//        return;
//    }
    
    [self.view endEditing:YES];
    
    RegisterController *parent = (RegisterController *)self.parentViewController;
    //
    parent.userName = self.txtUserName.text;
    
    [parent.scrollView setContentOffset:CGPointMake(self.view.mj_w, 0) animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
