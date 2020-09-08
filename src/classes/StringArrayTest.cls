/**
 * Created by Bogdan on 07.09.2020.
 */

public with sharing class StringArrayTest {
    public static List<String> generateStringArray(Integer numberOfParameters) {
        List<String> strings = new List<String>();
        for (Integer i = 0; i < numberOfParameters; i++) {
            strings.add('Test ' + i);
        }
        return strings;
    }
}