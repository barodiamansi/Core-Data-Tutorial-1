//
//  DepartmentListTableViewController.m
//  EmployeeList
//
//  Created by Mansi Barodia on 1/2/17.
//  Copyright © 2017 Mansi Barodia. All rights reserved.
//

#import "DepartmentListTableViewController.h"
#import "DeptEmployeeList+CoreDataClass.h"
#import "EmployeeDetails+CoreDataClass.h"
#import "AppDelegate.h"
#import "EmployeeListTableViewController.h"

@interface DepartmentListTableViewController ()
@property (nonatomic, strong) NSArray *employeeLists;
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
- (IBAction)addEmployeeList:(id)sender;
@end

@implementation DepartmentListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"DeptEmployeeList"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"created" ascending:YES]];
    
    self.employeeLists = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
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
    return [self.employeeLists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"deptName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    DeptEmployeeList *employeeList = [self.employeeLists objectAtIndex:[indexPath row]];
    cell.textLabel.text = employeeList.employeeName;
    
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
        [self.managedObjectContext deleteObject:[self.employeeLists objectAtIndex:[indexPath row]]];
        [self.managedObjectContext save:nil];
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"DeptEmployeeList"];
        fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"created" ascending:YES]];
        
        self.employeeLists = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
        
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
    if ([segue.identifier isEqualToString:@"EmployeeListSegue"]) {
        EmployeeListTableViewController *employeeListController = segue.destinationViewController;
        employeeListController.employeeList = [self.employeeLists objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
    }
}

#pragma mark - IBAction

- (void)addEmployeeList:(id)sender {
    DeptEmployeeList *newEmployeeList = [NSEntityDescription insertNewObjectForEntityForName:@"DeptEmployeeList" inManagedObjectContext:self.managedObjectContext];
    newEmployeeList.created = [NSDate date];
    newEmployeeList.employeeName = [NSString stringWithFormat:@"Dept List - %lu", (unsigned long)[self.employeeLists count]];
    
    [self.managedObjectContext save:nil];
    
    self.employeeLists = [self.employeeLists arrayByAddingObject:newEmployeeList];
    [self.tableView reloadData];
}

@end
