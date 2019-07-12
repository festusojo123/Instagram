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
#import <Foundation/Foundation.h>
#import "DetailView.h"

@interface IGFeedViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *igFeed;
// declare a NSArray to store posts later
@property (nonatomic, strong) NSMutableArray *posts;
@end

@implementation IGFeedViewController

//when you log out, you don't want to the user to still be continued
- (IBAction)logoutButtonPress:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    //segue to home (register new user) screen if needed, allows us to hard code the segue instead of connecting them directly through the storyboard
    [self performSegueWithIdentifier:@"signoutPress" sender:nil];
}

//segue to the compose (NewPostView.m) screen if the user clicks on the new post option, allows us to hard code the segue instead of connecting them directly through the storyboard
- (IBAction)clickNewPost:(id)sender {
    [self performSegueWithIdentifier:@"newPost" sender:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //this sets up a delegate to pass the data to the cell
    self.igFeed.dataSource = self;
    self.igFeed.delegate = self;
    // Fetch data from Parse
    [self fetcher];
    //refresh stuff
    [super viewDidLoad];
    // Initialize a UIRefreshControl
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    //this sets where/when the refresh control will be working
    [self.igFeed insertSubview:refreshControl atIndex:0];
//
    
}

-(void)fetcher{
    // fetch data asynchronously
    NSLog(@"fetching");
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    //my posts were coming up in reverse order, so this should fix that
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    //we want 20 posts
    query.limit = 20;
    //this is where you can the data in the background of this running
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            // Get posts and store into self.posts
            self.posts = [NSMutableArray arrayWithArray:posts];
            //if not, you have a problem!
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        //reload table to show new info
        [self.igFeed reloadData];
        NSLog(@"reloaded");
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // return the number of posts
    return self.posts.count;
}

// Updates the View with the new data
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self fetcher];
    // ... Use the new data to update the data source ...
    self.posts = _posts;
    // Reload the imageView now that there is new data
    [self.igFeed reloadData];
    // Tell the refreshControl to stop spinning
    [refreshControl endRefreshing];
    }

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
        // Create the post cell with the dequeuable reuse idenfitiers
        IGCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reuse Identifier"];
        // Get the post from the self.posts array
        Post *post = self.posts[indexPath.row];
        // set cell poperties (title, image, caption)
        //drag all things into IGCell first
        //cell.someLabel.text = post.author.username   --   example of how to set equal
        cell.captionBody.text = post.author.username;
        cell.usernameText.text = post.caption;
        // Format and set createdAtString
        // Format createdAt date string
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // Configure the input format to parse the date string
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        // Configure output format
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        // Convert Date to String
        cell.timestamp.text = [formatter stringFromDate:post.createdAt];
        //images are harder lol
        PFFileObject *pfobj = post.image;
        //passes data into function
        [pfobj getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
            if (data) {
                //sets input data into image and sets them equal to each other, so it can have an image to display
                cell.postImage.image = [UIImage imageWithData:data];
            }
        }];
        // return cell when done
        return cell;
    }

/*
 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 */


//Miguel showed me the issue I had with this: it was always going to this screen instead of just when the user clicks on a cell, thanks Miguel!
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get sthe new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"detailer"]){
        //this calls the following code if the button is pressed and not all the time, per the note above
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.igFeed indexPathForCell:tappedCell];
        Post *post = self.posts[indexPath.row];
        //this sets the designation of a selection of the cell to its respective detailview controller
        DetailView *detailView = [segue destinationViewController];
        //this is where we get the actual new screen based off the post and its metadata
        detailView.igPost = post;
        tappedCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

@end

