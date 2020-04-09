package linksharing

class ReadingItem {
   // User user
   // Resource resource
    Boolean isRead
    static belongsTo = [user:User, resource:Resource]
}