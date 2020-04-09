package linksharing
import enums.Visibility
class Topic {
    String name
   // User createdBy

    Date dateCreated
    Date lastUpdated
   static hasMany = [subscriptions: Subscription, resources:Resource]
static belongsTo = [createdBy:User]
Visibility visibility


    static constraints = {
        name blank: false

        dateCreated nullable: true
        lastUpdated nullable: true
    }

}
