//
//  EmployeeListTableViewController.m
//  EmployeeList
//
//  Created by Mansi Barodia on 1/2/17.
//  Copyright © 2017 Mansi Barodia. All rights reserved.
//

#import "EmployeeListTableViewController.h"
#import "DeptEmployeeList+CoreDataClass.h"
#import "EmployeeDetails+CoreDataClass.h"
#import "EmployeeDetailsTableViewController.h"
#import "AppDelegate.h"

@interface EmployeeListTableViewController ()
- (IBAction)addEmployeeDetails:(id)sender;
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@end

@implementation EmployeeListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
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
    return [self.employeeList.employees count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"employeeName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    EmployeeDetails *employeeDetail = [self.employeeList.employees objectAtIndex:[indexPath row]];
    cell.textLabel.text = employeeDetail.details;
    
    return cell;
}

- (NSManagedObjectContext *)managedObjectContext {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.persistentContainer.viewContext;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.managedObjectContext deleteObject:[self.employeeList.employees objectAtIndex:[indexPath row]]];
        [self.managedObjectContext save:nil];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"EmployeeDetailsSegue"]) {
        EmployeeDetailsTableViewController *employeeDetailsController = segue.destinationViewController;
        employeeDetailsController.employeeDetails = [self.employeeList.employees objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
    }
}

#pragma mark - IBAction

- (void)addEmployeeDetails:(id)sender {
    EmployeeDetails *employeeDetails = [NSEntityDescription insertNewObjectForEntityForName:@"EmployeeDetails" inManagedObjectContext:self.managedObjectContext];
    employeeDetails.details = [NSString stringWithFormat:@"Employee id - %lu", [self.employeeList.employees count]];
    employeeDetails.created = [NSDate date];
    employeeDetails.list = self.employeeList;
    
    [self.managedObjectContext save:nil];
    [self.tableView reloadData];
}

@end
