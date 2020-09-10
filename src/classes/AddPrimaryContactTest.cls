/**
 * Created by Bogdan on 10.09.2020.
 */

@IsTest
public with sharing class AddPrimaryContactTest {
    @TestSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(Name = 'test NY', BillingState = 'NY'));
            accounts.add(new Account(Name = 'test CA', BillingState = 'CA'));
        }
        insert accounts;
    }

    @IsTest
    static void testQueueable() {
        Contact contact = new Contact(LastName = 'Test contact');
        insert contact;
        AddPrimaryContact addPrimaryContact = new AddPrimaryContact(contact, 'CA');
        Test.startTest();
        System.enqueueJob(addPrimaryContact);
        Test.stopTest();
        List<Account> accounts = [
                SELECT Id, (SELECT Id FROM Contacts)
                FROM Account
                WHERE BillingState = 'CA'
        ];
        Integer count = 0;
        for (Account acc : accounts) {
            if (acc.Contacts.size() > 0) {
                count = count + 1;
            }
        }
        System.assertEquals(50, count);
    }
//    [SELECT Id FROM Account
//    WHERE Id IN (SELECT AccountId FROM Contact)
}