/**
 * Created by Bogdan on 07.09.2020.
 */

public with sharing class Test2 {
    public void test() {
        Account acct = new Account();
        acct.Name = 'Acme';
        String name = acct.Name;
        acct.Phone = '(415)555-1212';
        acct.NumberOfEmployees = 100;
        Object sobj1 = new Account(Name = 'Trailhead');
        List<Account> accounts = new List<Account>();

    }
}