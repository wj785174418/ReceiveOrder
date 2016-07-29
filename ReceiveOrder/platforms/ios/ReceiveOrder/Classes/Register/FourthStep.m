//
//  FourthStep.m
//  ReceiveOrder
//
//  Created by HuayuNanyan on 16/7/29.
//
//

#import "FourthStep.h"
#import "WJPromptLabel.h"
#import "RegisterController.h"
#import <UIView+MJExtension.h>

@interface FourthStep ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) UIButton *needsPhoto;
@property (weak, nonatomic) RegisterController *parent;
@end

@implementation FourthStep

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.parent = (RegisterController *)self.parentViewController;
}

- (IBAction)pickerIDCard:(UIButton *)sender {
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    
    if (!isCamera) {
        [WJPromptLabel sharedPromptLabel].text = @"打开摄像头失败";
        return;
    }
    
    self.needsPhoto = sender;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    
    //编辑模式
    picker.allowsEditing = YES;
    
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    
    [self.needsPhoto setImage:image forState:UIControlStateNormal];
    
    [self.parent.scrollView setContentOffset:CGPointMake(self.view.mj_w*3, 0)];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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
