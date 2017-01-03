//
//  EmployeeDetailsTableViewController.m
//  EmployeeList
//
//  Created by Mansi Barodia on 1/2/17.
//  Copyright © 2017 Mansi Barodia. All rights reserved.
//

#import "EmployeeDetailsTableViewController.h"
#import "DeptEmployeeList+CoreDataClass.h"
#import "EmployeeDetails+CoreDataClass.h"
#import "AppDelegate.h"

@interface EmployeeDetailsTableViewController ()
- (IBAction)saveEmployeDetails:(id)sender;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end

@implementation EmployeeDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.textField.text = self.employeeDetails.details;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *)managedObjectContext {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.persistentContainer.viewContext;
}

#pragma mark - IBAction

- (void)saveEmployeDetails:(id)sender {
    self.employeeDetails.details = self.textField.text;
    [self.managedObjectContext save:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
