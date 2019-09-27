passowrd = "123123"
admin = User.create(username: "Admin" , email: "admin@gmail.com" , password: passowrd , password_confirmation: passowrd, role: 2)
leader = User.create(username: "Leader" , email: "leader@gmail.com" , password: passowrd , password_confirmation: passowrd, role: 1)
user = User.create(username: "User" , email: "user@gmail.com" , password: passowrd , password_confirmation: passowrd)
