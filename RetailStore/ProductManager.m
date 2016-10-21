//
//  ProductManager.m
//  RetailStore
//
//  Created by Kaustubh on 21/10/16.
//  Copyright © 2016 Kaustubh. All rights reserved.
//

#import "ProductManager.h"
#import "AppDelegate.h"
#import "Product.h"


@interface ProductManager()
@property NSMutableArray *products;
@property NSMutableArray *categories;

@end

@implementation ProductManager



+ (ProductManager *)sharedInstance {
    static dispatch_once_t once;
    static ProductManager * sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(NSMutableArray*)getCartProductItems
{
    NSMutableArray *products;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Unable to execute fetch request.");
        NSLog(@"%@, %@", error, error.localizedDescription);
        
    } else {
        NSLog(@"%@", result);
    }
    return products;
}

-(NSMutableArray*)getAllProducts
{
    if(self.products!=nil)
        return self.products;
    
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Product"];
    NSArray *fetchedObjectsProducts = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjectsProducts.count>0)
    {
        self.products = [fetchedObjectsProducts mutableCopy];
        return self.products;
    }
    
    // Read plist from bundle and get Root Dictionary out of it
    NSDictionary *dictRoot = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Products" ofType:@"plist"]];
    
    // Your dictionary contains an array of dictionary
    // Now pull an Array out of it.
    NSArray *arrayList = [NSArray arrayWithArray:[dictRoot objectForKey:@"Products"]];
    Product *product;
    self.products = [NSMutableArray array];
    
    for (NSDictionary *prodDictionary in arrayList)
    {
        product = (Product*)[NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:[self managedObjectContext]];
        product.name = prodDictionary[@"name"];
        product.price = prodDictionary[@"price"];
        product.image = prodDictionary[@"imagename"];
        product.category = prodDictionary[@"category"];
        product.isInCart = [NSNumber numberWithBool:false];
        [self.products addObject:product];
    }
    
    error = nil;
    // Save the object to persistent store
    if (![[self managedObjectContext] save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }

    
    return self.products;
}

-(NSMutableArray*)getAllCategories
{
    if(self.categories != nil)
        return self.categories;
    
    self.categories = [NSMutableArray array];
    
    if(self.products ==nil)
    {
        [self getAllProducts];
    }
    for (Product *product in self.products)
    {
        switch (product.category.integerValue) {
            case 0:
            {
                
                if(![self.categories containsObject:@"Electronics"])
                {
                    
                    [self.categories addObject:@"Electronics"];
                }
            }
                break;
            case 1:
            {
                 if(![self.categories containsObject:@"Furniture"])
                     [self.categories addObject:@"Furniture"];
            }
                
                break;
                
            default:
                break;
        }
    }

    return self.categories;
}

-(NSMutableArray *)getProductsForCategory:(NSString*)category
{
    NSMutableArray *products;
    if ([category caseInsensitiveCompare:@"Electronics"] == NSOrderedSame)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == 0"];
        NSArray *filtered = [self.products filteredArrayUsingPredicate:predicate];
        return [filtered mutableCopy];
    }
    else  if ([category caseInsensitiveCompare:@"Furniture"] == NSOrderedSame)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == 1"];
        NSArray *filtered = [self.products filteredArrayUsingPredicate:predicate];
        return [filtered mutableCopy];
    }
    
    return products;
}

-(bool)addProductToCart:(Product*)product
{
    bool success = false;
    product.isInCart = [NSNumber numberWithBool:YES];
    NSError *error = nil;
    // Save the object to persistent store
    if (![[self managedObjectContext] save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        return false;
    }
    else success = true;
    
    return success;
}


@end
