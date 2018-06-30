$(function(){
  function buildHTML(comment){
    var html = `<p>
                  <strong>
                    <a href=/users/${comment.user_id}>${comment.user_name}</a>
                    ：
                  </strong>
                  ${comment.text}
                </p>`
    return html;
  }
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);  /**  FormDataで{}を生成している  **/
    var href = window.location.href + '/comments' /* $(this).attr('action') */
    console.log(formData)

    $.ajax({
      url: href,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      console.log(data)
      var html = buildHTML(data);
      $('.comments').append(html)
      $('.textbox').val('')
    })
     .fail(function(){
      alert('error');
    })
  })
});


