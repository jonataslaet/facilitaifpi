import 'components/mysql.dart';
import 'user_model.dart';

class UserRepository {
  
  Future<List<UserModel>> getUsers() async {
    final conn = await Mysql().getConnection();
    await conn.connect();
    final List<UserModel> myUsers = [];
    var result = await conn.execute('select * from users').onError(
      (error, stackTrace) {
        throw Exception(
          "Erro desconhecido ao listar usuários. Tente novamente mais tarde. Error: ${error.toString()}, StackTrace: ${stackTrace.toString()}");
      }
    );
    for (final row in result.rows) {
      myUsers.add(UserModel(
          userId: row.typedColAt<int>(0),
          email: row.colByName("email"),
          password: row.colByName("password")));
    }
    conn.close();

    return myUsers;
  }

  Future<UserModel> updateUser(int id, String email, String password) async {
    final conn = await Mysql().getConnection();
    await conn.connect();
    var result = await conn.execute(
      "UPDATE users SET email = :email, password = :password WHERE id = :id",
      {
        "email": email,
        "password": password,
        "id": id
      },
    ).onError(
      (error, stackTrace) {
        throw Exception(
          "Erro desconhecido ao atualizar usuário. Tente novamente mais tarde. Error: ${error.toString()}, StackTrace: ${stackTrace.toString()}");
      }
    );
    return UserModel(userId: result.lastInsertID.toInt(), email: email, password: password);
  }

  Future<UserModel> getUser(int id) async {
    final conn = await Mysql().getConnection();
    await conn.connect();
    final List<UserModel> myUsers = [];
    var result = await conn.execute("SELECT * FROM users WHERE id = :id",
      {
        "id": id
      }
    ).onError(
      (error, stackTrace) {
        throw Exception(
          "Erro desconhecido ao buscar usuário. Tente novamente mais tarde. Error: ${error.toString()}, StackTrace: ${stackTrace.toString()}");
      }
    );
    validateSearchUser(result.numOfRows);
    for (final row in result.rows) {
      myUsers.add(UserModel(
          userId: row.typedColAt<int>(0),
          email: row.colByName("email"),
          password: row.colByName("password")));
      
    }
    conn.close();
    return myUsers[0];
  }

  Future<UserModel> createUser(String email, String password) async {
    final conn = await Mysql().getConnection();
    await conn.connect();
    var result = await conn.execute(
      "INSERT INTO users (email, password) VALUES (:email, :password)",
      {
        "email": email,
        "password": password,
      },
    ).onError(
      (error, stackTrace) {
        throw Exception(
          "Erro desconhecido ao criar usuário. Tente novamente mais tarde. Error: ${error.toString()}, StackTrace: ${stackTrace.toString()}");
      }
    );
    conn.close();
    return UserModel(userId: result.lastInsertID.toInt(), email: email, password: password);
  }

  Future<void> deleteUser(int id) async {
    final conn = await Mysql().getConnection();
    await conn.connect();
    await conn.execute(
      "DELETE FROM cities WHERE id = :id", {"id": id}
    ).onError(
      (error, stackTrace) {
        throw Exception(
          "Erro desconhecido ao deletar usuário. Tente novamente mais tarde. Error: ${error.toString()}, StackTrace: ${stackTrace.toString()}");
      }
    );
    conn.close();
  }

  void validateSearchUser(int numOfRows) {
    if (numOfRows < 1) {
      throw Exception(
          "Não foi encontrado usuário com esse identificador.");
    }
    if (numOfRows > 1) {
      throw Exception(
          "Foi encontrado mais de 1 usuário com esse identificador.");
    }
  }
}
