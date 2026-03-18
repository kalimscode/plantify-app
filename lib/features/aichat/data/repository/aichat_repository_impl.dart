import '../../domain/repository/aichat_repository.dart';
import '../datasource/aichat_remote_datasource.dart';

class AiChatRepositoryImpl implements AiChatRepository {
  final AiChatRemoteDataSource remote;

  AiChatRepositoryImpl(this.remote);

  @override
  Future<String> sendMessage(String message) {
    return remote.sendMessage(message);
  }
}