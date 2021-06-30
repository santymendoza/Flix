//
//  moviesViewController.m
//  Flix
//
//  Created by Santy Mendoza on 6/23/21.
//

#import "moviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"
#import "MovieModel.h"
#import "MovieAPIManager.h"

@interface moviesViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;




@end

@implementation moviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.movies = [[NSArray alloc] init];
    
    [self.activityIndicator startAnimating];
    [self fetchMovies];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget: self action:@selector(fetchMovies) forControlEvents: UIControlEventValueChanged];
    [self.tableView  insertSubview:self.refreshControl atIndex:0];
        
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}

- (void) fetchMovies {

    MovieAPIManager *manager = [MovieAPIManager new];
    [manager fetchNowPlaying:^(NSArray *movies, NSError *error) {
        if (error != nil){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Device not connected to internet" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okPressed = [UIAlertAction actionWithTitle:@"Ok" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"OK?");
            }];
            [alert addAction:okPressed];
            [self presentViewController:alert animated:YES completion:^{
                // optional code for what happens after the alert controller has finished presenting
                [self fetchMovies];
            }];
            [self.refreshControl endRefreshing];
        }
        else{
            self.movies = movies;
            [self.tableView reloadData];
            [self.activityIndicator stopAnimating];
        }
        

    }];

   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    
    
    MovieModel *movie = self.movies[indexPath.row];
    
    
    [cell setMovie:movie];
   
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UITableView *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell: tappedCell];
    NSDictionary *movie = self.movies[indexPath.row];
    
    DetailsViewController *detailViewController = [segue destinationViewController];
    detailViewController.movie = movie;
    
}


@end
