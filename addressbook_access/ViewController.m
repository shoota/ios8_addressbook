//
//  ViewController.m
//  addressbook_access
//
//  Created by kumano shuta on 2015/01/27.
//  Copyright (c) 2015年 kumano shuta. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)getAddress:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *lastname;
@property (weak, nonatomic) IBOutlet UITextView *firstName;
@property (weak, nonatomic) IBOutlet UITextView *phone;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup afters loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getAddress:(id)sender {
    
    NSLog(@"pushed get address");
    
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc ]init];
    picker.peoplePickerDelegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}



/**
 ユーザ選択後の処理
 [note] iOS8でshouldContinueAfterSelectingPersonがdeprecated
 */
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person {
    
    NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    NSString *lastName  = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
    
    ABMultiValueRef phoneNumber = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    NSString *phone=@"";
    if(ABMultiValueGetCount(phoneNumber)) {
        phone = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phoneNumber, 0));
    }
    
    self.firstName.text = firstName;
    self.lastname.text  = lastName;
    self.phone.text     = phone;
    
    
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
                         didSelectPerson:(ABRecordRef)person
                         property:(ABPropertyID)property
                         identifier:(ABMultiValueIdentifier)identifier
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    NSLog(@"canceled");
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

@end
