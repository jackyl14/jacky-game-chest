$(document).ready ->
  if window.location.pathname == "/"
    $(window).scroll ->
      scrollTop = $(window).scrollTop()
      gameSectionTop = $("#games").position().top - 110
      if scrollTop > gameSectionTop
        $("#gameSection").addClass("active");
      else
        $("#gameSection").removeClass("active");
