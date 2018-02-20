<%--
  Created by IntelliJ IDEA.
  User: bennu
  Date: 16-12-14
  Time: 02:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>Socket.IO chat</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font: 13px Helvetica, Arial; }
        form { background: #000; padding: 3px; position: fixed; bottom: 0; width: 100%; }
        form input { border: 0; padding: 10px; width: 90%; margin-right: .5%; }
        form button { width: 9%; background: rgb(71, 195, 166); border: none; padding: 10px; }
        #messages { list-style-type: none; margin: 0; padding: 0; }
        #messages li { padding: 5px 10px; }
        #messages li:nth-child(odd) { background: #eee; }
    </style>
</head>
<body>
<ul id="messages"></ul>
<form action="">
    <input id="msg" autocomplete="off" /><button>Send</button>
</form>
<script src="http://cdn.socket.io/socket.io-1.2.0.js"></script>
<script src="http://code.jquery.com/jquery-1.11.1.js"></script>
<script src="js/notify/notify.min.js"></script>

<script>
    var port = "";
    var userName = 'bennu' + Math.floor((Math.random()*1000)+1);
    if (window.location.host.search(".rhcloud.com") > 0) {
        port = ":8000";
    }
    var url = 'ws://' + window.location.host + port + window.location.pathname + 'actions';
    var websocket = new WebSocket(url);
    console.log(url);
    websocket.onmessage = function(msg) {
        console.log(msg);
        if(msg.data=='t2Y0ErTm'){
            $.notify('Usuario conectado','success');

        }
        else if(msg.data == 'mPkDBWTq'){
            $.notify('Usuario desconectado','error');
        }
        else{
            $('#messages').prepend($('<li>').text(msg.data));

        }

    };
    websocket.onconnect = function(e) {
    }
    websocket.onerror = function (error) {
        console.log('WebSocket Error ' + error);
    };
    websocket.onclose = function(event){

    };

    $('form').submit(function(){
        var message = $('#msg').val();
        $('#msg').val('');
        websocket.send(userName +': '+message);
        return false;
    });


</script>
</body>
</html>
