/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package oyo;
import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

public class SMS {
    public static final String ACCOUNT_SID =
            DbConnection.sid;
    public static final String AUTH_TOKEN =
            DbConnection.token;
    public static void sendSMS(String phone){
        Twilio.init(ACCOUNT_SID, AUTH_TOKEN);

        Message message = Message
                .creator(new PhoneNumber(phone), // to
                        new PhoneNumber("+12015281868"), // from
                        "Welcome to Hotel Management System!")
                .create();

        System.out.println(message.getSid());
    }
    
}

