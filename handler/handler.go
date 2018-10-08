package handler

import (
	"fmt"
	"github.com/appleboy/gin-jwt"
	"github.com/gin-gonic/gin"
	"log"

	"../db"
	"../router/middleware"
)

var identityKey = "id"

// https://www.wafunny.com/blog/go/gin/gin.html
func RegisterHandler(c *gin.Context) {
	// name := c.DefaultPostForm("name")

}

func HelloHandler(c *gin.Context) {
	claims := jwt.ExtractClaims(c)
	log.Printf("Hello claims: %#v\n", claims)
	user, _ := c.Get(identityKey)

	log.Printf("Hello user: %#v\n", user)

	userDao := db.UserDao{}

	u3, err3 := userDao.GetUserRole(1)
	if err3 != nil {
		fmt.Println("err:", err3)
	} else {
		fmt.Println("the user role:", u3)

	}

	c.JSON(200, gin.H{
		"userID": claims["id"],
		// "userName": user.(*db.UserDao).UserName,
		"userName": user.(*middleware.User).UserName,
		"text":     "Hello World.",
		"uid":      claims["Uid"],
		"info":     u3,
	})
}
