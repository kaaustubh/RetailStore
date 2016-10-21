//
//  CartViewController.m
//  RetailStore
//
//  Created by Kaustubh on 22/10/16.
//  Copyright © 2016 Kaustubh. All rights reserved.
//

#import "CartViewController.h"
#import "Product.h"
#import "ProductManager.h"
#import "Utils.h"
#import "ProductDetailViewController.h"

@interface CartViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *totalPriceLabel;
@property (nonatomic, strong) Product *selectedProduct;

@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    self.totalPriceLabel.text = [Utils getLocalCurrencyForPrice:[[ProductManager sharedInstance] getCartValue]];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *productsForThisCategory = [[ProductManager sharedInstance] getProductsForCategory:[[[ProductManager sharedInstance] getAllCategories] objectAtIndex:section]];
    return [productsForThisCategory count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CartCellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    NSMutableArray *productsForThisCategory = [[ProductManager sharedInstance] getCartProducts];
    
    Product *product = [productsForThisCategory objectAtIndex:indexPath.row];
    cell.textLabel.text = product.name;
    cell.detailTextLabel.text = [Utils getLocalCurrencyForPrice:product.price];
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[ProductManager sharedInstance] getCartProducts] count];
}

#pragma UItableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Product *product =[[[ProductManager sharedInstance] getCartProducts] objectAtIndex:indexPath.row];
    _selectedProduct = product;
    [self performSegueWithIdentifier:@"ProductDetailSegueId" sender:self];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier caseInsensitiveCompare:@"ProductDetailSegueId"] == NSOrderedSame)
    {
        ProductDetailViewController *destinationViewController = (ProductDetailViewController*) segue.destinationViewController;
        destinationViewController.product = _selectedProduct;
    }
}


@end
