//
//  MovieModel.h
//  Flix
//
//  Created by Santy Mendoza on 6/30/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieModel : NSObject

@property (strong,nonatomic) NSURL *posterUrl;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *movieDescription;

-(id) initWithDictionary: (NSDictionary *)dictionary;

+(NSArray *) moviesWithDictionaries: (NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
