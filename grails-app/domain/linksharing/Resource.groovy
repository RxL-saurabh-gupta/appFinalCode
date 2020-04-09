package linksharing

class Resource {
    String description
    //User createdBy
   // Topic topic
    static belongsTo = [topic:Topic,createdBy:User]
    Date dateCreated
    Date lastUpdated
    static hasMany = [readingItem:ReadingItem,resourceRating:ResourceRating]

    static constraints = {
        description blank:false
        dateCreated nullable: true
        lastUpdated nullable: true
    }
    static mapping = {
        table name:'Resourcenew'
    }
}