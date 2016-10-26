//
//  ChooseModelViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang   on 11/10/2016.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "ChooseModelViewController.h"
#define SECTION_NAMES @[@"A", @"B", @"C",@"D", @"F",@"G", @"H",@"I", @"J",@"K", @"L",@"M", @"N",@"P", @"R",@"S", @"T",@"V"]


@interface ChooseModelViewController ()<UITableViewDataSource,UITabBarDelegate>

-(NSInteger) calculateRows: (NSInteger) section;
@end

@implementation ChooseModelViewController



- (void)viewDidLoad
{
    //get app delegate
    self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(![[NSUserDefaults standardUserDefaults] valueForKey:@"isDataLoad"])//load initial data
    {
        LoadInitialData *startInit=[[LoadInitialData alloc] init];
        [startInit loadInitialData];
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
//    NSInteger sections=[[self.fetchedResultstController sections] count];
//    return sections;
    return 18;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows=0;
//    if([[self.fetchedResultstController sections] count]>0)
//    {
//        id <NSFetchedResultsSectionInfo> sectionInfo=[[self.fetchedResultstController sections] objectAtIndex:section];
//        rows=[sectionInfo numberOfObjects];
//    }
    if(section==0 ||section==1||section==4){
        rows=4;
    }else if(section==2||section==6){
        rows=3;
    }else if (section==3||section==5||section==8||section==13||section==14||section==16||section==17){
        rows=2;
    }else if(section==7||section==9||section==12){
        rows=1;
    }else if(section==10){
        rows=5;
    }else if(section==11){
        rows=8;
    }else if(section==15){
        rows=6;
    }
    return rows;
}

- (NSString *) tableView: (UITableView *) tableView titleForHeaderInSection: (NSInteger) section {
    NSString *sectionName;
    for(int i=0;i<18;i++){
        if(section==i){
            sectionName=SECTION_NAMES[i];
            break;
        }
    }
    return sectionName;
}

-(NSInteger)calculateRows:(NSInteger )section{
    NSInteger result;
    if(section==0){
        result=0;
    }else if (section==1){
        result=4;
    }else if (section==2){
        result=8;
    }else if (section==3){
        result=11;
    }else if (section==4){
        result=13;
    }else if (section==5){
        result=17;
    }else if (section==6){
        result=19;
    }else if (section==7){
        result=22;
    }else if (section==8){
        result=23;
    }else if (section==9){
        result=25;
    }else if (section==10){
        result=26;
    }else if (section==11){
        result=31;
    }else if (section==12){
        result=39;
    }else if (section==13){
        result=40;
    }else if (section==14){
        result=42;
    }else if (section==15){
        result=44;
    }else if (section==16){
        result=50;
    }else if (section==17){
        result=52;
    }
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSIndexPath * index;
    index=[NSIndexPath indexPathForRow:indexPath.row+[self calculateRows:indexPath.section] inSection:0];

    CarModel * carModel=[self.fetchedResultstController objectAtIndexPath:index];
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
