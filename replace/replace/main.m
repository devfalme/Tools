//
//  main.m
//  replace
//
//  Created by devfalme on 2019/2/23.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 替换工程中所有的类名
 */
void replaceProjectClassName(NSString *oldName, NSString *newName, NSString *path) {
    @autoreleasepool {
        BOOL isDir = NO;
        NSError *error = nil;
        NSFileManager *fm = [NSFileManager defaultManager];
        [fm fileExistsAtPath:path isDirectory:&isDir];
        if (isDir) {
            NSArray *array = [fm contentsOfDirectoryAtPath:path error:&error];
            if (error == nil) {
                for (NSString *subPath in array) {
                    NSString *newPath = [[path mutableCopy] stringByAppendingPathComponent:subPath];
                    replaceProjectClassName(oldName, newName, newPath);
                }
            }
        } else {
            NSString *name = [path lastPathComponent];
            NSString *classExtension = name.pathExtension;
            if (!([classExtension isEqualToString:@"h"] || [classExtension isEqualToString:@"m"] || [classExtension isEqualToString:@"swift"] || [classExtension isEqualToString:@"xib"] || [classExtension isEqualToString:@"storyboard"] || [classExtension isEqualToString:@"pbxproj"])) {
                return;
            }
            
            NSMutableString *content = [NSMutableString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
            if (error) {
                NSLog(@"打开文件失败：%@", error.description);
                return;
            }
            NSString *regularExpression = [NSString stringWithFormat:@"\\b%@\\b", oldName];
            
            NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:regularExpression options:NSRegularExpressionAnchorsMatchLines|NSRegularExpressionUseUnixLineSeparators error:nil];
            NSArray<NSTextCheckingResult *> *matches = [expression matchesInString:content options:0 range:NSMakeRange(0, content.length)];
            [matches enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSTextCheckingResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [content replaceCharactersInRange:obj.range withString:newName];
            }];
            
            
            [content writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
            
        }
        
    }
    
    
}

/**
 递归的遍历指定目录，将目录中遇到的类的名字修改前缀，并替换所有项目中出现的该类名字符串
 */
void renameRecursion(NSString *path, NSString *projectPath) {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = nil;
    NSError *renameError = nil;
    BOOL isDir = NO;
    [fm fileExistsAtPath:path isDirectory:&isDir];
    if (isDir) {
        NSArray *array = [fm contentsOfDirectoryAtPath:path error:&error];
        if (error == nil) {
            for (NSString *subPath in array) {
                NSString *newPath = [[path mutableCopy] stringByAppendingPathComponent:subPath];
                renameRecursion(newPath, projectPath);
            }
        }
    } else {
        NSString *name = [path lastPathComponent];
        NSString *className = name.stringByDeletingPathExtension;
        NSString *classExtension = name.pathExtension;
        
        
        if ([className hasPrefix:@"BM_"]) {
            NSString *newClassName = [[className mutableCopy] stringByReplacingOccurrencesOfString:@"BM_" withString:@"CGR_"];
            NSString *newPath = [[path mutableCopy] stringByReplacingOccurrencesOfString:@"BM_" withString:@"CGR_"];
            
            replaceProjectClassName(className, newClassName, projectPath);
            
            NSString *settingString = [NSString stringWithFormat:@"%@.xcodeproj/project.pbxproj", projectPath];
            replaceProjectClassName(className, newClassName, settingString);
            
            [fm moveItemAtPath:path toPath:newPath error:&renameError];
            if (renameError != nil) {
                NSLog(@"renameError : %@", renameError.description);
            }
        }
    }
    
}



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        renameRecursion(@"/Users/devfalme/Documents/8Mall/8Mall/8Mall", @"/Users/devfalme/Documents/8Mall/8Mall/8Mall");
    }
    return 0;
}
