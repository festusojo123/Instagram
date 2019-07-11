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
    
    self.igFeed.dataSource = self;
    self.igFeed.delegate = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Fetch data from Parse
    [self fetcher];

    //refresh stuff
    [super viewDidLoad];
    // Initialize a UIRefreshControl
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.igFeed insertSubview:refreshControl atIndex:0];
//
    
}

-(void)fetcher{    // fetch data asynchronously
    NSLog(@"fetching");
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    // [query whereKey:@"likesCount" greaterThan:@100];
    [query includeKey:@"author"];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            // Get posts and store into self.posts
            self.posts = posts;
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

    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
//- (void)beginRefresh:(UIRefreshControl *)refreshControl {
//
//        // Create NSURL and NSURLRequest
//
//        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
//                                                              delegate:nil
//                                                         delegateQueue:[NSOperationQueue mainQueue]];
//        session.configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//
//        NSURLSessionDataTask *task = [session dataTaskWithRequest:request
//                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//
//                                                    // ... Use the new data to update the data source ...
//                                                      self.posts = posts;
//                                                    // Reload the tableView now that there is new data
//                                                    [self.tableView reloadData];
//
//                                                    // Tell the refreshControl to stop spinning
//                                                    [refreshControl endRefreshing];
//
//                                                }];
//
//        [task resume];
//    }

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
        // Create the post cell with the dequeuable reuse idenfitierrs
        IGCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reuse Identifier"];
        
        // Get the post from the self.posts array
        Post *post = self.posts[indexPath.row];
        
        // set cell poperties (title, image, caption)
        //drag all things into IGCell first
        //cell.someLabel.text = post.author.username example of how to set equal
        cell.captionBody.text = post.author.username;
        cell.usernameText.text = post.caption;
    
        //images are harder
    
        PFFileObject *pfobj = post.image;
        // NSString *imageURL = [NSURL URLWithString:pfobj.url];
    [pfobj getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (data) {
            cell.postImage.image = [UIImage imageWithData:data];
        }
    }];
    
        // [cell.postImage setImageWithURL:imageURL];
  
        // return cell
        return cell;
    }

    @end

