//
//  MovieCell.h
//  Flix
//
//  Created by Santy Mendoza on 6/23/21.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak,nonatomic) MovieModel *movie;

- (void) setMovie:(MovieModel *)movie;

@end

NS_ASSUME_NONNULL_END
