//
//  NewPostView.m
//  Instagram
//
//  Created by festusojo on 7/9/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "NewPostView.h"
#import "Post.h"
#import <UIKit/UIKit.h>
#import "ProgressHUD.h"

@interface NewPostView () UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>;
@property (weak, nonatomic) IBOutlet UITextView *caption;
@property (nonatomic, strong) UIImage *photo;
@end

@implementation NewPostView

- (void)viewDidLoad {
    [super viewDidLoad];
}

//this resizes an image, abstracted away to make code below simpler to understand
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    //this is what fills it correcty/makes sure it looks right
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    //declares it as a new image to return after being resized
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    // this is the resize part , abstracted away above in the resizeImage function
    self.photo = [self resizeImage:editedImage withSize:CGSizeMake(300, 300)];
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onPost:(id)sender {
    //this is the HUD being called, it's dismissed in Post.m
    [ProgressHUD show:@"Please wait..."];
    //this checks if the post (of the image) was alllowed
    [Post postUserImage:self.photo withCaption:self.caption.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
    }];
    //this allows for the segue to the next view controller without directly controlling the button
    [self performSegueWithIdentifier:@"uponPost" sender:nil];
}

- (IBAction)camera:(id)sender {
    //this function is where you get the image to add to a new post
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    //if a camera is available, (there isn't one available for the simulator), this is where you can pick it
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //this is the camera being used
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    //this is where the photo library is able to be selected if you choose not to take a new image
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    //this finally shows the screen where you can pick the image
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
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
