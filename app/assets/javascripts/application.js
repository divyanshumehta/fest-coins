// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .
window.fbAsyncInit = function() {
    FB.init({
      appId      : '199420324146479',
      cookie     : true,
      xfbml      : true,
      version    : 'v2.8'
    });

    FB.AppEvents.logPageView();

};

  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "https://connect.facebook.net/en_US/sdk.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));


var data = {};

function render_user(user,index) {
  return '<div class="image_grid" id="image_grid'+index+'">\
            <label for="'+index+'">\
              <img src="'+user.image+'"> '+user.name+'\
            </label><input class="alternative" type="radio" id="'+index+'">\
          </div>'
}

function valid_amount() {
  amt = $('#amount').val();
  if (amt>0) {
    $('#transfer_buttton').prop('disabled', false);
    return
  }
  else {
    $('#transfer_buttton').prop('disabled', true);
    return
  }
  // if(amot)
}


function search_user(){
  name = $('#dest_name').val();
  $('#transfer_buttton').prop('disabled', true);
  $.ajax({
				type: "GET",
				url: "/search/user",
				data: {"name": name},
				success: function(result){
          console.log(result);
					if(result.status==='OK'){
            data = result.data;
            $('#dest_info_display').html('<b>Search Results</b><br/>Selcet the user to transfer amount to<br/>');
              $.each(result.data,function(index,user){
                $('#dest_info_display').append(render_user(user,index));
              });
					}
					else if (result.status == "limit") {
            $('#dest_info_display').html('<b>Search Results</b><br/>Please be more specific<br/>');
          }
          else {
            $('#dest_info_display').html('<b>Search Results</b><br/>No such user search again');
          }
				},
			});
};

$(document).ready(function(){

  $(document).on('click','.alternative',function(e){
    $('#dest_email').val(data[this.id].email);
    $('.image_grid').css("color","black");
    $('.image_grid').css('display','none');
    $('#image_grid'+this.id).css('display','block');
    $('#image_grid'+this.id).css("color","green");
    $('#dest_name').val(data[this.id].name);
    $('#transfer_buttton').prop('disabled', false);
    valid_amount();
  });

  $('#transfer_buttton').prop('disabled', true);

  setTimeout(function() {
    $('#messages').fadeOut('slow');
}, 5000);

});
