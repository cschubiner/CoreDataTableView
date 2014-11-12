//
//  KamcordModel.h
//  KamcordCC
//
//  Created by Clay Schubiner on 11/11/14.
//  Copyright (c) 2014 Schubiner. All rights reserved.
//

@import UIKit;
#import "JSONModel.h"

@interface KamcordModel1 : JSONModel

@property (nonatomic, strong) NSURL* video_url;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, weak) NSDictionary* thumbnails;
@property (nonatomic, strong) UIImage<Ignore> * thumbnail;

@end
