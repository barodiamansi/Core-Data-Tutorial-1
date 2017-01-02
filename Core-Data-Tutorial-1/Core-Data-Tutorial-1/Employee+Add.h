//
//  Employee+Add.h
//  Core-Data-Tutorial-1
//
//  Created by Mansi Barodia on 1/1/17.
//  Copyright © 2017 Mansi Barodia. All rights reserved.
//

#import "Employee.h"

@interface Employee (Add)
+ (Employee *)addEmployeeDetails:(NSDictionary *)employeeData;
@end
