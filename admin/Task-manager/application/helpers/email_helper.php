<?php
require APPPATH.'third_party/phpMailer/vendor/autoload.php';
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

 function Send_Otp($body,$to,$to_name='')
 {
 	$mail = new PHPMailer(true);
     try {
    $mail->isSMTP();     
    $mail->Host       = 'smtp.gmail.com';  
    $mail->SMTPAuth   = true;      
    $mail->Username   = "mmfdeveloper123@gmail.com";
    $mail->Password   = "developer@mmfinfotech2020";    
    $mail->SMTPSecure = 'tls';   
    $mail->Port       = 587;
    $mail->setFrom("mmfdeveloper123@gmail.com", "Vocus App");
    $mail->addAddress($to, $to_name); 

    // Content
    $mail->isHTML(true);  

    $mail->Subject = " Forget Password ";
    $mail->Body    = $body;
    $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

    $mail->send();
    return   "Check Your mail";
} catch (Exception $e) {
    return "Message could not be sent.";
    // return "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
}
 }

 function SecureMail($body,$to,$to_name='')
 {
    $mail = new PHPMailer(true);
     try {
    $mail->isSMTP();     
    $mail->Host       = 'smtp.gmail.com';  
    $mail->SMTPAuth   = true;      
    $mail->Username   = "mmfdeveloper123@gmail.com";
    $mail->Password   = "developer@mmfinfotech2020";    
    $mail->SMTPSecure = 'tls';   
    $mail->Port       = 587;
    $mail->setFrom("mmfdeveloper123@gmail.com", "Task Manager");
    $mail->addAddress($to, $to_name); 

    // Content
    $mail->isHTML(true);  

    $mail->Subject = "New Device Login";
    $mail->Body    = $body;
    $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

    $mail->send();
    return   1;
} catch (Exception $e) {
    return 0;
    // return "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
}
 }

?>