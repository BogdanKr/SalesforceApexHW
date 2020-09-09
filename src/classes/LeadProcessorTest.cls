/**
 * Created by Bogdan on 09.09.2020.
 */

@IsTest
public with sharing class LeadProcessorTest {

    @IsTest
    public static void testBatch(){
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            leads.add(new Lead(LastName = 'Test' + i, Company = 'Test'));
        }
        insert leads;

        Test.startTest();
        LeadProcessor leadProcessor = new LeadProcessor();
        Database.executeBatch(leadProcessor);
        Test.stopTest();

        System.assertEquals(leads.size(), [SELECT COUNT() FROM Lead WHERE LeadSource = 'Dreamforce']);
    }

}