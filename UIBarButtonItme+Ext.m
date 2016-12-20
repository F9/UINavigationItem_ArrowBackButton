//
//  UIBarButtonItme+Ext.m
//  RunCode
//
//  Created by Francesco Novelli on 24/07/15.
//  Copyright (c) 2015 runcode. All rights reserved.
//

#import "UIBarButtonItme+Ext.h"

#import <objc/runtime.h>

@implementation UINavigationItem (ArrowBackButton)

static char kArrowBackButtonKey;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method m1 = class_getInstanceMethod(self, @selector(backBarButtonItem));
        Method m2 = class_getInstanceMethod(self, @selector(arrowBackButton_backBarButtonItem));
        method_exchangeImplementations(m1, m2);
    });
}

- (UIBarButtonItem *)arrowBackButton_backBarButtonItem {
    UIBarButtonItem *item = [self arrowBackButton_backBarButtonItem];
    if (item) {
        return item;
    }
    
    item = objc_getAssociatedObject(self, &kArrowBackButtonKey);
    if (!item) {
        item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:NULL];
        objc_setAssociatedObject(self, &kArrowBackButtonKey, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return item;
}

@end
