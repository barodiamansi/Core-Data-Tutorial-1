//
//  Employee+Add.m
//  Core-Data-Tutorial-1
//
//  Created by Mansi Barodia on 1/1/17.
//  Copyright © 2017 Mansi Barodia. All rights reserved.
//

#import "Employee+Add.h"
#import "AppDelegate.h"

@implementation Employee (Add)

+ (Employee *)addEmployeeDetails:(NSDictionary *)employeeData {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    Employee *employeeEntity = nil;
    
    return employeeEntity;
}

@end
