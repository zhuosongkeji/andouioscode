//
//  AddressView.m
//  SPPickerView
//
//  Created by Libo on 2018/8/31.
//  Copyright © 2018年 Cookie. All rights reserved.
//

#import "AddressView.h"
#import "SPPickerView.h"
#import "SPPageMenu.h"

@interface AddressView() <SPPickerViewDatasource,SPPickerViewDelegate, SPPageMenuDelegate>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) SPPageMenu *pageMenu;

@property (nonatomic, strong) NSMutableArray *provinces;

@property (nonatomic, strong) ZBNProvince *selectedProvince;
@property (nonatomic, strong) ZBNCity *selectedCity;
@property (nonatomic, strong) ZBNArea *selectedArea;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) SPPickerView *pickerView;

@property (nonatomic, assign) NSInteger numerOfComponents;

@end

@implementation AddressView 

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.containerView];
    
        [self.containerView addSubview:self.topView];
        [self.topView addSubview:self.topLabel];
        [self.topView addSubview:self.pageMenu];
        [self.topView addSubview:self.closeButton];
        [self.containerView addSubview:self.pickerView];
        
        // 默认1列
        self.numerOfComponents = 1;
        
    }
    return self;
}



- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    
    self.provinces = [ZBNProvince mj_objectArrayWithKeyValuesArray:datas];
    self.selectedProvince = self.provinces.firstObject;
    self.selectedCity = self.selectedProvince.cities.firstObject;
    
    [self.pickerView sp_reloadAllComponents];
}

#pragma mark - SPPageMenuDelegate

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index {
    [self.pickerView sp_scrollToComponent:index atComponentScrollPosition:SPPickerViewComponentScrollPositionDefault animated:YES];
}

#pragma mark - SPPickerViewDatasource,SPPickerViewDelegate
// 返回多少列
- (NSInteger)sp_numberOfComponentsInPickerView:(SPPickerView *)pickerView {
    return self.numerOfComponents;
}

// 每一列返回多少行
- (NSInteger)sp_pickerView:(SPPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinces.count;
    } else if (component == 1) {
        return self.selectedProvince.cities.count;
    } else {
        return self.selectedCity.areas.count;
    }
}

// ------------------------------  3个代理方法，优先级逐次提高，当同时实现时按照优先级较高的显示 --------------------------

// 每一列每一行的普通文本
- (nullable NSString *)sp_pickerView:(SPPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        ZBNProvince *province = self.provinces[row];
        return province.name;
    } else if (component == 1) {
        ZBNCity *city = self.selectedProvince.cities[row];
        return city.name;
    } else {
        ZBNArea *area = self.selectedCity.areas[row];
        return area.name;
    }
}


// 行高
- (CGFloat)sp_pickerView:(SPPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}

// 行宽
- (CGFloat)sp_pickerView:(SPPickerView *)pickerView rowWidthForComponent:(NSInteger)component {
    return kScreenWidth;
}

// 点击了哪一列的哪一行
- (void)sp_pickerView:(SPPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        
        self.selectedProvince = self.provinces[row];
        self.selectedCity = [self.selectedProvince.cities firstObject];
        self.selectedArea = [self.selectedCity.areas firstObject];
        self.numerOfComponents = 2;
        [pickerView sp_reloadAllComponents]; // 列数改变一定要刷新所有列才生效
        if ([self isEspecialCity:self.selectedProvince]) {
            [self setupPageMenuWithName:[NSString stringWithFormat:@"%@市",self.selectedProvince.name]atComponent:component];
        } else {
            [self setupPageMenuWithName:self.selectedProvince.name atComponent:component];
        }
        
    } else if (component == 1) {
        
        self.selectedCity = self.selectedProvince.cities[row];
        self.selectedArea = [self.selectedCity.areas firstObject];

        self.numerOfComponents = 3;
        [pickerView sp_reloadAllComponents]; // 列数改变一定要刷新所有列才生效
        [self setupPageMenuWithName:self.selectedCity.name atComponent:component];
        
    } else {
        self.selectedArea = self.selectedCity.areas[row];
        [self.pageMenu setTitle:self.selectedArea.name forItemAtIndex:component];
        self.pageMenu.selectedItemIndex = component;
        
        if (self.lastComponentClickedBlock) {
            self.lastComponentClickedBlock(self.selectedProvince, self.selectedCity, self.selectedArea);
        }
    }
}

