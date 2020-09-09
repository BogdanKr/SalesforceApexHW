/**
 * Created by Bogdan on 09.09.2020.
 */

@IsTest
private with sharing class AccountProcessorTest {

    @IsTest
    private static void testCountContacts() {
        Account newAcc = new Account(Name = 'Test');
        insert newAcc;
        Contact firstContact = new Contact(LastName = 'Test', AccountId = newAcc.Id);
        Contact secondContact = new Contact(LastName = 'Test2', AccountId = newAcc.Id);
        insert firstContact;
        insert secondContact;
        List<Id> accountIds = new List<Id>(new Map<Id, Account>([SELECT Account.Id FROM Account]).keySet());

        Test.startTest();
        AccountProcessor.countContacts(accountIds);
        Test.stopTest();

        Account acc = [SELECT Number_of_Contacts__c, (SELECT Id FROM Contacts) FROM Account LIMIT 1];
        Integer countContacts = (Integer) acc.Number_of_Contacts__c;
        System.assertEquals(countContacts, acc.Contacts.size());
    }
}