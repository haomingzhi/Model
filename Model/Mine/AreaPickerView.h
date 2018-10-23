


typedef enum {
    AreaPickerWithProvince=1,     //省
    AreaPickerWithCity=2,         //市
    AreaPickerWithCounty=4        //小区
}AreaPickerStyle;



@interface AreaPickerView : BaseViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIPickerView *locatePicker;
@property (nonatomic) AreaPickerStyle pickerStyle;

@property (weak, nonatomic) IBOutlet UILabel *labelSelected;

- (id)initWithStyle:(AreaPickerStyle)pickerStyle;

- (IBAction)handleOk:(id)sender;


@end
