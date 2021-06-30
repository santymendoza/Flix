//
//  MovieModel.m
//  Flix
//
//  Created by Santy Mendoza on 6/30/21.
//

#import "MovieModel.h"

@implementation MovieModel

- (id) initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    //NSLog(dictionary);
    self.title = dictionary[@"title"];
    NSString *baseURL = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURL = dictionary[@"poster_path"];
    NSURL *url = [NSURL URLWithString:[baseURL stringByAppendingString:posterURL]];
    self.posterUrl = url;
    self.movieDescription = dictionary[@"overview"];
    
    return self;
    
}

+ (NSArray *)moviesWithDictionaries:(NSArray *)dictionaries{
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    
    
    for (NSDictionary *movie in dictionaries){
        MovieModel *movieData = [[MovieModel alloc] initWithDictionary:movie];
        [movies addObject:movieData];
    }
    return [movies copy];
}

@end
