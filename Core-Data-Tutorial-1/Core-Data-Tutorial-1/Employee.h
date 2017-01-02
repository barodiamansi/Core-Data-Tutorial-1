//
//  Employee+CoreDataClass.h
//  Core-Data-Tutorial-1
//
//  Created by Mansi Barodia on 1/1/17.
//  Copyright © 2017 Mansi Barodia. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Employee : NSManagedObject

@property (nonatomic) int64_t employeeId;
@property (nullable, nonatomic, copy) NSString *experience;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;

@end
