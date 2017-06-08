//
//  FileTools.h
//  ipad_recipe
//
//  Created by AaronFan on 12-9-12.
//  Copyright (c) 2012年 www.haodou.com. All rights reserved.
//

#ifndef ipad_recipe_File_Tools_h
#define ipad_recipe_File_Tools_h

#import <Foundation/NSObjCRuntime.h>
#import <objc/runtime.h>

#include <sys/stat.h>
#include <dirent.h>

static BOOL addSkipBackupAttributeToItemAtURL(NSURL *URL) {
    if (URL == nil) {
        return NO;
    }
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

static NSString *documentDirectory() {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

static NSString *cacheDirectory() {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

static NSArray *directoryArrayInPath(NSString *path) {
    NSFileManager *fileHandle = [NSFileManager defaultManager];
    NSError *error;
    return [fileHandle contentsOfDirectoryAtPath:path error:&error];
}

static bool fileBeExisted(NSString *path) {
    NSFileManager *fileHandle = [NSFileManager defaultManager];
    return [fileHandle fileExistsAtPath:path isDirectory:false];
}

static bool fileInPath(NSString *path, NSString *fileName) {
    NSFileManager *fileHandle = [NSFileManager defaultManager];
    path = [path stringByAppendingPathComponent:fileName];
	return [fileHandle fileExistsAtPath:path];
}

static bool fileInDocumentDirectory(NSString *fileName) {
	
	NSString *doc = documentDirectory();
	NSFileManager *fileHandle = [NSFileManager defaultManager];
	NSString *path = [doc stringByAppendingPathComponent:fileName];
	return [fileHandle fileExistsAtPath:path];
}

static bool deleteFileAboutPath(NSString *path) {
    NSFileManager *fileHandle = [NSFileManager defaultManager];
    NSError *error;
	return [fileHandle removeItemAtPath:path error:&error];
}

static bool deleteFileInDirectory(NSString *path, NSString *fileName) {
    return deleteFileAboutPath([path stringByAppendingPathComponent:fileName]);
}

static bool createFileURLToDirecoty(NSString *fURL, NSString *filePath) {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error;
    bool r = [fm createSymbolicLinkAtPath:fURL withDestinationPath:filePath error:&error];
    return r;
}

static bool deleteFileURLDirectory(NSString *path, NSString *fileName) {
    NSFileManager *fileHandle = [NSFileManager defaultManager];
    NSError *error;
    return [fileHandle removeItemAtURL:[NSURL URLWithString:[path stringByAppendingPathComponent:fileName]] error:&error];
}

static bool moveFileToNewPath(NSString *path, NSString *newPath) {
    NSFileManager *fim = [NSFileManager defaultManager];
    NSError *error;
    [fim moveItemAtPath:path toPath:newPath error:&error];
    addSkipBackupAttributeToItemAtURL([NSURL URLWithString:newPath]);
    return true;
}

static bool deleteFileInDocumentDirectory(NSString *fileName) {
	NSString *doc = documentDirectory();
	NSString *path = [doc stringByAppendingPathComponent:fileName];
    return deleteFileAboutPath(path);
}

static NSString *absoPathinDocumentDirectory(NSString *fileName) {
	return [documentDirectory() stringByAppendingPathComponent:fileName];
}

static bool copyFileToNewPath(NSString *path, NSString *toPath, bool clear) {
    
    //copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error
    NSFileManager *fileHandle = [NSFileManager defaultManager];
    NSError *error;
    if(!clear) {
        return [fileHandle copyItemAtPath:path toPath:toPath error:&error];
    }
    else {
        return [fileHandle moveItemAtPath:path toPath:toPath error:&error];
    }
}

static NSString *createDirectoryInPath(NSString *path, NSString *newPath) {
    NSFileManager *fileHandle = [NSFileManager defaultManager];
    NSString *diskCachePath = [path stringByAppendingPathComponent:newPath];
    if(![fileHandle fileExistsAtPath:diskCachePath]) {
        NSError *error;
		if([fileHandle createDirectoryAtPath:diskCachePath withIntermediateDirectories:false attributes:nil error:&error]) {
            addSkipBackupAttributeToItemAtURL([NSURL URLWithString:diskCachePath]);
        }
        else {
            return nil;
        }
	}
	return diskCachePath;
}

static NSString *createDirectoryInCacheDirectory(NSString *pathName) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true);
    NSFileManager *fileHandle = [NSFileManager defaultManager];
    NSString *diskCachePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:pathName];
    if(![fileHandle fileExistsAtPath:diskCachePath]) {
        NSError *error;
		if([fileHandle createDirectoryAtPath:diskCachePath withIntermediateDirectories:false attributes:nil error:&error]) {
            
        }
        else {
            return nil;
        }
	}
	return diskCachePath;
}

static bool directoryInCacheDirectory(NSString *pathName) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true);
    NSFileManager *fileHandle = [NSFileManager defaultManager];
    NSString *diskCachePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:pathName];
    if(![fileHandle fileExistsAtPath:diskCachePath]) {
        return false;
    }
    return true;
}

static NSString *createDirectoryInDocumentDirectory(NSString *pathName) {
    NSString *doc = documentDirectory();
	NSFileManager *fileHandle = [NSFileManager defaultManager];
	NSString *path = [doc stringByAppendingPathComponent:pathName];
	if(![fileHandle fileExistsAtPath:path]) {
        NSError *error;
		if([fileHandle createDirectoryAtPath:path withIntermediateDirectories:false attributes:nil error:&error]) {
            addSkipBackupAttributeToItemAtURL([NSURL URLWithString:path]);
        }
        else {
            return nil;
        }
	}
	return path;
}

static NSString * createFileInDocumentDirectory(NSString *fileName) {
	
	NSString *doc = documentDirectory();
	NSFileManager *fileHandle = [NSFileManager defaultManager];
	NSString *path = [doc stringByAppendingPathComponent:fileName];
	if(![fileHandle fileExistsAtPath:path]) {
		if([fileHandle createFileAtPath:path contents:nil attributes:nil]) {
            addSkipBackupAttributeToItemAtURL([NSURL URLWithString:path]);
        }
        else {
            return nil;
        }
	}
	return path;
}

static NSString * createFileInPath(NSString *fileNamePath) {
	
	NSFileManager *fileHandle = [NSFileManager defaultManager];
	if(![fileHandle fileExistsAtPath:fileNamePath]) {
		if([fileHandle createFileAtPath:fileNamePath contents:nil attributes:nil]) {
            addSkipBackupAttributeToItemAtURL([NSURL URLWithString:fileNamePath]);
        }
        else {
            return nil;
        }
	}
	return fileNamePath;
}


static long long fileSizeAtPath(NSString *filePath) {
    struct stat st;
    if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
        return st.st_size;
    }
    return 0;
}


static long long folderSizeAtDirectory(NSString *folderPath) {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += fileSizeAtPath(fileAbsolutePath);
    }
    return folderSize;
}


// notice: now theObject must only have NSString

#endif
