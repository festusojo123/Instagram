//
//  LogInViewController.m
//  Instagram
//
//  Created by festusojo on 7/9/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "LogInViewController.h"
#import "Parse/Parse.h"

@interface LogInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loginUser {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Invalid Information"
                                                                           message:[NSString stringWithFormat:@"%@", error.localizedDescription]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
                        [self presentViewController:alert animated:YES completion:^{}];
        } else {
            NSLog(@"User logged in successfully");

            [self performSegueWithIdentifier:@"homeSegue" sender:nil];
            // display view controller that needs to shown after successful login
        }
    }];
}

- (IBAction)didTapSignIn:(id)sender {
    [self loginUser];
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
