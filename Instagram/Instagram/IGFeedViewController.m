//
//  IGFeedViewController.m
//  Instagram
//
//  Created by festusojo on 7/9/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "IGFeedViewController.h"
#import "Parse/Parse.h"
#import "AppDelegate.h"
#import "IGCell.h"
#import "Post.h"

@interface IGFeedViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *igFeed;
// declare a NSArray to store posts later
@property (nonatomic, strong) NSArray *posts;
@end

@implementation IGFeedViewController

- (IBAction)logoutButtonPress:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    [self performSegueWithIdentifier:@"signoutPress" sender:nil];
}

- (IBAction)clickNewPost:(id)sender {
    NSLog(@"hi");
    [self performSegueWithIdentifier:@"newPost" sender:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Fetch data from Parse
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            // Get posts and store into self.posts
            self.posts = posts;
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section:(UITableView *)tableView {
    // return the number of posts
    return self.posts.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
        // Create the post cell with the dequeuable reuse idenfitierrs
        IGCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IGCell"];
        
        // Get the post from the self.posts array
        Post *post = self.posts[indexPath.row];
        
        // set cell poperties (title, image, caption)
        //drag all things into IGCell first
        //cell.someLabel.text = post.author.username example of how to set equal
        cell.captionBody.text = post.author.username;
        cell.usernameText.text = post.caption;
        
        //images are harder
        // NSString *imageStringURL = post.image.url;
       // NSString *imageURL = [NSURL URLWithString:imageStringURL];
  
        // return cell
        return cell;
    }



@end
