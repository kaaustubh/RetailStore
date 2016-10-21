//
//  ProductManagerTestSpecs.m
//  RetailStore
//
//  Created by Kaustubh on 22/10/16.
//  Copyright © 2016 Kaustubh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ProductManager.h"

@interface ProductManagerTestSpecs : XCTestCase


@end

@implementation ProductManagerTestSpecs

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

-(void)testTotalNoOfProductsSpecs
{
    NSMutableArray *products = [[ProductManager sharedInstance] getAllProducts];
    NSDictionary *dictRoot = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Products" ofType:@"plist"]];
    
    // Your dictionary contains an array of dictionary
    // Now pull an Array out of it.
    NSArray *arrayList = [NSArray arrayWithArray:[dictRoot objectForKey:@"Products"]];
    XCTAssertEqual(products.count, arrayList.count);
}


-(void)testNoOfCategoriesSpecs
{
    NSMutableArray *categories = [[ProductManager sharedInstance] getAllCategories];
    XCTAssertEqual(categories.count, 2);
}

-(void)testAddToCartSpecs
{
    NSMutableArray *products = [[ProductManager sharedInstance] getAllProducts];
    Product *productToAddToCart = products[0];
    [[ProductManager sharedInstance] addProductToCart:productToAddToCart];
    NSMutableArray *cartProducts = [[ProductManager sharedInstance] getCartProducts];
    BOOL isProductAdded = false;
    if([cartProducts containsObject:productToAddToCart])
    {
        isProductAdded = true;
    }
    
    XCTAssertTrue(isProductAdded);
}

-(void)testRemoveProductFromCartSpecs
{
    NSMutableArray *products = [[ProductManager sharedInstance] getAllProducts];
    Product *productToAddToCart = products[0];
    [[ProductManager sharedInstance] addProductToCart:productToAddToCart];
    NSMutableArray *cartProducts = [[ProductManager sharedInstance] getCartProducts];
    BOOL isProductAdded = false;
    if([cartProducts containsObject:productToAddToCart])
    {
        isProductAdded = true;
    }
    
    XCTAssertTrue(isProductAdded);
    
    BOOL isProductRemoved = false;
    [[ProductManager sharedInstance] removeProductToCart:productToAddToCart];
    cartProducts = [[ProductManager sharedInstance] getCartProducts];
    if([cartProducts containsObject:productToAddToCart])
    {
        isProductRemoved = true;
    }
    XCTAssertTrue(isProductAdded);
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
