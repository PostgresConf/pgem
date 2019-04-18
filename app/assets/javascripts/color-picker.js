jQuery(document).ready(function($){
    $color_list = [
        {color:'#000000',title:'Black'},
        {color:'#ffffff',title:'White'},
        {color:'#d32f2f',title:'Red'},
        {color:'#c2185b',title:'Pink'},
        {color:'#7b1fa2',title:'Purple'},   
        {color:'#512da8',title:'Deep Purple'},
        {color:'#303f9f',title:'Indigo'},
        {color:'#1976d2',title:'Blue'},
        {color:'#0288d1',title:'Light Blue'},
        {color:'#0097a7',title:'Cyan'},
        {color:'#00796b',title:'Teal'},
        {color:'#388e3c',title:'Green'},
        {color:'#689f38',title:'Light Green'},
        {color:'#afb42b',title:'Lime'},
        {color:'#fbc02d',title:'Yellow'},
        {color:'#ffa000',title:'Amber'},
        {color:'#f57c00',title:'Orange'},
        {color:'#e64a19',title:'Deep Orange'},
        {color:'#5d4037',title:'Brown'},
        {color:'#616161',title:'Grey'},
        {color:'#455a64',title:'Steel Grey'}
   ];   
    $('.color-picker').wrap('<div class="color-picker-wrap"></div>');
     $('.color-picker-wrap').each(function(){
            var self = $(this);
            if(self.children('.color-picker').hasClass('cp-sm')){
                self.addClass('cp-sm');
            }else if(self.children('.color-picker').hasClass('cp-lg')){
                self.addClass('cp-lg');
            }
            self.append('<ul></ul><input type="color" style="display:none;" />');
            var $foundactive = false;
            for(var i = 0; i <  $color_list.length; i++){
            var $active = '';
            if(self.children(".color-picker").val()==$color_list[i].color){
                    $active = 'class="active"';
                    $foundactive = true;
                    if(self.children(".color-picker").hasClass('cp-show')){
                        self.children('small').remove();    
                        self.append('<small>Selected Color: <code>'+$color_list[i].color+'</code></small>');             
                    }
            }
                self.children('ul').append('<li '+ $active+' style="background-color:'+$color_list[i].color+'" title="'+ $color_list[i].title+'"></li>');
            }

            if(!$foundactive && self.children(".color-picker").val()!='' ){
                    self.children('ul').append('<li class="active" title="Custom Color '+self.children(".color-picker").val()+'" style="background-color:'+self.children(".color-picker").val()+'"></li>');              
                    if(self.children(".color-picker").hasClass('cp-show')){
                        self.children('small').remove();    
                        self.append('<small>Selected Color: <code>'+self.children(".color-picker").val()+'</code></small>');                       
                    }
            }

            self.children('ul').append('<li class="add_new" title="Add New">+</li>');

     });

  $('.color-picker-wrap ul').on('click','li', function() {

        var self = $(this);

          if (!self.hasClass('add_new')) {   

                  if (!self.hasClass('active')) {

                      self.siblings().removeClass('active');

                        var color =rgb2hex(self.css("backgroundColor"));

                        self.parents('.color-picker-wrap').children(".color-picker").val(color);

                        self.addClass('active');
                        
                        if(self.parents('.color-picker-wrap').children(".color-picker").hasClass('cp-show')){

                            self.parents('.color-picker-wrap').children('small').remove();    

                            self.parents('.color-picker-wrap').append('<small>Selected Color: <code>'+color+'</code></small>');

                        }

                  }
          }else{
              self.parents('.color-picker-wrap').children("input[type='color']").trigger('click');
          }

      });

  $(".color-picker-wrap input[type='color']").on("change",function(){

      var self = $(this);

      self.parents('.color-picker-wrap').children('ul').children('li').removeClass('active');

      self.parents('.color-picker-wrap').children('ul').children('li.add_new').remove();

      self.parents('.color-picker-wrap').children('ul').append('<li class="active" title="Custom Color '+self.val()+'" style="background-color:'+self.val()+'"></li>');

      self.parents('.color-picker-wrap').children(".color-picker").val(self.val());

      self.parents('.color-picker-wrap').children('ul').append('<li class="add_new" title="Add New">+</li>');
                              
    if(self.parents('.color-picker-wrap').children(".color-picker").hasClass('cp-show')){

        self.parents('.color-picker-wrap').children('small').remove();    

        self.parents('.color-picker-wrap').append('<small>Selected Color: <code>'+self.val()+'</code></small>');
        
    }

  });

    var hexDigits = new Array ("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"); 

    function rgb2hex(rgb) {

        rgb = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
        
        return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]);
    }

    function hex(x) {

        return isNaN(x) ? "00" : hexDigits[(x - x % 16) / 16] + hexDigits[x % 16];

    }

});    