import 'package:mysql_client/mysql_client.dart';

class Mysql {
  /*
  Os dados abaixo são referentes ao banco de dados.
  Esses dados devem ser EXATAMENTE OS MESMOS setados ao se criar o banco de dados.
  Para essa criação foi utilizado o docker, por meio do arquivo docker-compose.yml,
  então EXATAMENTE OS MESMOS dados a seguir estão setados nesse arquivo docker-compose.yml
  */
  static String host = '172.20.112.1'; //Este é meu endereço IPv4 local (se o seu for diferente, altere aqui e no arquivo docker-compose.yml)
  static int port = 3306;
  static String db = 'dbfacilitaifpiapp';
  static String user = 'laet';
  static String password = 'laet273';

  Mysql();

  Future<MySQLConnection> getConnection() async {
    final conn = await MySQLConnection.createConnection(
        //Os dados abaixo são os setados no docker-compose.yml
        host: host, //Esse IP deve ser o IPv4 local
        port: port,
        userName: user,
        databaseName: db,
        password: password);
    conn.connect();
    conn.execute('CREATE TABLE if not exists users (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, email varchar(64), password varchar(128), name varchar(64), avatar_url varchar(256), latitude double precision (12,8), longitude double precision (12,8))');
    conn.close();
    return conn;
  }

}