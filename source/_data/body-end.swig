{% block live2dOpacityControl %}
    <script>
        console.log("this is just a test");
        document.addEventListener('DOMContentLoaded', () => {
            var opacitySet = false;
            window.onscroll = function(){
                // 当前窗口body的top位置相对于全文高度所处的高度
                var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
                var content = document.body;
                // 窗口高度
                var viewH = content.clientHeight;
                // 当前body的全部高度
                var ch = content.scrollHeight;
                var opacityH = ch - viewH - scrollTop;
                var live2dWidget = document.querySelector("#live2d-widget");
                if(live2dWidget != undefined && live2dWidget != null ){
                    var bottom = live2dWidget.getBoundingClientRect().bottom;
                    var bottomHD = bottom - viewH;

                    if(bottomHD<=36){
                        if(opacitySet){
                            opacitySet = false;
                           live2dWidget.style.opacity=1; 
                        }
                        return;
                    }
                    if (opacityH<=200 && !opacitySet){
                        live2dWidget.style.opacity=0.5;
                        opacitySet = true;
                        // console.log("滚动距离" + scrollTop+",视觉高度"+viewH+",内容高度"+ch);
                    }else if(opacityH>200 && opacitySet){
                        live2dWidget.style.opacity=1;
                        opacitySet = false;
                    }
                }
                // console.log("滚动距离" + scrollTop+",视觉高度"+viewH+",内容高度"+ch);
            }
        });

    </script>
{% endblock %}