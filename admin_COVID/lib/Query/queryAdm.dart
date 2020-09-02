class Adminstrador {
  // verificar login/senha
  queryLoginADM(String login, String senha) {
    String query = """
      query MyQuery {
          administrador(where: {login: {_eq: "$login"}, senha: {_eq: "$senha"}}) {
            senha
            login
          }
        }   
    """;
    return query;
  }
}
