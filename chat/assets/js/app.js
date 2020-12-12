// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
    import socket from "./socket"
    let channel = socket.channel('room:lobby', {});
    channel.on('shout', function (payload) {
        let li = document.createElement("li");
        let name = payload.name || 'guest';
        li.innerHTML = '<b>' + name + '</b>: '+ payload.message;
        ul.appendChild(li);
    });

    channel.join();

    let ul = document.getElementById('msg-list');
    let name = document.getElementById('name');
    let msg = document.getElementById('msg');

    msg.addEventListener('keypress', function (event) {
        if(event.keyCode == 13 && msg.value.length > 0){
            channel.push('shout', {
                name: name.value, 
                message: msg.value
            });
            msg.value = '';
        }
    });
//
import "phoenix_html"
