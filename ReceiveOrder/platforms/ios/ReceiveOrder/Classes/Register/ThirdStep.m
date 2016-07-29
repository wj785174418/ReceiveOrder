//
//  ThirdStep.m
//  ReceiveOrder
//
//  Created by HuayuNanyan on 16/7/28.
//
//

#import "ThirdStep.h"
#import "RegisterController.h"
#import <UIView+MJExtension.h>

@interface ThirdStep ()

@property (weak, nonatomic) RegisterController *parent;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *labelBtns;
@property (strong, nonatomic) UIColor *systemColor;
@end

@implementation ThirdStep

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.parent = (RegisterController *)self.parentViewController;
    
    for (UIButton *btn in self.labelBtns) {
        btn.layer.cornerRadius = 10;
    }
    
    self.systemColor = [[self.labelBtns lastObject]currentTitleColor];
}

- (IBAction)labelBtnTouchDown:(UIButton *)sender {
    if (sender.isSelected) {
        sender.selected = NO;
        sender.backgroundColor = [UIColor whiteColor];
        [sender setTitleColor:self.systemColor forState:UIControlStateNormal];
        [sender setTitleColor:self.systemColor forState:UIControlStateHighlighted];
    }else{
        sender.selected = YES;
        sender.backgroundColor = self.systemColor;
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (IBAction)nextStep:(id)sender {
    [self.parent.scrollView setContentOffset:CGPointMake(self.view.mj_w*3, 0) animated:YES];
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
