(function(d){d.fn.redirect=function(a,b,c){void 0!==c?(c=c.toUpperCase(),"GET"!=c&&(c="POST")):c="POST";if(void 0===b||!1==b)b=d().parse_url(a),a=b.url,b=b.params;var e=d("<form></form");e.attr("method",c);e.attr("action",a);for(var f in b)a=d("<input />"),a.attr("type","hidden"),a.attr("name",f),a.attr("value",b[f]),a.appendTo(e);d("body").append(e);e.submit()};d.fn.parse_url=function(a){if(-1==a.indexOf("?"))return{url:a,params:{}};var b=a.split("?"),a=b[0],c={},b=b[1].split("&"),e={},d;for(d in b){var g= b[d].split("=");e[g[0]]=g[1]}c.url=a;c.params=e;return c}})(jQuery);
$(function(){
    $.contextMenu({
        selector: '.context-menu-one', 
        callback: function(key, options) {
            var m = "clicked: " + key;
            switch (key)
            {
                case "transaction":
                alert('clicked '+key);
                break;
                case "movements":
                $().redirect('movements.jsp', {'account': this.attr('accid')});
                break;
                case "accinfo":
                    var wWidth = $(window).width();
                    var dWidth = wWidth * 0.8;
                    $( "#dialog" ).load('conditions/'+this.attr('acctype')+'.md');
                    $( "#dialog" ).dialog({
                        show: {
                            effect: "fade",
                            duration: 500
                        },
                        hide: {
                            effect: "fade",
                            duration: 1000
                        },
                        position: 'top',
                        width: dWidth,
                        modal: true,
                        close: function(){$( "#dialog" ).html('');}
                    });
                break;
            }
        },
        items: {
            "transaction": {name: "Nueva transferencia...", icon: "transaction"},
            "movements": {name: "Movimientos...", icon: "movements"},
            "accinfo": {name: "Información de cuenta...", icon: "accinfo"},
        }
    });
});
$( document ).ready(function() {
    $( "a" ).click(function(e) {
        e.preventDefault();
        var account=$(e.target).closest( "a" ).attr('title');
        if(account=="logout")
            location.href='logout.jsp';
        else
            $().redirect('movements.jsp', {'account': account});
    });
  });