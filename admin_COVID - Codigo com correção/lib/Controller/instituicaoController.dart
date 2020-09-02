import 'package:admin_chat/Model/instituicao.dart';
import 'package:admin_chat/Query/queryInstituicao.dart';

class InstituicaoController {
  // cadastrar
  cadastrar(Instituicoes instituicoes) async {
    return await InstituicaoQuery().cadastrar(instituicoes);
  }

  // alterar instituição sem imagem
  alterarSemImgem(int id, Instituicoes instituicoes) async {
    return await InstituicaoQuery().alterarSemImagem(id, instituicoes);
  }

  // alterar instituição sem imagem
  alterarComImgem(int id, Instituicoes instituicoes) async {
    return await InstituicaoQuery().alterarComImagem(id, instituicoes);
  }

  // excluir instituição
  excluir(int id) async {
    return await InstituicaoQuery().excluir(id);
  }
}
