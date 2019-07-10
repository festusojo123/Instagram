//
//  SignUpViewController.m
//  Instagram
//
//  Created by festusojo on 7/8/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "SignUpViewController.h"
#import "Parse/Parse.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation SignUpViewController


//initial set up to begin loading page
- (void)viewDidLoad {
    [super viewDidLoad];
}

//checks for memory issues
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.email = self.emailField.text;
    newUser.password = self.passwordField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");

        // manually segue to logged in view
        [self performSegueWithIdentifier:@"newUser" sender:nil];
            NSLog(@"broken");
        }
    }];
}
- (IBAction)newUser:(id)sender {
    [self registerUser];
}

- (IBAction)returningUser:(id)sender {
    [self performSegueWithIdentifier:@"returningUser" sender:nil];
}

@end
