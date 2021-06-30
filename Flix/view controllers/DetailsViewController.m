//
//  DetailsViewController.m
//  Flix
//
//  Created by Santy Mendoza on 6/23/21.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "RelatedCollectionViewCell.h"

@interface DetailsViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *backDropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong,nonatomic) NSArray *movies;
@property (weak, nonatomic) IBOutlet UICollectionView *relatedCollectionView;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    [self.posterView setImageWithURL: posterURL];
    
    
    NSString *backURLString = self.movie[@"backdrop_path"];
    NSString *fullBackURLString = [baseURLString stringByAppendingString:backURLString];
    
    NSURL *backURL = [NSURL URLWithString:fullBackURLString];
    [self.backDropView setImageWithURL:backURL];
    
    self.descriptionLabel.text = self.movie[@"overview"];
    self.titleLabel.text = self.movie[@"title"];
    
    
    [self.titleLabel sizeToFit];
    [self.descriptionLabel sizeToFit];
    self.relatedCollectionView.delegate = self;
    self.relatedCollectionView.dataSource = self;
    
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.relatedCollectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 2;
    
    CGFloat posterPerLine = 3;
    CGFloat itemWidth = (self.relatedCollectionView.frame.size.width - layout.minimumInteritemSpacing * (posterPerLine - 1)) / posterPerLine;
    CGFloat itemHeight = itemWidth * 1.5;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    [self getRelatedMovies];

}

- (void) getRelatedMovies {
    NSString *idString = [self.movie[@"id"] stringValue];
                            //@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    NSString *stringUrl = [@"https://api.themoviedb.org/3/movie/" stringByAppendingString: idString];
    NSString *finalStringURL = [stringUrl stringByAppendingString:@"/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURL *url = [NSURL URLWithString: finalStringURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Device not connected to internet" preferredStyle:UIAlertControllerStyleAlert];
               UIAlertAction *okPressed = [UIAlertAction actionWithTitle:@"Ok" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   NSLog(@"OK?");
               }];
               [alert addAction:okPressed];
               [self presentViewController:alert animated:YES completion:^{
                   // optional code for what happens after the alert controller has finished presenting
                   [self getRelatedMovies];
               }];
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               //NSLog(@"%@", dataDictionary);
               
               self.movies = dataDictionary[@"results"];
               
               for (NSDictionary *movie in self.movies){
                   NSLog(@"%@", movie[@"title"]);
                   
               }
               [self.relatedCollectionView reloadData];
           }
    }];
    [task resume];
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    RelatedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"relatedCell" forIndexPath:indexPath];
    NSDictionary *movie = self.movies[indexPath.item];
    
    //NSString *title = movie[@"original_title"];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    cell.relatedImage.image = nil;
    [cell.relatedImage setImageWithURL: posterURL];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.movies.count;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UITableView *tappedCell = sender;
    NSIndexPath *indexPath = [self.relatedCollectionView indexPathForCell: tappedCell];
    NSDictionary *movie = self.movies[indexPath.row];
    
    DetailsViewController *detailViewController = [segue destinationViewController];
    detailViewController.movie = movie;
    
}

@end
