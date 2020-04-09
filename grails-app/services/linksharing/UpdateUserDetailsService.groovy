package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class UpdateUserDetailsService {

   boolean updatePassword(params,session){
       User userFind=User.get(session.user)
       userFind.password=params.password1
       userFind.save(flush:true,failOnError:true)
       return true
   }

    boolean updateInfo(params,session,flash){
        User userFind=User.get(session.user)
        User uniquename=User.findByUsername(params.uname)
        if(uniquename==null){
            userFind.firstName=params.fname
            userFind.lastName=params.lname
            userFind.username=params.uname
            byte[] photo=params.photo.bytes
            userFind.photo=photo
            userFind.save(flush:true,failOnError:true)
            return true
        }
        else {
            flash.updateUnameUnique="Username should be unique"
            return false
        }
    }
    boolean postDeletion(params){
        Resource res=Resource.get(params.resourceId)
        res.delete(flush:true,failOnError:true)
        return true
    }
    boolean markRead(params,session){
        Resource resource=Resource.get(params.resourceId)
        User user=User.get(session.user)
        ReadingItem readingItem=ReadingItem.findByUserAndResource(user,resource)
        readingItem.isRead=true
        readingItem.save(flush:true,failOnError:true)
        return true
    }

    boolean postRatingChange(params,session){
        Resource resource=Resource.findById(params.resource)
        User user=User.get(session.user)
        ResourceRating resourceRating1=ResourceRating.findByUserAndResource(user,resource)
        if(resourceRating1==null){
            ResourceRating resourceRating=new ResourceRating(user: user,resource: resource,score: params.score)
            resourceRating.save(flush:true,failOnError:true)
        }
        else{
            resourceRating1.score=params.score.toLong()
            resourceRating1.save(flush:true,fainOnError:true)
        }
        return true
    }

    boolean passwordForgot(params,flash){
        User user=User.findByEmail(params.address)
        if(user) {
            def a= new Random()
            def b= a.toString().split("@")
            def info = "New password is \"${b[1]}\""
            def s = "New password requested"
            user.password=b[1]
            user.save(flush:true,failOnError:true)
            sendMail {
                to params.address
                subject s
                text info
            }

            flash.message = "Message sent at " + new Date()
        }
        else{
            flash.message = "wrong emailid"
        }
        return true
    }
    Long descriptionChange(params){
        Resource r=Resource.get(params.resourceId)
        r.description=params.description
        r.save(flush:true,failOnError:true)
        return r.id
    }

}
