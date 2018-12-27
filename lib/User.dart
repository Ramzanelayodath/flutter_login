class User
{
   String username;
   String password;
   String name;
   User(this.username, this.password, this.name);

    User.fromMap(Map map)
    {
      username = map[username];
      password = map[password];
      name = map[name];
    }

}