package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class TopicsService {

boolean createTopic(params,session,flash){
    User users = User.get(session.user)
    Topic topic=Topic.findByNameAndCreatedBy(params.name,users)
    if(topic==null){
        Topic topic1=new Topic(name: params.name,visibility: params.visibility,createdBy: users)
        Subscription subscription = new Subscription(seriousness: "VERYSERIOUS",user:users,topic:topic1)
        users.save(flush:true,failOnError:true)
        topic1.save(flush:true,failOnError:true)
        subscription.save(flush:true,failOnError:true)
        flash.topicSaved="Topic saved"
    }
    else{
        flash.topicExists="Topic exists"
    }
    return true
}
    boolean linkAdded(params,session){
        User user = User.findByUsername(session.name)
        Topic topic = Topic.findById(params.linkTopic)
        LinkResource lResource = new LinkResource(description: params.description, createdBy: session.user, topic: topic,url:params.url)
        lResource.save(flush: true, failOnError: true)
        Resource re=Resource.createCriteria().get {
            and{
                eq("createdBy",user)
                eq("topic",topic)
                eq("id",lResource.id)
            }
        }
        List users=Subscription.createCriteria().list {
            projections{
                property("user")
            }
            eq("topic",topic)
        }
        if(users){
            users.each {User u->
                ReadingItem readingItem=new ReadingItem()
                readingItem.resource=re
                readingItem.user=u
                readingItem.isRead=false
                readingItem.save(flush:true,failOnError:true)
            }
        }
        return true
    }
    boolean documentAdded(params,session,request){
        User user = User.get(session.user)
        Topic topic=Topic.findById(params.linkTopic)
        Resource resource = Resource.findByTopicAndCreatedBy(topic,user)
        String dir1 = new Date()
        String dir2 = dir1.split(" ").join("")
        String dir = "/home/saurabh/grailsAppFile/${session.name}${dir2}.pdf"
        request.getFile("document1").transferTo(new File(dir))
        DocumentResource dResource = new DocumentResource(description: params.description, createdBy: session.user, topic: topic,filePath: dir)
        dResource.save(flush: true, failOnError: true)

        Resource re=Resource.createCriteria().get {
            and{
                eq("createdBy",user)
                eq("topic",topic)
                eq("id",dResource.id)
            }
        }
        println re.id
        //List users=Subscription.findAllByTopic(topic).user
        List users=Subscription.createCriteria().list {
            projections{
                property("user")
            }
            eq("topic",topic)
        }
        if(users){
            users.each {User u->
                ReadingItem readingItem=new ReadingItem()
                readingItem.resource=re
                readingItem.user=u
                readingItem.isRead=false
                readingItem.save(flush:true,failOnError:true)
            }
        }
        return true
    }

    List getUnreadResources(User user){
        List allUnreadResources=ReadingItem.createCriteria().list {
            projections{
                property("resource")
            }
            and{
                eq("isRead",false)
                eq("user",user)
            }
        }
        return allUnreadResources
    }
    List getReadResources(User user){
        List allReadResources=ReadingItem.createCriteria().list {
            projections{
                property("resource")
            }
            and{
                eq("isRead",true)
                eq("user",user)
            }
        }
        return allReadResources
    }
    boolean removeTopic(params){
        Topic topic=Topic.get(params.topicId)
        topic.delete(flush:true,failOnError: true)
        return true
    }
    boolean topicSubscription(params,session){
        User users=User.get(session.user)
        Topic topic=Topic.get(params.topicId)
        List resource=Resource.findAllByTopic(topic)
        Subscription subscription = new Subscription(seriousness: "SERIOUS",user:users,topic:topic)
        if(resource){
            resource.each {Resource r->
                ReadingItem readingItem=new ReadingItem()
                readingItem.resource=r
                readingItem.user=users
                readingItem.isRead=false
                readingItem.save(flush:true,failOnError:true)
            }
        }
        subscription.save(flush:true,failOnError:true)
        return true
    }
    boolean topicUnsubscription(params,flash){
        User users=User.get(params.userId)
        Topic topics=Topic.get(params.topicId)
        Subscription subscriptiondel=Subscription.findByTopicAndUser(topics,users)
        if(topics.createdBy.id!=users.id) {
            List res=Resource.findAllByTopic(topics)
            List read = ReadingItem.createCriteria().list {
                and {
                    inList("resource",res)
                    eq("user",users)
                }
            }
            read.each {
                ReadingItem r->
                    r.delete(flush: true, failOnError: true)
            }
            subscriptiondel.delete(flush: true, failOnError: true)
            flash.cannotUnsubscribe="You have unsubscribed this topic"
        }
        else {
            flash.cannotUnsubscribe = "You cannot unsubscribe topic created by you"
        }
        return true
    }
    boolean alterSeriousness(params,session){
        Topic topic=Topic.get(params.topic)
        User user=User.get(session.user)
        Subscription subscription=Subscription.findByTopicAndUser(topic,user)
        subscription.seriousness=params.se.toString()
        subscription.save(flush:true,failOnError:true)
        return true
    }
    boolean alterVisibility(params,session){
        User user=User.get(session.user)
        Topic topic=Topic.findById(params.topic)
        topic.visibility=params.se.toString()
        topic.save(flush:true, failOnError:true)
        return true
    }
    boolean alterTopicName(params,flash){
        Topic topic=Topic.get(params.topicId)
        User user=topic.createdBy
        Topic topic1=Topic.findByCreatedByAndName(user,params.topicNewName)
        if(topic1==null) {
            topic.name = params.topicNewName
            topic.save(flush: true, failOnError: true)
            flash.nameChanged="Name changed"
        }
        else
            flash.nameChanged="Choose different name please"
        return true
    }

    Topic getTopic(params){
        return Topic.get(params.topicShowId)
    }

    List<Topic> getAllTopics(){
        List allSystemTopics=Topic.createCriteria().list {
            order("name")
        }
        return allSystemTopics
    }
    List<Topic> getPublicTopics(User user){
        List publicUserTopics=Topic.findAllByCreatedByAndVisibility(user,"PUBLIC")
        return publicUserTopics
    }
    List<Topic> getPrivateTopics(User user){
        List privateUserTopics=Topic.findAllByCreatedByAndVisibility(user,"PRIVATE")
        return privateUserTopics
    }


    ResourceRating getResourceRating(User user,Resource resource){
        ResourceRating.findByUserAndResource(user,resource)
    }
    List<Topic> getTopicByNameLike(String name){
        return Topic?.findAllByVisibilityAndNameIlike("PUBLIC",name)
    }

    List<Topic> allPublicTopics(){
        List l=Topic?.findAllByVisibility("PUBLIC")
        return l
    }

}
