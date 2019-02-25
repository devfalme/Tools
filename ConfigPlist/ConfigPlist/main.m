//
//  main.m
//  ConfigPlist
//
//  Created by devfalme on 2019/1/5.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *path = @"/Users/devfalme/Desktop/1/ConfigPlist/JsonData/Exam.json";
        NSArray *array = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableLeaves error:nil];
        [array writeToFile:@"/Users/devfalme/Desktop/1/ConfigPlist/PlistData/Exam.plist" atomically:YES];
        
//        NSString *path = @"/Users/devfalme/Desktop/1/ConfigPlist/PlistData/2017.plist";
//        NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:path];
//        [arr removeObjectsInRange:NSMakeRange(0, 9)];
//
//        NSMutableDictionary<NSString *, NSMutableArray *> *resultDict = [NSMutableDictionary dictionary];
//
//        for (NSDictionary *dict in arr) {
//            NSNumber *time = dict[@"archive_timestamp"];
//            NSDate *date = [NSDate dateWithTimeIntervalSince1970:time.integerValue];
//
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//            [formatter setDateFormat:@"MM-dd"];
//            NSString *key = [formatter stringFromDate:date];
//
//            if ([[resultDict allKeys] containsObject:key]) {
//                [resultDict[key] addObject:dict];
//            }else{
//                NSMutableArray *dictArr = [NSMutableArray array];
//                [dictArr addObject:dict];
//                [resultDict setObject:dictArr forKey:key];
//            }
//        }
//
//        NSArray *resultKeys = [[resultDict allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//            [formatter setDateFormat:@"MM-dd"];
//            NSTimeInterval date1 = [[formatter dateFromString:obj1] timeIntervalSince1970];
//            NSTimeInterval date2 = [[formatter dateFromString:obj2] timeIntervalSince1970];
//
//            if (date1 > date2) {
//                return NSOrderedDescending;
//            }else{
//                return NSOrderedAscending;
//            }
//        }];
//
//        NSMutableArray *resultArr = [NSMutableArray array];
//        for (NSString *key in resultKeys) {
//            [resultArr addObject:[NSDictionary dictionaryWithObject:resultDict[key] forKey:key]];
//        }
//        [resultArr writeToFile:@"/Users/devfalme/Desktop/1/ConfigPlist/PlistData/2017Group.plist" atomically:NO];
//
    }
    return 0;
}

