import 'package:admin_chat/Model/cliente.dart';
import 'package:admin_chat/Query/queryCliente.dart';

class ClienteController {
  // cadastrar cliente
  cadastrar(Clientes clienteModel) async {
    return await ClienteQuery().queryCadastrarCliente(clienteModel);
  }

  // listar cliente
  listarCliente() {}

  // excluir cliente
  excluir(int id) async {
    return await ClienteQuery().queryExcluirCliente(id);
  }

  // alterar dados dos clientes
  alterar(int id, Clientes clientes) async {
    return await ClienteQuery().queryEditarCliente(id, clientes);
  }
}
