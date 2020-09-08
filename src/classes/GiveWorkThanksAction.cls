/**
 * Created by Bogdan on 08.09.2020.
 */

global without sharing class GiveWorkThanksAction {

    @InvocableMethod(Label='Give a Thanks Badge')
    global static void giveWorkBadgeActionsBatch(List<GiveWorkThanksRequest> requests) {
        for(GiveWorkThanksRequest request: requests){
            giveWorkBadgeAction(request);
        }
    }

    public static void giveWorkBadgeAction(GiveWorkThanksRequest request) {
        WorkThanks newWorkThanks = new WorkThanks();
        newWorkThanks.GiverId = request.giverId;
        newWorkThanks.Message = request.thanksMessage;
        newWorkThanks.OwnerId = request.giverId;
        insert newWorkThanks;
        WorkBadge newWorkBadge = new WorkBadge();
        // newWorkBadge.DefinitionId should be set to the ID for the Competitor Badge within this Org
        WorkBadgeDefinition workBadgeDef = [SELECT Id,Name FROM WorkBadgeDefinition WHERE Name = :request.badgeName LIMIT 1];
        newWorkBadge.DefinitionId = workBadgeDef.Id;
        newWorkBadge.RecipientId = request.receiverId;
        newWorkBadge.SourceId = newWorkThanks.Id ;
        //newWorkBadge.GiverId = request.giverId;
        insert newWorkBadge;
        WorkThanksShare newWorkThanksShare = new WorkThanksShare();
        newWorkThanksShare.ParentId = newWorkThanks.Id ;
        newWorkThanksShare.UserOrGroupId = request.receiverId;
        newWorkThanksShare.AccessLevel = 'Edit';
        insert newWorkThanksShare;
        FeedItem post = new FeedItem();
        post.ParentId = request.receiverId;
        post.CreatedById = request.giverId;
        post.Body = request.thanksMessage;
        post.RelatedRecordId = newWorkThanks.Id ;
        post.Type = 'RypplePost';
        insert post;
    }

    global class GiveWorkThanksRequest {

        @InvocableVariable(Label='Giver Id' Required=true)
        global Id giverId;
        @InvocableVariable(Label='Receiver Id' Required=true)
        global Id receiverId;
        @InvocableVariable(Label='Thanks Message' Required=true)
        global String thanksMessage;
        @InvocableVariable(Label='Badge Name' Required=true)
        global String badgeName;
    }
}