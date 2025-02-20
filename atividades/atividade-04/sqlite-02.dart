import 'package:sqlite3/sqlite3.dart';

class Aluno {
  int? id;
  String nome;
  String dataNascimento;

  Aluno({this.id, required this.nome, required this.dataNascimento});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'data_nascimento': dataNascimento,
    };
  }

  @override
  String toString() {
    return 'Aluno{id: $id, nome: $nome, dataNascimento: $dataNascimento}';
  }
}

class AlunoDatabase {
  final Database db;

  AlunoDatabase._(this.db);

  static AlunoDatabase initialize(String path) {
    final db = sqlite3.open(path);
    db.execute('''
      CREATE TABLE IF NOT EXISTS tb_alunos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        data_nascimento TEXT NOT NULL
      )
    ''');
    return AlunoDatabase._(db);
  }

  void clearTable() {
    db.execute('DELETE FROM tb_alunos'); // Limpa todos os dados da tabela
    db.execute('VACUUM'); // Reorganiza o banco de dados
    print('Tabela limpa.');
  }


  int insertAluno(Aluno aluno) {
    db.execute(
      'INSERT INTO tb_alunos (nome, data_nascimento) VALUES (?, ?)',
      [aluno.nome, aluno.dataNascimento],
    );
    return db.lastInsertRowId; // Retorna o ID da última inserção
  }

  Aluno? getAluno(int id) {
    final result = db.select(
      'SELECT id, nome, data_nascimento FROM tb_alunos WHERE id = ?',
      [id],
    );
    if (result.isEmpty) return null;

    final row = result.first;
    return Aluno(
      id: row['id'] as int,
      nome: row['nome'] as String,
      dataNascimento: row['data_nascimento'] as String,
    );
  }

  List<Aluno> getAllAlunos() {
    final result = db.select('SELECT id, nome, data_nascimento FROM tb_alunos');
    return result.map((row) {
      return Aluno(
        id: row['id'] as int,
        nome: row['nome'] as String,
        dataNascimento: row['data_nascimento'] as String,
      );
    }).toList();
  }

  int updateAluno(Aluno aluno) {
    db.execute(
      'UPDATE tb_alunos SET nome = ?, data_nascimento = ? WHERE id = ?',
      [aluno.nome, aluno.dataNascimento, aluno.id],
    );
    return db.getUpdatedRows(); // Retorna o número de linhas afetadas
  }

  int deleteAluno(int id) {
    db.execute(
      'DELETE FROM tb_alunos WHERE id = ?',
      [id],
    );
    return db.getUpdatedRows(); // Retorna o número de linhas afetadas
  }

  void close() {
    db.dispose();
  }
}

void main() {
  final db = AlunoDatabase.initialize('aluno.db');

  // Limpar tabela antes de começar
  db.clearTable();

  // Adicionando o aluno Gabriel
  final pablo = Aluno(nome: 'Carlos Gabriel', dataNascimento: '2003-03-19');
  final pabloId = db.insertAluno(gabriel);

  // Atualizando o nome de Gabriel para Carlos Gabriel
  final alunoAtualizado = db.getAluno(gabrielId);
  if (alunoAtualizado != null) {
    alunoAtualizado.nome = 'Carlos Gabriel';
    db.updateAluno(alunoAtualizado);
    print('Aluno atualizado: $alunoAtualizado');
  }

  // Adicionando o aluno Lucas Muniz
  final marcia = Aluno(nome: 'Lucas Muniz', dataNascimento: '2003-10-11');
  db.insertAluno(marcia);

  // Recuperando e exibindo todos os alunos
  final alunos = db.getAllAlunos();
  print('Todos os alunos: $alunos');

  // Encerrando a conexão com o banco de dados
  db.close();
}
