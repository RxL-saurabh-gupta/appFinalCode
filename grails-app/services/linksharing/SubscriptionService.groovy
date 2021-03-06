package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class SubscriptionService {

    List userSubscriptions(session){
        User user=User.get(session.user)
        List subscriptions=Subscription.findAllByUser(user)
        return subscriptions
    }
    List userSubscribers(User user){
        List subscribers=Subscription.findAllByUser(user)
        return subscribers
    }
}
