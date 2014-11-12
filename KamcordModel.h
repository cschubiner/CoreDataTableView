//
//  KamcordModel.h
//  KamcordCC
//
//  Created by Clay Schubiner on 11/11/14.
//  Copyright (c) 2014 Schubiner. All rights reserved.
//

#import "JSONModel.h"

@interface KamcordModel1 : JSONModel

@property (assign, nonatomic) NSString* video_url;
@property (assign, nonatomic) NSString* title;
@property (assign, nonatomic) NSDictionary* thumbnails;

@end
