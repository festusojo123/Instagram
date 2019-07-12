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
    // Do any additional setup after loading the view.
    [super viewDidLoad];
}

- (void)loginUser {
    //this is where you can pass the text input into the actual databse
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    //now we can use it to see if we can use it to log in or if it's been input incorrectly
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        //if you don't get the error, it means the user is in the database
        if (error != nil) {
            //it failed :(
            NSLog(@"User log in failed: %@", error.localizedDescription);
            //we want to actually tell the user what they did wrong, so let's use a Alert Controller embedded in code to do so
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Invalid Information"
                                                                           message:[NSString stringWithFormat:@"%@", error.localizedDescription]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                    handler:^(UIAlertAction * action) {}];
            //this creates an alert action that tells the user if there's something wrong and what it is
            [alert addAction:defaultAction];
                        [self presentViewController:alert animated:YES completion:^{}];
            //or.... it worked. yay!
        } else {
            NSLog(@"User logged in successfully");
           // display view controller that needs to shown after successful login
            [self performSegueWithIdentifier:@"returningUser" sender:nil];
        }
    }];
}

//segue to register screen if needed, allows us to hard code the segue instead of connecting them directly through the storyboard
- (IBAction)backButton:(id)sender {
    [self performSegueWithIdentifier:@"back" sender:nil];
}

//segue to feed screen if needed, allows us to hard code the segue instead of connecting them directly through the storyboard
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
