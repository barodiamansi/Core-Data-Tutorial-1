//
//  EmployeeListTableViewController.h
//  EmployeeList
//
//  Created by Mansi Barodia on 1/2/17.
//  Copyright © 2017 Mansi Barodia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DeptEmployeeList;

@interface EmployeeListTableViewController : UITableViewController

@property (nonatomic, strong) DeptEmployeeList *employeeList;

@end
