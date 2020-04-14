package linksharing

import grails.converters.JSON

class UpdateUserDetailsController {
    UpdateUserDetailsService updateUserDetailsService
    TopicsService topicsService
    UserService userService
    ResourceService resourceService
    SubscriptionService subscriptionService

    def index() {
        User user=userService.getUser(session)
        List<Subscription> subscribed = subscriptionService.userSubscriptions(session)
        List<Topic> publicUserTopics=topicsService.getPublicTopics(user)
        List<Topic> privateUserTopics=topicsService.getPrivateTopics(user)
        render(view:"/updateUserDetails/editprofile",model: [list:subscribed,userprofile:user,publicUserTopics:publicUserTopics,privateUserTopics:privateUserTopics])
    }

    def updateUserPassword() {
        updateUserDetailsService.updatePassword(params,session)
        redirect(controller:"usernew2", action:"logout")
    }

    def updateUserInfo() {
        boolean result= updateUserDetailsService.updateInfo(params,session,flash)
        if(result==true){
            redirect(controller: "usernew2",action: "logout")
        }
        else {
            redirect(controller: "updateUserDetails",action: "index")
        }
    }

    def showPost(){
        Resource resource=resourceService.getResource(params)
        User users=userService.getUser(session)
        ResourceRating resourceRating=topicsService.getResourceRating(users,resource)
        List<LinkResource> allLinkResources=resourceService.getLinkResources()
        List<Subscription> subscribed = subscriptionService.userSubscriptions(session)
        render(view: "/updateUserDetails/posts",model: [trendingTopics:userService.getTrendingTopics(),postResource:resource,allLinkResources:allLinkResources,list:subscribed,resourceRating:resourceRating])
    }
    def deletePost(){
        updateUserDetailsService.postDeletion(params)
        redirect(controller: "usernew2",action: "goToDash")
    }
    def markAsRead(){
        updateUserDetailsService.markRead(params,session)
        redirect(controller: "usernew2",action: "goToDash")
    }
    def showUserProfile(){
        User users=User.get(params.userId)
        List<Subscription> subscribed = subscriptionService.userSubscriptions(session)
        List<Subscription> subscription=subscriptionService.userSubscribers(users)
        List<LinkResource> allLinkResources=resourceService.getLinkResources()
        List<Topic> publicUserTopics=topicsService.getPublicTopics(users)
        List<Topic> privateUserTopics=topicsService.getPrivateTopics(users)
        render(view: "/usernew2/userprofile",model: [list:subscribed,list1:subscription, userprofile:users,publicUserTopics:publicUserTopics,privateUserTopics:privateUserTopics,allUnreadResources:topicsService.getUnreadResources(users),allReadResources:topicsService.getReadResources(users),allLinkResources:allLinkResources])
    }
    def changeRating(){
        updateUserDetailsService.postRatingChange(params,session)
        render([success:true,statusCode:200] as JSON)
    }

    def searchContent(){
        String name1=params.content
        String name="%"+name1+"%"
        println name
        User user=userService.getUser(session)
        List<Subscription> subscribed = subscriptionService.userSubscriptions(session)
        List<Topic> publicTopics = topicsService.getTopicByNameLike(name)
        List<Topic> l=topicsService.allPublicTopics()
        if(publicTopics.isEmpty()){
            List<Topic> lresourceName=resourceService.getMatchingLR(name,l)
            List<Topic> dresourceName=resourceService.getMatchingDR(name,l)
            render(view: "/updateUserDetails/search",model: [listLR:lresourceName,listDR:dresourceName,list:subscribed, allUnreadResources:topicsService.getUnreadResources(user),allReadResources:topicsService.getReadResources(user),topPosts:userService.getTopPosts(),trendingTopics:userService.getTrendingTopics()])
        }
        else{
            List lresourceName=resourceService.getPublicLR(publicTopics)
            List dresourceName=resourceService.getPublicDR(publicTopics)
            render(view: "/updateUserDetails/search",model: [listLR:lresourceName,listDR:dresourceName,list:subscribed, allUnreadResources:topicsService.getUnreadResources(user),allReadResources:topicsService.getReadResources(user),topPosts:userService.getTopPosts(),trendingTopics:userService.getTrendingTopics()])
        }
    }

    def forgotPassword() {
        updateUserDetailsService.passwordForgot(params,flash)
        redirect(controller: "usernew2",action: "index")
    }
    def allSystemPosts(){
        User user=userService.getUser(session)
        def subscribed = subscriptionService.userSubscriptions(session)
        List lr=resourceService.getLinkResources()
        List dr=resourceService.getDocumentResources()
render(view: "allPosts",model: [list:subscribed,listLR:lr,listDR:dr,allUnreadResources:topicsService.getUnreadResources(user),allReadResources:topicsService.getReadResources(user)])
    }
    def changeDescription(){
        Long id=updateUserDetailsService.descriptionChange(params)
        redirect(controller: "updateUserDetails",action: "showPost",params:[resourceId:id])
    }
}
