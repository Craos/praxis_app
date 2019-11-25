library praxis.globals;
import 'package:praxis/modelos/Atividades.dart';

List<Atividades> atividades;
var firstCamera;


String ATIVIDADES_URL = 'http://api.craos.net/praxis/atividades';
String EXECUCAO_URL = 'http://api.craos.net/praxis/execucao';
String APP_NAME = 'Práxis';
double APP_BORDER_RADIUS = 5;
double APP_ELEVATION = 2;
String APP_DB = ''' 
    
        create table atividades
        (
          id integer not null constraint atividades_pk primary key autoincrement,
          firstdate TEXT,
          lastdate TEXT,
          purgedate TEXT,
          firstuser varchar(255),
          lastuser varchar(255),
          purgeuser varchar(255),
          contrato int,
          titulo varchar,
          descricao varchar,
          responsavel varchar,
          situacao integer,
          progresso int
        );
        
        create table execucao
        (
          id integer not null constraint atividades_pk primary key autoincrement,
          firstdate TEXT,
          lastdate TEXT,
          purgedate TEXT,
          firstuser varchar(255),
          lastuser varchar(255),
          purgeuser varchar(255),
	        pmo integer,
	        observacoes varchar,
	        documento varchar,
	        documento_tipo varchar
        );
    
    ''';

void logError(String code, String message) =>
  print('Erro: $code\n Messagem: $message');