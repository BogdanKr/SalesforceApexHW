/**
 * Created by Bogdan on 10.09.2020.
 */

public with sharing class AddPrimaryContact implements Queueable {
    private Contact contact;
    private String state;

    public AddPrimaryContact(Contact contact, String state) {
        this.contact = contact;
        this.state = state;
    }

    public void execute(QueueableContext param1) {
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE BillingState = :state LIMIT 200];
        List<Contact> contacts = new List<Contact>();
        for (Account acc : accounts) {
            Contact newContact = contact.clone();
            newContact.AccountId = acc.Id;
            contacts.add(newContact);
        }
        insert contacts;
    }
}