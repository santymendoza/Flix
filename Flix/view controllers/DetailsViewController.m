//
//  DetailsViewController.m
//  Flix
//
//  Created by Santy Mendoza on 6/23/21.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backDropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

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

}

- (void) getRelatedMovies {
    
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
