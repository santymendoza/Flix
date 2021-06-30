//
//  MovieCell.m
//  Flix
//
//  Created by Santy Mendoza on 6/23/21.
//

#import "MovieCell.h"
#import "MovieModel.h"
#import "UIImageView+AFNetworking.h"

@implementation MovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setMovie:(MovieModel *)movie{
    
    self.titleLabel.text = movie.title;
    self.posterView.image = nil;
    if(self.movie.posterUrl != nil){
        [self.posterView setImageWithURL:movie.posterUrl];
    }
    self.descriptLabel.text = movie.movieDescription;
    self.movie = movie;
    
    
}
@end
