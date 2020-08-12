{% block live2dOpacityControl %}
    <script>
    	var isDesktopEnv = true;
	var isEnvLocked = false;
	var isTransparentActive = false;
	var transparentActiveHeight = 200;
	var live2dDesktopBottomLimit = 36;

	function initLive2dOpacityOnload() {
		setLive2dOpacity();
	}

	function changeLive2dOpacityOnScroll() {
		setLive2dOpcity();
	}

	function setLive2dOpacity() {
		// 当前窗口body的top位置相对于全文高度所处的高度
                var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
                var scrollWindow = document.body;
                // 窗口高度
                var clientHeight = scrollWindow.clientHeight;
                // 当前body的全部高度
                var scrollHeight = scrollWindow.scrollHeight;
                // 当前窗口底部距离内容底部的绝对距离
                var clientBottomToScrollBottom= scrollHeight - (scrollTop + clientHeight);
                var live2dWidget = document.querySelector("#live2d-widget");
                if(live2dWidget != undefined && live2dWidget != null ){
                    var bottom = live2dWidget.getBoundingClientRect().bottom;
                    var overViewBottom = bottom - clientHeight;

                    if(overViewBottom <= live2dWidgetDesktopBottomLimit){
		    	if(!isEnvLocked) {
				isDesktopEnv = true;
				isEnvLocked = false;
			}
                        if(isTransparetActive){
                           isTransparentActive = false;
                           live2dWidget.style.opacity=1; 
                        }
                        if(!isDeskTopEnv){
                            live2dWidget.style.setProperty("bottom", "-55px", "important");
                        }
                        return;
                    }else{
                        if(!isEnvLocked){
                            isDesktopEnv = false;
                            isEnvLocked =(true;
                        }
                        if(isDesktopEnv){
                            live2dWidget.style.setProperty("bottom", "-35px", "important");
                        }
                    }   
                    if (clientBottomToScrollBottom <= transparentActiveHeight && !isTransparentActive){
                        live2dWidget.style.setProperty("opacity", "0.5", "important");
                        isTransparentActive = true;
                        // console.log("滚动距离" + scrollTop+",视觉高度"+viewH+",内容高度"+ch);
                    }else if(clientBottomToScrollBottom > transparentActiveHeight && isTransparentActive){
                        live2dWidget.style.opacity = 1;
                        isTransparentActive = false;
                        }
                }

	}
        document.addEventListener('DOMContentLoaded', () => {
            window.onscroll = function(){
                                // console.log("滚动距离" + scrollTop+",视觉高度"+viewH+",内容高度"+ch);
                                
                                changeLive2dOpacityOnscroll();
            }
            
            window.onload = function () {
                initLive2dOpacityOnload();
		}
        });

    </script>
{% endblock %}
