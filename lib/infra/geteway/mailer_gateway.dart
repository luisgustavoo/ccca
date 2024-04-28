import 'dart:developer';

abstract class MailerGateway {
  Future<void> send({
    required String recipient,
    required String subject,
    required String content,
  });
}

class MailerGatewayMemory implements MailerGateway {
  @override
  Future<void> send({
    required String recipient,
    required String subject,
    required String content,
  }) async {
    log('$recipient $subject $content');
  }
}
