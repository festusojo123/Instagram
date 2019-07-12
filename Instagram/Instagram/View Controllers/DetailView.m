//
//  DetailView.m
//  Instagram
//
//  Created by festusojo on 7/11/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "DetailView.h"
#import "IGFeedViewController.h"
#import "Parse/Parse.h"
#import "Post.h"

@interface DetailView ()
//these are the outlets that allow us to interact with the different images and files from the view controllor
@property (weak, nonatomic) IBOutlet UIImageView *tweetImage;
@property (weak, nonatomic) IBOutlet UILabel *timestampDetails;
@property (weak, nonatomic) IBOutlet UILabel *usernameText;
@property (weak, nonatomic) IBOutlet UILabel *captionText;

@end

@implementation DetailView

- (void)viewDidLoad {
    [super viewDidLoad];
    // indexes into the Post data type, this one specifically called igPost to allow us to view those in the details page
    self.captionText.text = self.igPost[@"caption"];
    self.usernameText.text = self.igPost[@"author"][@"username"];
    // Format and set createdAtString
    // Format createdAt date string
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configure the input format to parse the date string
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    // Configure output format
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    // Convert Date to String
    self.timestampDetails.text = [formatter stringFromDate:self.igPost.createdAt];
    //this makes sure the text itself is formatted correctly for the size of the boxes
    [self.captionText sizeToFit];
    [self.usernameText sizeToFit];
    [self.timestampDetails sizeToFit];
    //images are harder lol, similar code from IGFeedViewController.m, primarily using the PFFile properties Parse provides us with
    PFFileObject *pfobj = _igPost[@"image"];
    //passes data into function
    [pfobj getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (data) {
            //sets input data into image and sets them equal to each other, so it can have an image to display
            self.tweetImage.image = [UIImage imageWithData:data];
        }
    }];
}

//this allows us to go back, hard coding the segue instead of directly dragging from the button to the view controller
- (IBAction)clickOnBack:(id)sender {
        [self performSegueWithIdentifier:@"back" sender:nil];
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
