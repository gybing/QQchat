//
//  BackgroundViewController.m
//  机器人
//
//  Created by gyh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BackgroundViewController.h"
#import "BackgroundCell.h"
#import "HeaderView.h"
#import "ThemeManager.h"


@interface BackgroundViewController ()
{
    NSArray *_itemarray;
}

@property(nonatomic,strong) UIButton *btn;

@end

@implementation BackgroundViewController

static NSString * const reuseIdentifier = @"Cell";


-(instancetype)init
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake(120, 180);
    //cell垂直间距
    flow.minimumInteritemSpacing = 0;
    //cell水平间距
    flow.minimumLineSpacing = 0;
    //四周的间距
    // 上，左，下，右。
    flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    flow.headerReferenceSize = CGSizeMake(375, 30);
    return [super initWithCollectionViewLayout:flow];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];

    UINib *nib = [UINib nibWithNibName:@"BackgroundCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HeaderView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    
    ThemeManager *manager = [ThemeManager sharedInstance];
    _itemarray = [NSArray arrayWithArray:[manager listOfAllTheme]];
    self.collectionView.backgroundColor = [manager themeColor];
    
    //设置一个按钮，当被cell被选择的时候添加到cell上面
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(90, 0, 30, 30)];
    [btn setBackgroundImage:[UIImage imageNamed:@"icon_check_alt2"] forState:UIControlStateNormal];
    self.btn = btn;

}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _itemarray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BackgroundCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.nameLabel.text = _itemarray[indexPath.row];
 
    return cell;
}


//点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ThemeManager *defaultManager = [ThemeManager sharedInstance];
    [defaultManager changeThemeWithName:_itemarray[indexPath.row]];
    
    
    BackgroundCell * cell = (BackgroundCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell addSubview:self.btn];
    

   
}




//headerview

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        static NSString* reuseHeader = @"HeaderView";
        HeaderView *head = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeader forIndexPath:indexPath];
        
        NSString *title = @"主题切换";
        
        head.headerView.text = title;

        return head;
    }else
        return nil;

}



@end
