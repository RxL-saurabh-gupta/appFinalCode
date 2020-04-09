package linksharing
import enums.Seriousness
class Subscription {

   // User user
    //Topic topic
    static belongsTo = [user:User,topic:Topic]
 Seriousness seriousness
    Date dateCreated
    static constraints = {

    dateCreated nullable: true
    }
}
