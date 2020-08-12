{% block live2dOpacityControl %}
    <script>
        var isDesktopEnv = true;
        var isTransparentActive = false;
        var transparentActiveHeight = 200;

        /**
        * 组件加载时
        * 初始化系统环境变量：桌面 or 移动端
        * 初始化live2d的透明度
        * 桌面与移动端切换时修改透明度及live2d bottom
        **/
        function initLive2dOpacityAndBottomOnload() {
            // console.log("初始化");
            var windowMatch = window.matchMedia('(max-width: 991px)');
            if(windowMatch.matches){
                isDesktopEnv = false;
            }else{
                return;
            }
            // 当前窗口body的top位置相对于全文高度所处的高度
            var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
            var scrollWindow = document.body;
            // 窗口高度
            var clientHeight = scrollWindow.clientHeight;
            // 当前body的全部高度
            var scrollHeight = scrollWindow.scrollHeight;
            // 当前窗口底部距离内容底部的绝对距离
            var clientBottomToScrollBottom = scrollHeight - (scrollTop + clientHeight);
            var live2dWidget = document.querySelector("#live2d-widget");
            if(live2dWidget != undefined && live2dWidget != null ){
                if(!isDesktopEnv){
                    live2dWidget.style.bottom = "-55px";
                }else{
                    live2dWidget.style.bottom = "-35px";
                }
                if (clientBottomToScrollBottom <= transparentActiveHeight && !isTransparentActive){
                    live2dWidget.style.setProperty("opacity", "0.5");
                    isTransparentActive = true;
                }else if(clientBottomToScrollBottom > transparentActiveHeight && isTransparentActive){
                    live2dWidget.style.opacity = 1;
                    isTransparentActive = false;
                }
            }
        }

        /**
        * 页面滚动时修改live2d透明度
        **/
        function changeLive2dOpacityAndBottomOnScroll() {
            // console.log("滑动");
            var windowMatch = window.matchMedia('(max-width: 991px)');
            var isDesktop = !windowMatch.matches;

            // 当前窗口body的top位置相对于全文高度所处的高度
            var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
            var scrollWindow = document.body;
            // 窗口高度
            var clientHeight = scrollWindow.clientHeight;
            // 当前body的全部高度
            var scrollHeight = scrollWindow.scrollHeight;
            // 当前窗口底部距离内容底部的绝对距离
            var clientBottomToScrollBottom = scrollHeight - (scrollTop + clientHeight);
            
            var live2dWidget = document.querySelector("#live2d-widget");
            if(live2dWidget != undefined && live2dWidget != null ){
                // env mobile -> desktop
                if(!isDesktopEnv && isDesktop){
                    live2dWidget.style.bottom = "-55px";
                }else if(isDesktopEnv && !isDesktop){
                    live2dWidget.style.bottom = "-35px";
                }
                // env desktop -> mobile
                if(isDesktop){
                    if(isTransparentActive){
                        isTransparentActive = false;
                        live2dWidget.style.opacity = 1;
                    }
                    return;
                }
                if (clientBottomToScrollBottom <= transparentActiveHeight && !isTransparentActive){
                    live2dWidget.style.setProperty("opacity", "0.5");
                    isTransparentActive = true;
                }else if(clientBottomToScrollBottom > transparentActiveHeight && isTransparentActive){
                    live2dWidget.style.opacity = 1;
                    isTransparentActive = false;
                }
            }
        }

        document.addEventListener('DOMContentLoaded', () => {
            window.onload = function () {
                initLive2dOpacityAndBottomOnload();
            }

            window.onscroll = function(){
                changeLive2dOpacityAndBottomOnScroll();
            }
        });
    </script>
{% endblock %}