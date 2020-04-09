package linksharing

import enums.Seriousness
import grails.converters.JSON
import org.springframework.web.multipart.MultipartFile


class TopicsController {
    UserService userService
    TopicsService topicsService
    def index() {
    }

    def newTopic() {
        topicsService.createTopic(params,session,flash)
        redirect(action:"goToDash",controller:"usernew2")
    }


    def shareLink() {
        topicsService.linkAdded(params,session)
        flash.message = "Your link resource has been added"
        redirect(action: "goToDash",controller : "usernew2")
    }

    def shareDoc(MultipartFile document1) {
        topicsService.documentAdded(params,session,request)
        flash.message1 = "Your document resource has been added"
        redirect(action:"goToDash",controller: "usernew2")
    }

    def topicsShow(){
        Topic topics= Topic.get(params.topicShowId)
        User user=User.get(session.user)
        List lr=LinkResource.findAllByTopic(topics)
        List dr=DocumentResource.findAllByTopic(topics)
        Subscription subs=Subscription.findByTopicAndUser(topics,user)
        def subscribed = Subscription.findAllByUser(user)
        render(view: "/usernew2/topicshow", model: [topics:topics,listLR:lr,listDR:dr,subs:subs,allUnreadResources:topicsService.getUnreadResources(user),allReadResources:topicsService.getReadResources(user),list:subscribed])
    }

    def send() {
        sendMail {
            to params.address
            subject params.subject
            text params.body
        }

        flash.message = "Message sent at "+new Date()
        redirect (controller: "usernew2",action: "goToDash")
    }

    def deleteTopic()
    {
        topicsService.removeTopic(params)
        flash.message="Topic Deleted"
        redirect(action: "goToDash",controller: "usernew2")
    }

    def downloadDocumentResource(){
        DocumentResource dResource=DocumentResource.get(params.drId)
        def file = new File(dResource.filePath)
        if (file.exists()) {
            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "filename=${file.name}")
            response.outputStream << file.bytes
            return
        }
    }


    def subscribeToTopic()
    {
        topicsService.topicSubscription(params,session)
        redirect(action: "goToDash", controller: "usernew2")
    }


    def unsubscribeFromTopic(){
        topicsService.topicUnsubscription(params,flash)
        redirect(controller: "usernew2", action: "goToDash")
    }

    def changeSeriousness(){
        topicsService.alterSeriousness(params,session)
        render([success:true,statusCode:200] as JSON)

    }
    def changeVisibility(){
        topicsService.alterVisibility(params,session)
        render([success:true,statusCode:200] as JSON)

    }
    def changeTopicName(){
        topicsService.alterTopicName(params,flash)
        redirect(controller: "usernew2", action: "goToDash")
    }
    def allTopicsAdmin(){
        User user=User.get(session.user)
        List<Topic> topic=Topic.findAllByCreatedBy(user)
        def subscribed = Subscription.findAllByUser(user)
        List allSystemTopics=Topic.createCriteria().list {
            order("name")
        }
        render(view: "allTopics",model: [topic:topic,list:subscribed,allSystemTopics:allSystemTopics])
    }
    def allUserSubscriptions(){
        List subscribed=topicsService.userSubscriptions(session)
        render(view: "/topics/allSubscriptions",model: [list: subscribed])

    }
}
