/**
 * Created by Bogdan on 08.09.2020.
 */

public with sharing class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String name) {
        return [
                FIND :name
                IN NAME FIELDS
                        RETURNING Contact(Name), Lead(Name)
        ];
    }
}