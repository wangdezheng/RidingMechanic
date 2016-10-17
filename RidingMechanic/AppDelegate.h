//
//  AppDelegate.h
//  RidingMechanic
//
//  Created by Dezheng Wang  on 9/14/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(strong,nonatomic) NSManagedObjectModel *managedObjectModel; //data object model

@property(strong,nonatomic) NSManagedObjectContext *managedObjectContext; // object context

@property(strong,nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


-(NSPersistentStoreCoordinator *)persistentStoreCoordinator;//initialize database used by core data


-(NSManagedObjectModel *)managedObjectModel; //initialize managedObjectModel


-(NSManagedObjectContext *)managedObjectContext;// initialize managedObjectContext
@end

