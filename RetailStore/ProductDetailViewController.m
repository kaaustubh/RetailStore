//
//  ProductDetailViewController.m
//  RetailStore
//
//  Created by Kaustubh on 21/10/16.
//  Copyright © 2016 Kaustubh. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "Utils.h"
#import "CartViewController.h"
#import "ProductManager.h"

@interface ProductDetailViewController ()

@property (nonatomic, weak) IBOutlet UILabel *productTitleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *productImageView;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (nonatomic, weak) IBOutlet UIButton *cartButton;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    
    self.title = @"Product Details";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Show Cart" style:UIBarButtonItemStylePlain target:self action:@selector(showCartButtonTapped:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateView];
}

-(IBAction)showCartButtonTapped:(id)sender
{
    CartViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CartControllerId"];
    [self.navigationController pushViewController:controller animated:YES];
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


-(void)updateView
{
    _productTitleLabel.text = _product.name;
    _priceLabel.text = [Utils getLocalCurrencyForPrice:_product.price];
    //Redundent code, remove it later
    
    int val = (int)_product.isInCart;
    if(val == 0)
    {
        self.cartButton.tag = 0;
        [_cartButton setTitle:@"Add to Cart" forState:UIControlStateNormal];
    }
    else
    {
        self.cartButton.tag = 1;
        [_cartButton setTitle:@"Remove from Cart" forState:UIControlStateNormal];
    }
    _productImageView.image = [UIImage imageNamed:_product.image];
}

-(IBAction)cartButonTapped:(id)sender
{
    [self toggleCartProduct];
}

-(void)toggleCartProduct
{
    if(_cartButton.tag == 1)
    {
        [[ProductManager sharedInstance] removeProductToCart:_product];
        [_cartButton setTitle:@"Add to Cart" forState:UIControlStateNormal];
        _cartButton.tag=0;
    }
    else
    {
        [[ProductManager sharedInstance] addProductToCart:_product];
        _cartButton.tag=1;
        [_cartButton setTitle:@"Remove from Cart" forState:UIControlStateNormal];
        
        
    }
}

@end
