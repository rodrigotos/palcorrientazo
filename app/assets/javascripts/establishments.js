document.addEventListener("DOMContentLoaded", function(){
    var search_zone_input = document.querySelector("select[name='establishment_zone']");
    var search_likes_input = document.querySelector("input[name='establishment_likes']");
    var clean_button = document.querySelector("#clean-general-search-button");
    if(search_zone_input !==  null){
      search_zone_input.addEventListener("change", function(){
        $("#establishment-general-search-button").click();
      });
    }
    if(search_likes_input !==  null){
      search_likes_input.addEventListener("change", function(){
        $("#establishment-general-search-button").click();
      });
    }
    if(clean_button !==  null){
      clean_button.addEventListener("click", function(){
        $("input[name='establishment_general_name']").attr("value", "");
        $("input[name='establishment_zone']").attr("value", "");
        $("input[name='establishment_likes']").attr("value", "");
        $("#establishments_list").html("");
      });
    }
});
