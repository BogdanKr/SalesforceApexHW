/**
 * Created by Bogdan on 10.09.2020.
 */
@IsTest
public with sharing class DailyLeadProcessorTest {

    public static String CRON_EXP = '0 0 0 15 3 ? 2022';

    @IsTest
    static void testScheduledJob() {
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 100; i++) {
            leads.add(new Lead(LastName = 'Test' + i, Company = 'Test'));
            leads.add(new Lead(LastName = 'TestWithSource' + i, Company = 'Test', LeadSource = 'Source' + i));
        }
        insert leads;

        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledLeadProcessor',
                CRON_EXP,
                new DailyLeadProcessor());
        // Verify the scheduled job has not run yet.
        List<Lead> ld = [SELECT Id
        FROM Lead
        WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(0, ld.size(), 'Dreamforce LeadSource exist before job runs');
        // Stopping the test will run the job synchronously
        Test.stopTest();

        // Now that the scheduled job has executed,
        // check that our tasks were created
        ld = [SELECT Id
        FROM Lead
        WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(100,
                ld.size(),
                'Dreamforce was not added');
    }

}