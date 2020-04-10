package linksharing

class Usernew2Controller {
    UserService userService
    ResourceService resourceService
    SubscriptionService subscriptionService

    def logout() {
        session.invalidate()
        redirect(action: "index",controller:"usernew2" )
    }

    def index() {
        if(!session.name)
        render(view: "/usernew2/homepage",model: [list:userService.getLatestPublicTopics(),topPosts:userService.getTopPosts()])
        else
            redirect(action:"goToDash",controller: "usernew2")
    }

    def userDetails() {
        User user=userService.getUser(session)
        render(view:"/usernew2/systemUsers",model: [users:userService.getAllUsers(),list:subscriptionService.userSubscriptions(session)])
    }
    def addUser() {
        boolean userCreated= userService.newUser(params,flash)
        if(userCreated) {
            forward(action:'index' ,controller:"usernew2")
        }
        else {
            redirect(action: "index",controller:"usernew2")
        }
    }
    def goToDash() {
        if(session.name) {
            User users = User.findByUsername(session.name)
            List unreadResorces=ReadingItem.findAllByIsReadAndUser(false,users)
            List allLinkResources=resourceService.getLinkResources()
            def subscribed =subscriptionService.userSubscriptions(session)
            render(view: '/usernew2/dashboard',model: [list:subscribed,user:users,trendingTopics:userService.getTrendingTopics(),unreadResources:unreadResorces,allLinkResources:allLinkResources])
        }
        else
            redirect(action: "index",controller:"usernew2")
    }
    def loginuser() {
        boolean isRegistered=userService.isUserRegistered(params,flash,session)
        if(isRegistered==true){
           redirect(action: "goToDash")
        }
        else {
            redirect(action:'index',controller:"usernew2")
        }
    }

    def viewImage(Long userId){
        response.contentType = 'image/png'
        response.outputStream << User.findById(params.userId.toLong()).photo
        response.outputStream.flush()
    }

    def changeActiveStatus(Long user){
        userService.activeStatusChange(params)
        redirect(action: "userDetails", controller: "usernew2")

    }
    def setRemoveAdmin() {
        userService.adminSet(params)
        redirect(action: "userDetails", controller: "usernew2")
    }
}
