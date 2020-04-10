package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class ResourceService {

    List<LinkResource> getTopicLR(Topic topic){
        return LinkResource.findAllByTopic(topic)
    }
    List<DocumentResource> getTopicDR(Topic topic){
        return DocumentResource.findAllByTopic(topic)
    }
    Resource getResource(params){
        return Resource.get(params.resourceId)
    }
    List<LinkResource> getLinkResources(){
        return LinkResource.list()
    }
    List<LinkResource> getDocumentResources(){
        return DocumentResource.list()
    }
    List<LinkResource> getMatchingLR(String name,List l){
        List lresourceName=LinkResource.createCriteria().list {
            ilike("description",name)
            inList("topic",l)

        }
        return lresourceName
    }
    List<DocumentResource> getMatchingDR(String name,List l){
        List dresourceName=DocumentResource.createCriteria().list {
            ilike("description",name)
            inList("topic",l)

        }
        return dresourceName
    }
    List<LinkResource> getPublicLR(List publicTopics){
        List lresourceName=LinkResource.createCriteria().list {
            inList("topic",publicTopics)
        }
        return lresourceName
    }
    List<DocumentResource> getPublicDR(List publicTopics){
        List dresourceName=DocumentResource.createCriteria().list {
            inList("topic",publicTopics)
        }
        return dresourceName
    }
}
