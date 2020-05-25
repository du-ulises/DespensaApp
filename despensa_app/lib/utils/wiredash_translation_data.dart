import 'package:wiredash/wiredash.dart';

class MyTranslation extends WiredashTranslationData {
  String get captureBack => 'Volver';
  String get captureSkip => 'Saltar';
  String get captureTakeScreenshot => 'Tomar captura de pantalla';
  String get captureSaveScreenshot => 'Guardar captura de pantalla';
  String get captureSpotlightNavigateTitle => 'Navegar';
  String get captureSpotlightNavigateMsg =>
      'Navegue a la pantalla que le gustaría adjuntar a su captura.';
  String get captureSpotlightScreenCapturedTitle => 'Dibujar';
  String get captureSpotlightScreenCapturedMsg =>
      'Pantalla capturada! Siéntase libre de dibujar en la pantalla para resaltar las áreas afectadas por su captura. ';

  String get feedbackModeBugTitle => 'Informar un error';
  String get feedbackModeBugMsg =>
      'Háganos saber para que podamos enviar esto a nuestro control de errores';
  String get feedbackModeImprovementTitle => 'Solicitar una característica';
  String get feedbackModeImprovementMsg =>
      '¿Tienes una idea que mejoraría nuestra aplicación? ¡Nos encantaría saber!';
  String get feedbackModePraiseTitle => 'Enviar aplausos';
  String get feedbackModePraiseMsg =>
      "Háganos saber lo que realmente le gusta de nuestra aplicación, ¿tal vez podamos mejorarla aún más?";

  String get feedbackBack => 'Volver';
  String get feedbackCancel => 'Cancelar';
  String get feedbackSave => 'Guardar';
  String get feedbackSend => 'Enviar comentarios';
  String get feedbackStateIntroTitle => 'Despensa App.';
  String get feedbackStateIntroMsg =>
      "No podemos esperar para tener su opinión sobre nuestra aplicación. ¿Que te gustaría hacer?";
  String get feedbackStateFeedbackTitle => 'Tu opinión ✍️';
  String get feedbackStateFeedbackMsg =>
      'Estamos escuchando. Proporcione tanta información como sea necesaria para que podamos ayudarlo. ';
  String get feedbackStateEmailTitle => 'Manténgase al tanto 👇';
  String get feedbackStateEmailMsg =>
      'Si desea recibir actualizaciones sobre sus comentarios, ingrese su correo electrónico a continuación';
  String get feedbackStateSuccessTitle => 'Gracias ✌️';
  String get feedbackStateSuccessMsg =>
      'Eso es. ¡Muchas gracias por ayudarnos a crear una mejor aplicación! ';
  String get feedbackStateSuccessCloseTitle => 'Cerrar este cuadro de diálogo';
  String get feedbackStateSuccessCloseMsg =>
      '¡Gracias por enviar sus comentarios!';

  String get inputHintFeedback => 'Sus comentarios';
  String get inputHintEmail => 'Su correo electrónico';
  String get validationHintFeedbackEmpty => 'Proporcione sus comentarios';
  String get validationHintFeedbackLength =>
      'Sus comentarios son demasiado largos';
  String get validationHintEmail =>
      'Ingrese un correo electrónico válido o deje este campo en blanco';
}
