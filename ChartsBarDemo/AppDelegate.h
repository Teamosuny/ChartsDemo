//
//  AppDelegate.h
//  ChartsBarDemo
//
//  Created by 张恒宇 on 2019/5/20.
//  Copyright © 2019 hycrazyfish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

