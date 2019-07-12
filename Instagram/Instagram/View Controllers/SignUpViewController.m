//
//  SignUpViewController.m
//  Instagram
//
//  Created by festusojo on 7/8/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "SignUpViewController.h"
#import "Parse/Parse.h"

//these are the fields from the form that the user can type into so we can store/manipulate them later
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
        //checks for error with adding user info to Parse databse
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

//this calls the user, i abstracted away the function to make it cleaner to read
- (IBAction)newUser:(id)sender {
    [self registerUser];
}

//this option allows a returning user to go to my login view controller instead of registering, for better UI, I could change this in a later version of the app
- (IBAction)returningUser:(id)sender {
    [self performSegueWithIdentifier:@"returningUser" sender:nil];
}

@end
