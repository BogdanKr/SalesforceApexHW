/**
 * Created by Bogdan on 08.09.2020.
 */
public with sharing class AddTaskToAccount {

    @InvocableMethod(Label='Give a Task to Account'
            Description='Give up to 3 Tasks to updated (or new) Account'
            Category='Account')
    public static void addTaskToContact(List<CreateTaskRequest> cTaskRequests) {
        for (CreateTaskRequest cTaskRequest : cTaskRequests) {
            createUpToThreeTasks(cTaskRequest);
        }
    }

    public static void createUpToThreeTasks(CreateTaskRequest cTaskRequest) {
        Integer countTasks = [SELECT COUNT() FROM Task WHERE AccountId = :cTaskRequest.accountId];
        if (countTasks <= 3) {
            Task newTask = new Task(Subject = cTaskRequest.subject, WhatId = cTaskRequest.accountId);
            insert newTask;
        } else {
            List<Task> tasks = [SELECT Id FROM Task WHERE Account.Id = :cTaskRequest.accountId];
            assignNewOwner(tasks);
            update tasks;
        }
    }

    public static void assignNewOwner(List<Task> tasks) {
        User newOwner = [SELECT Id FROM User LIMIT 1];
        for (Task t : tasks) {
            t.OwnerId = newOwner.Id;
        }
    }

    public class CreateTaskRequest {
        @InvocableVariable(Label='Account Id' Required=true)
        public Id accountId;
        @InvocableVariable(Label='Subject' Required=true)
        public String subject;
    }

}