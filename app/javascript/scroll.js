document.addEventListener("turbolinks:load", function() {
  $(function() {
    $('#back a').on('click',function(event){
      $('body, html').animate({
        scrollTop:0
      }, 300);
      event.preventDefault();
    });
  });
})