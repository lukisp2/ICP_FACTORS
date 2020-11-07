

props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth',                'true');  % Note: 'true' as a string, not a logical value!
props.setProperty('mail.smtp.starttls.enable',     'true');  % Note: 'true' as a string, not a logical value!
props.setProperty('mail.smtp.socketFactory.port',  '587');   % Note: '465'  as a string, not a numeric value!
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
 
setpref('Internet', 'SMTP_Server',   'amw.gdynia.pl');
setpref('Internet', 'SMTP_Username', 'l.marchel@amw.gdynia.pl');
setpref('Internet', 'SMTP_Password', 'marchel');
 setpref('Internet','E_mail','l.marchel@amw.gdynia.pl');
%sendmail('l.marchel@amw.gdynia.pl', 'Hello', 'KONIEC');  
sendmail('l.marchel@amw.gdynia.pl', 'Hello world', 'What a nice day!')