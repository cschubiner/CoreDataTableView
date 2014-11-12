//
//  TableViewController.m
//  
//
//  Created by Clay Schubiner on 11/11/14.
//
//

#import "TableViewController.h"
#import "JSONModelLib.h"

@interface TableViewController ()


@end

@implementation TableViewController

NSMutableArray* videoArray;


- (void)viewDidLoad {
    [super viewDidLoad];
     videoArray = [[NSMutableArray alloc]init];
    
    /*
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

     //compute somehting long
        // tell the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            ProcessResults(results);
        });
    });
    */
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        [JSONHTTPClient getJSONFromURLWithString:@"https://www.kamcord.com/app/v2/videos/feed/?feed_id=0"
                                      completion:^(NSDictionary *json, JSONModelError *err) {
                                          
                                          int count = 0;
                                          for (NSDictionary * video in json[@"response"][@"video_list"]) {
                                              KamcordModel1* kamcordModel = [[KamcordModel1 alloc] initWithDictionary:video error:nil];
                                              [videoArray addObject:kamcordModel];
                                              
                                              
                                              dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                  NSURL* url = [NSURL URLWithString:kamcordModel.thumbnails[@"REGULAR"]];
                                                  [kamcordModel setThumbnail:[UIImage imageWithData:[[NSData alloc] initWithContentsOfURL:url]]];
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:count inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
                                                  });
                                                      });
                                              
                                              count++;
                                          }
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [self.tableView reloadData];
                                          });
                                        }];
    });

  
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [videoArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    KamcordModel1 * kamcordModel = [videoArray objectAtIndex:indexPath.row];
    
    [[cell textLabel]setText:kamcordModel.title];
    [[cell imageView]setImage:kamcordModel.thumbnail];
    
    return cell;
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
