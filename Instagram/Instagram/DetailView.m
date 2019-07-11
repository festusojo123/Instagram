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
@property (weak, nonatomic) IBOutlet UIImageView *tweetImage;
@property (weak, nonatomic) IBOutlet UILabel *timestampDetails;
@property (weak, nonatomic) IBOutlet UILabel *usernameText;
@property (weak, nonatomic) IBOutlet UILabel *captionText;

@end

@implementation DetailView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

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
    
    [self.captionText sizeToFit];
    [self.usernameText sizeToFit];
    [self.timestampDetails sizeToFit];
    
    //images are harder lol
    PFFileObject *pfobj = _igPost[@"image"];
    //passes data into function
    [pfobj getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (data) {
            //sets input data into image and sets them equal to each other, so it can have an image to display
            self.tweetImage.image = [UIImage imageWithData:data];
        }
    }];
}

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
