package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class UserService {

List getLatestPublicTopics(){
    List publicTopics = Topic?.findAllByVisibility("PUBLIC")
    List latestUpdatedPublicTopics = Resource.createCriteria().list {
        and {
            inList("topic", publicTopics)
            order("lastUpdated", "desc")
        }
        maxResults(5)
    }

    return latestUpdatedPublicTopics
}

    List getTopPosts(){
        def topPosts = ResourceRating.createCriteria().list (max:5){
            projections{
                avg("score","b")
            }
            groupProperty("resource")
            order("b","desc")
        }
        return topPosts
    }


    List getTrendingTopics(){
        List publicTopics = Topic?.findAllByVisibility("PUBLIC")
        List userSubscriptions = Resource.createCriteria().list (max:5){
            projections{
                count("id","t")
            }
            inList("topic",publicTopics)
            groupProperty("topic")
            order("t","desc")
        }
        return userSubscriptions
    }

    boolean isUserRegistered(params,flash,session){
        User user=User.createCriteria().get{
            or{
                and{
                    eq("username",params.userid)
                    eq("password",params.password)
                }

                and{
                    eq("email",params.userid)
                    eq("password",params.password)
                }
            }
        }
        if(user && user.active){

                session.user=user.id
                session.name = user.username
                session.role = user.isAdmin
                session.fname = user.firstName
                session.lname = user.lastName
                String encoded = Base64.getEncoder().encodeToString(user.photo)
                session.setAttribute("userPhoto", encoded)
                return true


        }
        else {
            flash.userInactive="You are blocked or wrong credentials"
            return false
        }

    }

    boolean activeStatusChange(params){
        User user=User.get(params.user.toLong())
        if (user.active == false) {
            user.active = true
            user.save(flush: true, failOnError: true)
        } else {
            user.active = false
            user.save(flush: true, failOnError: true)
        }
        return true
    }
    boolean adminSet(params){
        User user=User.get(params.user)

        if(user.isAdmin==false) {
            user.isAdmin=true
            user.save(flush:true,failOnError:true)
        }
        else {
            user.isAdmin=false
            user.save(flush:true,failOnError:true)
        }
        return true
    }
    boolean newUser(params,flash){
        User user=User.findByEmailOrUsername(params.emailid,params.uname)
        if(user==null)
        {
            byte[] photo=params.file.bytes
            User user1= new User( firstName:params.fname,lastName:params.lname,password:params.password1,username:params.uname,email:params.emailid,photo:photo,isAdmin:false,active:true)
            user1.save(flush:true,failOnError:true)
            flash.regSuccess="You are registered"
            return true
        }
        else
        {
            flash.regerror2="Choose a different username/email. Already taken!!"
            return false
        }
    }
    User getUser(session){
        User user=User.get(session.user)
        return user
    }
    List getAllUsers(){
        return User.list()
    }



}
