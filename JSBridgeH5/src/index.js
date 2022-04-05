import React from 'react';
import ReactDom from 'react-dom';
import { LocaleProvider, message } from 'antd';
import zh_CN from 'antd/lib/locale-provider/zh_CN';
import 'moment/locale/zh-cn';

import App from './App';

/*-------------------------
总结：首先我们要明白h5这边都做哪些事情，
1.h5注册原生调用
2.原生注册h5调用
而这里主要是一些初始化操作和默认接收的操作
---------------------------*/
const u = navigator.userAgent;
// Android终端
const isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1;

/*-----------------------------------
android初始化方法：
为了原生调用h5
需要实现一个方法：
 * androidFunction 
当然后续还需要一个
* bridge.init方法
用于默认接收h5调用原生的回调
-----------------------------------*/
const andoirFunction = (callback) => {
    if (window.WebViewJavascriptBridge) {
        callback(window.WebViewJavascriptBridge);
    } else {
        document.addEventListener('WebViewJavascriptBridgeReady', function () {
            callback(window.WebViewJavascriptBridge);
        }, false)
    }
}

/*---------------------------
ios初始化方法：
与ios交互只需要实现这一个方法即可，
----------------------------*/
const iosFuntion = (callback) => {
    if (window.WebViewJavascriptBridge) { return callback(window.WebViewJavascriptBridge) }
    if (window.WVJBCallbacks) { return window.WVJBCallbacks.push(callback) }
    window.WVJBCallbacks = [callback];
    var WVJBIframe = document.createElement('iframe');
    WVJBIframe.style.display = 'none';
    WVJBIframe.src = 'wvjbscheme://__BRIDGE_LOADED__';
    document.documentElement.appendChild(WVJBIframe);
    setTimeout(function(){
         document.documentElement.removeChild(WVJBIframe);
    }, 0);
}
/*-----------------
初始化方法的挂载
------------------*/
window.setupWebViewJavascriptBridge = isAndroid ? andoirFunction : iosFuntion;
if (isAndroid) {
    window.setupWebViewJavascriptBridge(function (bridge) {
        // 注册 H5 界面的默认接收函数（与安卓交互时，不注册这个事件无法接收回调函数）
        bridge.init(function (msg, responseCallback) {
            message.success(msg);
            responseCallback("JS 返回给原生的消息内容");
        })
    })
}

ReactDom.render(
    <LocaleProvider locale={zh_CN}>
        <App />
    </LocaleProvider>,
    document.querySelector('#root')
);