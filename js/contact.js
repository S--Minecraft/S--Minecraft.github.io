(function(){var s,a,e;s=function(){var s;return s=$("#form-main"),/^(?:https?:\/\/)?s--minecraft\.github\.io\/contact\/?(?:index.html)?$/i.test(s.find("#url").val())?!0:!1},e=function(){var s,a,e;a=$("#form-main"),s=a.find("#submit"),e=$("#form").find("#status"),$.ajax({type:"POST",url:"https://script.google.com/macros/s/AKfycbw4z8qk2haZYjgaB_W9noCGttOIk7JJiscsCENtQhjG1hN2JfG8/exec",data:{from_email:a.find("#email").val(),from_name:a.find("#name").val(),subject:a.find("#title").val(),message:a.find("#message").val()},timeout:1e4,beforeSend:function(){s.attr("disabled",!0)}}).done(function(s){a[0].reset(),e.html('<i class="material-icons">done</i>Sent successfully'),e.removeClass("error"),e.addClass("success")}).fail(function(s){e.html('<i class="material-icons">error</i>Errored sending'),e.removeClass("success"),e.addClass("error")}).always(function(a){s.attr("disabled",!1)})},a=function(){$("#form-main").on("submit",function(a){var t;a.preventDefault(),s()?e():(t=$("#form").find("#status"),t.html('<i class="material-icons">error</i>Errored sending'),t.removeClass("success"),t.addClass("error"))})},$(function(){a()})}).call(this);