/**
 * Created by Bogdan on 10.09.2020.
 */

@IsTest
public with sharing class TestVerifyDate {
    @IsTest
    private static void testDate2LessDate1() {
        Date date1 = Date.newInstance(2020, 11, 10);
        Date date2 = Date.newInstance(2020, 11, 01);
        Date expectedDate = Date.newInstance(2020, 11, 30);
        Date returnDate = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(expectedDate, returnDate);
    }

    @IsTest
    private static void testDate2In30Days() {
        Date date1 = Date.newInstance(2020, 11, 10);
        Date date2 = Date.newInstance(2020, 11, 20);
        Date expectedDate = date2;
        Date returnDate = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(expectedDate, returnDate);
    }



}