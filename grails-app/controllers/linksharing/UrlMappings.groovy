package linksharing

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }
//        "/usernew2/goToDash/logout" {
//            controller = "linksharing.Usernew2"
//            action = "logout"
//        }

        "/"(controller: "Usernew2")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
