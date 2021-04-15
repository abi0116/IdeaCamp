// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery3
//= require popper
//= require bootstrap-sprockets

//= require rails-ujs
//= require jquery-ui
//= require tag-it
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function () {
  $(".openbtn").click(function() {//ボタンがクリックされたら
    $(this).toggleClass("active");//ボタン自身にactiveクラスを付与し
    $("#g-nav").toggleClass("panelactive");//ナビゲーションにpanelactiveクラスを付与
  });
});

$(document).on('turbolinks:load', function () {
  $("#g-nav a").click(function() {//ナビゲーションのリンクがクリックされたら
    $(".openbtn").removeClass("active");//ボタンのactiveクラスを除去し
    $("#g-nav").removeClass("panelactive");//ナビゲーションのpanelactiveクラスも除去
  });
});

$(document).on('turbolinks:load', function () {
  $("#back a").on("click",function(event){
    $("body,html").animate({
      scrollTop:0
    },1000);
    event.preventDefault();// aタグの無効化
  });
});

// ページ更新でtag-it発火

  $(document).ready( function() {
    $(".tag_form").tagit({  // 指定のセレクタ( 今回は、:tag_list の text_field )に、tag-itを反映
      tagLimit:10,         // タグの最大数
      singleField: true,   // タグの一意性
   // availableTags: ['ruby', 'rails', ..]  自動補完する一覧を設定できる(※ 配列ならok)。今回は、Ajax通信でDBの値を渡す(後述)。
    });
    let tag_count = 10 - $(".tagit-choice").length    // 登録済みのタグを数える
    $(".ui-widget-content.ui-autocomplete-input").attr(
      'placeholder','あと' + tag_count + '個登録できます');
  });

// タグ入力で、placeholder を変更
$(document).on("keyup", '.tagit', function() {
  let tag_count = 10 - $(".tagit-choice").length    // ↑ と同じなので、まとめた方がいい。
  $(".ui-widget-content.ui-autocomplete-input").attr(
  'placeholder','あと' + tag_count + '個登録できます');
   // Ajaxで、タグ一覧を取得
  let input = $(".ui-widget-content.ui-autocomplete-input").val();  // 変数inputに、入力値を格納
  $.ajax({
    type: 'GET',
    url: 'get_tag_search',    // ルーティングで設定したurl
    data: { key: input },     // 入力値を:keyとして、コントローラーに渡す
    dataType: 'json'
  })

  .done(function(data){
    if(input.length) {               // 入力値がある時のみ
      let tag_list = [];             // 空の配列を準備
      data.forEach(function(tag) {   // 取得したdataのnameを配列に格納
        tag_list.push(tag.name);     // 1つずつ追加。 tag_list = ["タグ名1", "タグ名2", ..]
      });
      $(".tag_form").tagit({
        availableTags: tag_list
      });
    }
  })
});

  $(function() {
    $('.top-image').slick({
      dots: true,
      autoplay: true,
      autoplaySpeed: 3000,
      speed: 400
    });
});