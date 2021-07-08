window.bridgeReady = function () {
    setNavigationRightActionForSharePanel();
};

function setNavigationRightActionForOpenH5Page() {
    let data = {
        iconUrl: '',
        title: '打开百度',
        actionType: 'handleScheme',
        actionParams: {
            scheme: 'https://www.baidu.com/s',
            params: {wd: '美女'}
        },
        tracker: commonTracker()
    };
    
    setNavigationRightAction(data);
}

function setNavigationRightActionForSharePanel() {
    let data = {
        iconUrl: '',
        title: '分享',
        actionType: 'sharePanel',
        actionParams: {
            data: [{
                channel: 'wechat',
                data: shareData(),
                tracker: commonTracker()
            }, {
                channel: 'wechat_timeline',
                data: shareData(),
                tracker: commonTracker()
            }, {
                channel: 'alipay',
                data: shareData(),
                tracker: commonTracker()
            }, {
                channel: 'alipay_timeline',
                data: shareData(),
                tracker: commonTracker()
            }, {
                channel: 'qq',
                data: shareData(),
                tracker: commonTracker()
            }, {
                channel: 'qq_zone',
                data: shareData(),
                tracker: commonTracker()
            },{
                channel: 'sms',
                data: shareData(),
                tracker: commonTracker()
            }, {
                channel: 'sina_weibo',
                data: shareData(),
                tracker: commonTracker()
            }]
        },
        tracker: commonTracker()
    };
    
    setNavigationRightAction(data);
}

function setNavigationRightActionForCallJavaScriptMethod() {
    let data = {
        iconUrl: '',
        title: '调用js',
        actionType: 'callJavaScriptMethod',
        actionParams: {
            method: '测试分享标题'
        },
        tracker: commonTracker()
    };
    
    setNavigationRightAction(data);
}

function setNavigationRightActionForRefresh() {
    let data = {
        iconUrl: '',
        title: '刷新',
        actionType: 'refresh',
        tracker: commonTracker()
    };
    
    setNavigationRightAction(data);
}

function setNavigationRightAction(data) {
    callNative('setNavigationRightAction', data);
}

function openNewPageForBaidu() {
    callNative('handleScheme', {scheme : 'https://www.baidu.com/'});
}

function callNative(handler, data, callback) {
    if (!bridge) {
        nativeConsole('bridge is unregistered');
        return;
    }
    
    if (!bridge.invoke) {
        nativeConsole('bridge not has property function invoke');
        return;
    }
    
    bridge.invoke(handler, data, callback);
}

function nativeConsole(log) {
    if (bridge && bridge.console) {
        bridge.console(log);
    } else {
        console.log(log);
    }
}

function commonTracker(id, params) {
    return {
        id: id || '10001',
        params: params || {}
    };
}

function shareData() {
    return {
        type: 'image',
        icon: '',
        title: '',
        content: '',
        url: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic.jj20.com%2Fup%2Fallimg%2F1114%2F0G520141919%2F200G5141919-6-1200.jpg&refer=http%3A%2F%2Fpic.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1628059103&t=e5091b57beb617efb9b6d29e343f5b0c'
    };
}

function share(channel) {
    let params = {
        channel: channel,
        data: shareData()
    };
    
    callNative('channelShare', params, function (data) {
        nativeConsole(JSON.stringify(data));
    });
}

function imagePicker() {
    let params = {
        type: 'both',
        quality: 0.8,
        cut : 1
    };
    
    callNative('imagePicker', params, function (data) {
        nativeConsole(JSON.stringify(data));
    });
}

function showAlert() {
    let params = {
        title : '这是标题',
        message: '这是内容',
        buttonTitles : ['确定', '取消'],
        destructiveIndex : 1
    };
    
    callNative('showAlert', params, function (data) {
        nativeConsole(JSON.stringify(data));
    });
}

function showActionSheet() {
    let params = {
        title : '这是操作提示内容',
        buttonTitles : ['确认删除'],
        destructiveIndex : 0
    };
    
    callNative('showActionSheet', params, function (data) {
        nativeConsole(JSON.stringify(data));
    });
}

function callPhone() {
    callNative('callPhone', {phone: '18012345678'});
}

function scanCode() {
    callNative('scanCode', null, function (data) {
        nativeConsole(JSON.stringify(data));
    });
}

function getParamsSignature() {
    let params = {
        name1 : 'name1',
        name2 : 'name2',
        name3 : 0
    };
    
    callNative('getParamsSignature', params, function (data){
        nativeConsole(JSON.stringify(data));
    });
}

function setPageTitle() {
    callNative('setPageTitle', {title: '新的标题'});
}