- (void)setupPageMenuWithName:(NSString *)name atComponent:(NSInteger)component {
    NSString *title = [self.pageMenu titleForItemAtIndex:component];
    if ([title isEqualToString:@"请选择"]) {
        [self.pageMenu insertItemWithTitle:name atIndex:component animated:YES];
    } else {
        // 改变当前item的标题
        [self.pageMenu setTitle:name forItemAtIndex:component];
        // 将下一个置为“请选择”
        [self.pageMenu setTitle:@"请选择" forItemAtIndex:component+1];
        NSInteger itemCount = (self.pageMenu.numberOfItems-1);
        // 保留2个item，2个之后的全部删除
        for (int i = 0; i < itemCount-(component+1); i++) {
            [self.pageMenu removeItemAtIndex:self.pageMenu.numberOfItems-1 animated:YES];
        }
    }
    // 切换选中的item，会执行pageMenu的代理方法，
    self.pageMenu.selectedItemIndex = component+1;
}

// 是否为直辖市
- (BOOL)isEspecialCity:(ZBNProvince *)province {
    if ([province.name isEqualToString:@"北京"] ||
        [province.name isEqualToString:@"天津"] ||
        [province.name isEqualToString:@"上海"] ||
        [province.name isEqualToString:@"重庆"])
    {
        return YES;
    }
    return NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.containerView.frame = self.bounds;
    
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    CGFloat topViewH = 65;
    CGFloat topViewW = kScreenWidth;
    self.topView.frame = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    CGFloat topLabelW = 120;
    CGFloat topLabelH = 30;
    CGFloat topLabelX = (topViewW-topLabelW)/2;
    CGFloat topLabelY = 5;
    self.topLabel.frame = CGRectMake(topLabelX, topLabelY, topLabelW, topLabelH);
    
    CGFloat closeButtonW = 30;
    CGFloat closeButtonH = closeButtonW;
    CGFloat closeButtonX = topViewW-closeButtonW-10;
    CGFloat closeButtonY = topLabelY;
    self.closeButton.frame = CGRectMake(closeButtonX, closeButtonY, closeButtonW, closeButtonH);
    
    CGFloat pageMenuX = 0;
    CGFloat pageMenuY = 35;
    CGFloat pageMenuW = topViewW;
    CGFloat pageMenuH = 30;
    self.pageMenu.frame = CGRectMake(pageMenuX, pageMenuY, pageMenuW, pageMenuH);
    
    CGFloat pickerViewX = 0;
    CGFloat pickerViewY = topViewH;
    CGFloat pickerViewW = topViewW;
    CGFloat pickerViewH = self.containerView.bounds.size.height-topViewH;
    self.pickerView.frame = CGRectMake(pickerViewX, pickerViewY, pickerViewW, pickerViewH);
}

// 关闭页面
- (void)closeButtonAction {
    
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
    }
    return  _topView;
}

- (UILabel *)topLabel {
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.text = @"请选择地址";
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return  _topLabel;
}

- (SPPageMenu *)pageMenu {
    if (!_pageMenu) {
        _pageMenu = [SPPageMenu pageMenuWithFrame:CGRectZero trackerStyle:SPPageMenuTrackerStyleLine];
        _pageMenu.delegate = self;
        [_pageMenu setItems:@[@"请选择"] selectedItemIndex:0];
        _pageMenu.itemTitleFont = [UIFont systemFontOfSize:14];
        _pageMenu.selectedItemTitleColor = [UIColor redColor];
        _pageMenu.unSelectedItemTitleColor = [UIColor grayColor];
        [_pageMenu setTrackerHeight:1 cornerRadius:0];
        _pageMenu.itemPadding = 50;
        _pageMenu.bridgeScrollView = self.pickerView.scrollView;
    }
    return  _pageMenu;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _closeButton;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return  _containerView;
}

- (SPPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[SPPickerView alloc] init];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;

    }
    return  _pickerView;
}

- (NSMutableArray *)provinces
{
    if (!_provinces) {
        _provinces = [NSMutableArray array];
    }
    return _provinces;
}

@end
