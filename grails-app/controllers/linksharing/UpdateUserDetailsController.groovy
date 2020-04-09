package linksharing

import grails.converters.JSON

class UpdateUserDetailsController {
    UpdateUserDetailsService updateUserDetailsService
    TopicsService topicsService
    UserService userService

    def index() {
        User user=User.get(session.user)
        List<Topic> topic=Topic.findAllByCreatedBy(user)
        def subscribed = Subscription.findAllByUser(user)
        List publicUserTopics=Topic.findAllByCreatedByAndVisibility(user,"PUBLIC")
        List privateUserTopics=Topic.findAllByCreatedByAndVisibility(user,"PRIVATE")
        render(view:"/updateUserDetails/editprofile",model: [topic:topic,list:subscribed,userprofile:user,publicUserTopics:publicUserTopics,privateUserTopics:privateUserTopics])
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
        Resource resource=Resource.get(params.resourceId)
        User users=User.get(session.user)
        ResourceRating resourceRating=ResourceRating.findByUserAndResource(users,resource)
        List allLinkResources=LinkResource.list()
        List<Topic> topic=Topic.findAllByCreatedBy(users)
        def subscribed = Subscription.findAllByUser(users)
        render(view: "/updateUserDetails/posts",model: [trendingTopics:userService.getTrendingTopics(),postResource:resource,allLinkResources:allLinkResources,topic:topic,list:subscribed,resourceRating:resourceRating])
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
        List<Topic> topic=Topic.findAllByCreatedBy(users)
        def subscribed = Subscription.findAllByUser(users)
        List allLinkResources=LinkResource.list()
        List publicUserTopics=Topic.findAllByCreatedByAndVisibility(users,"PUBLIC")
        List privateUserTopics=Topic.findAllByCreatedByAndVisibility(users,"PRIVATE")
        render(view: "/usernew2/userprofile",model: [topic:topic,list:subscribed,userprofile:users,publicUserTopics:publicUserTopics,privateUserTopics:privateUserTopics,allUnreadResources:topicsService.getUnreadResources(users),allReadResources:topicsService.getReadResources(users),allLinkResources:allLinkResources])
    }
    def changeRating(){
        updateUserDetailsService.postRatingChange(params,session)
        render([success:true,statusCode:200] as JSON)
    }

    def searchContent(){
        String name1=params.content
        String name="%"+name1+"%"
        println name
        User user=User.get(session.user)
        List<Topic> topic=Topic.findAllByCreatedBy(user)
        def subscribed = Subscription.findAllByUser(user)
        List PublicTopics = Topic?.findAllByVisibilityAndNameIlike("PUBLIC",name)
        List l=Topic?.findAllByVisibility("PUBLIC")
        if(PublicTopics.isEmpty()){
            List lresourceName=LinkResource.createCriteria().list {
                ilike("description",name)
                inList("topic",l)

            }
            List dresourceName=DocumentResource.createCriteria().list {
                ilike("description",name)
                inList("topic",l)

            }
            render(view: "/updateUserDetails/search",model: [listLR:lresourceName,listDR:dresourceName,topic:topic,list:subscribed, allUnreadResources:topicsService.getUnreadResources(user),allReadResources:topicsService.getReadResources(user),topPosts:userService.getTopPosts(),trendingTopics:userService.getTrendingTopics()])
        }
        else{
            List lresourceName=LinkResource.createCriteria().list {
                inList("topic",PublicTopics)
            }
            List dresourceName=DocumentResource.createCriteria().list {
                inList("topic",PublicTopics)
            }
            render(view: "/updateUserDetails/search",model: [listLR:lresourceName,listDR:dresourceName,topic:topic,list:subscribed, allUnreadResources:topicsService.getUnreadResources(user),allReadResources:topicsService.getReadResources(user),topPosts:userService.getTopPosts(),trendingTopics:userService.getTrendingTopics()])
        }
    }

    def forgotPassword() {
        updateUserDetailsService.passwordForgot(params,flash)
        redirect(controller: "usernew2",action: "index")
    }
    def allSystemPosts(){
        User user=User.get(session.user)
        def subscribed = Subscription.findAllByUser(user)
        List lr=LinkResource.list()
        List dr=DocumentResource.list()
render(view: "allPosts",model: [list:subscribed,listLR:lr,listDR:dr,allUnreadResources:topicsService.getUnreadResources(user),allReadResources:topicsService.getReadResources(user)])
    }
    def changeDescription(){
        Long id=updateUserDetailsService.descriptionChange(params)
        redirect(controller: "updateUserDetails",action: "showPost",params:[resourceId:id])
    }
}
