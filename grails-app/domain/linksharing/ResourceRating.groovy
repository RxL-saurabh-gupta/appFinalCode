package linksharing

class ResourceRating {

   // User user
    //Resource resource
    Integer score
    static belongsTo = [user:User, resource:Resource]
    static constraints = {
        score min:0
    }
}