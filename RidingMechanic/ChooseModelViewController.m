//
//  ChooseModelViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang   on 11/10/2016.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "ChooseModelViewController.h"



@interface ChooseModelViewController ()<UITableViewDataSource,UITabBarDelegate>

@end

@implementation ChooseModelViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //获取当前应用程序的委托（UIApplication sharedApplication为整个应用程序上下文）
    self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(![[NSUserDefaults standardUserDefaults] valueForKey:@"isDataLoad"])
    {
        CarModel *car1=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
        
        [car1 setBrand:@"Ford"];
        [car1 setYear:@"2010"];
        [car1 setVersion:@"Taurus"];
        [car1 setModel:@"F250"];
        
        CarModel *car2=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
        
        [car2 setBrand:@"BMW"];
        [car2 setYear:@"2007"];
        [car2 setVersion:@"525"];
        [car2 setModel:@"xi"];
        
        NSError *error;
        BOOL isSaveSuccess = [self.myDelegate.managedObjectContext save:&error];
        
        if (!isSaveSuccess) {
            NSLog(@"Error: %@,%@",error,[error userInfo]);
        }else {
            NSLog(@"Save successful!");
        }
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"isDataLoad"];
    }
        
}

-(NSFetchedResultsController *)fetchedResultstController
{
    
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"CarModel"];
    request.predicate=nil;
    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"brand" ascending:YES selector:@selector(localizedStandardCompare:)]];
    
    _fetchedResultstController=[[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.myDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    
    NSError *error = nil;
    if (![_fetchedResultstController performFetch:&error]) {
        NSLog(@"Failed to initialize FetchedResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    return _fetchedResultstController;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sections=[[self.fetchedResultstController sections] count];
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows=0;
    if([[self.fetchedResultstController sections] count]>0)
    {
        id <NSFetchedResultsSectionInfo> sectionInfo=[[self.fetchedResultstController sections] objectAtIndex:section];
        rows=[sectionInfo numberOfObjects];
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    CarModel * carModel=[self.fetchedResultstController objectAtIndexPath:indexPath];
   cell.textLabel.text=carModel.brand;
 
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
