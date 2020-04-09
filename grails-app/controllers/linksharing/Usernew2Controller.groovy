package linksharing

class Usernew2Controller {
    UserService userService

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
        User user=User.get(session.user)
        def users = User.list()
        List<Topic> topic=Topic.findAllByCreatedBy(user)
        def subscribed = Subscription.findAllByUser(user)
        render(view:"/usernew2/systemUsers",model: [users:users,topic:topic,list:subscribed])
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
            List allLinkResources=LinkResource.list()
            def subscribed = Subscription.findAllByUser(users)
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
