package cl.bennu.chat;

/**
 * Created with Intellij IDEA.
 * User: Ivan Tapia - Bennu Ltda.
 * Date: 16-12-14
 * Time: 03:16 PM
 */

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

@ServerEndpoint("/actions")
public class HelloWorldEndpoint {


   private static Set<Session> clients =
            Collections.synchronizedSet(new HashSet<Session>());

    @OnMessage
    public void onMessage(String message, Session session)
            throws IOException {
        System.out.println("Received : "+ message);

        synchronized(clients){
            for(Session client : clients){
                    client.getBasicRemote().sendText(message);
            }
        }

    }

    @OnOpen
    public void onOpen (Session session) throws IOException{
        String message = "t2Y0ErTm";
        clients.add(session);
        synchronized(clients){
            for(Session client : clients){
                client.getBasicRemote().sendText(message);
            }
        }
    }

    @OnClose
    public void onClose (Session session) throws IOException{
        String message = "mPkDBWTq";
        clients.remove(session);
        synchronized(clients){
            for(Session client : clients){
                client.getBasicRemote().sendText(message);
            }
        }
    }

}