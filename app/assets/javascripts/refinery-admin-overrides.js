$(function () {
  $(document).ready(function(){
      $('#actions').find('li:has(a.add_icon)').addClass('cta')
      $('#actions').find('li:has(a.page_add_icon)').addClass('cta')
      $('#actions').find('li:has(a.upload_icon)').addClass('cta')
    });
});