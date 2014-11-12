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
    
    
    [JSONHTTPClient getJSONFromURLWithString:@"https://www.kamcord.com/app/v2/videos/feed/?feed_id=0"
                                  completion:^(NSDictionary *json, JSONModelError *err) {
                                      
                                      for (NSDictionary * video in json[@"response"][@"video_list"]) {
                                      KamcordModel1* kamcordModel = [[KamcordModel1 alloc] initWithDictionary:video error:nil];
                                          [videoArray addObject:kamcordModel];
                                      }
                                      
                                      
                                      [self.tableView reloadData];
                                      
                                  }];
    

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
