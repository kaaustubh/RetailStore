//
//  ProductManager.h
//  RetailStore
//
//  Created by Kaustubh on 21/10/16.
//  Copyright © 2016 Kaustubh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface ProductManager : NSObject

+ (ProductManager *)sharedInstance ;
-(NSMutableArray*)getAllProducts;
-(NSMutableArray*)getAllCategories;
-(NSMutableArray *)getProductsForCategory:(NSString*)category;
-(bool)addProductToCart:(Product*)product;

@end
