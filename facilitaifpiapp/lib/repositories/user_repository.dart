import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mysql_client/mysql_client.dart';

import '../components/mysql.dart';
import '../models/user_model.dart';

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
      myUsers.add(
        UserModel(
          userId: row.typedColAt<int>(0),
          email: row.colByName("email"),
          password: row.colByName("password"),
          avatarUrl: row.colByName("avatar_url"),
          name: row.colByName("name"),
          latitude: row.typedColAt<double>(5),
          longitude: row.typedColAt<double>(6),
        ));
    }
    conn.close();

    return myUsers;
  }

  Future<UserModel> updateUser(int id, String email, String password, String name, String avatarUrl) async {
    final conn = await Mysql().getConnection();
    await conn.connect();
    var result = await conn.execute(
      "UPDATE users SET email = :email, password = :password, name = :name, avatar_url = :avatar_url WHERE id = :id",
      {
        "email": email,
        "password": password,
        "name": name,
        "avatar_url": avatarUrl,
        "id": id
      },
    ).onError(
      (error, stackTrace) {
        throw Exception(
          "Erro desconhecido ao atualizar usuário. Tente novamente mais tarde. Error: ${error.toString()}, StackTrace: ${stackTrace.toString()}");
      }
    );
    conn.close();
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
          password: row.colByName("password"),
          avatarUrl: row.colByName("avatar_url"),
          name: row.colByName("name"),
          latitude: row.typedColAt<double>(5),
          longitude: row.typedColAt<double>(6),
        )
      );
      
    }
    conn.close();
    return myUsers[0];
  }

  Future<UserModel> getUserByEmailAndPassword(String email, String password) async {
    final conn = await Mysql().getConnection();
    await conn.connect();
    final List<UserModel> myUsers = [];
    var result = await conn.execute("SELECT * FROM users WHERE email = :email AND password = :password",
      {
        "email": email,
        "password": password
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
          password: row.colByName("password"),
          avatarUrl: row.colByName("avatar_url"),
          name: row.colByName("name"),
          latitude: row.typedColAt<double>(5),
          longitude: row.typedColAt<double>(6),
        )
      );
      
    }
    conn.close();
    return myUsers[0];
  }

  Future<UserModel> createUser(String email, String password, String name, String imageUrl, double latitude, double longitude) async {
    final conn = await Mysql().getConnection();
    await conn.connect();
    var result = await conn.execute(
      "INSERT INTO users (email, password, name, avatar_url, latitude, longitude) VALUES (:email, :password, :name, :avatar_url, :latitude, :longitude)",
      {
        "email": email,
        "password": password,
        "name": name,
        "avatar_url": imageUrl,
        "latitude": latitude,
        "longitude": longitude
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
      "DELETE FROM users WHERE id = :id", {"id": id}
    ).onError(
      (error, stackTrace) {
        throw Exception(
          "Erro desconhecido ao deletar usuário. Tente novamente mais tarde. Error: ${error.toString()}, StackTrace: ${stackTrace.toString()}");
      }
    );
    conn.close();
  }

  Future<Set<Marker>> getMarkers() async {
    final conn = await Mysql().getConnection();
    await conn.connect();
    Set<Marker> localMarkers = {};
    IResultSet result = await conn.execute('select * from users').onError(
      (error, stackTrace) {
        throw Exception(
          "Erro desconhecido ao listar usuários. Tente novamente mais tarde. Error: ${error.toString()}, StackTrace: ${stackTrace.toString()}");
      }
    );
    for (final row in result.rows) {
      Marker marker = Marker(
        markerId: MarkerId(row.colByName("name") ?? "Sem identificação"),
        position: LatLng(row.typedColAt<double>(5) ?? 0.0, row.typedColAt<double>(6) ?? 0.0),
      );
      print("markerId = ${marker.markerId.value}");
      localMarkers.add(marker);
    }
    conn.close();

    return localMarkers;
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
