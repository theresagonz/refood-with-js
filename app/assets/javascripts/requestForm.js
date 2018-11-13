$(document).on('turbolinks:load', () => {
  $('#request-form').on('submit', (e) => {
    e.preventDefault();
    
    const id = parseInt($('.js-next').attr('data-id'), 10);
    const data = {
      request: {
        message: $('#request-message')[0].value,
        requestor_email: $('#requestor-email')[0].value,
        requestor_phone: $('#requestor-phone')[0].value
      }
    };

    const status = data.request.completed_requestor && request.completed_giver ? 'Closed request' : 'Open request';
    const phone = data.request.requestor_phone ? data.request.formatted_phone : 'Phone not given';
    const email = data.request.requestor_email ? data.request.requestor_email : 'Email not given';
    const html = `
      <div class="lt-grey-box list-spacing">
        <h4 class="slab-font">${status}</h4>
        <b>From: </b>${data.request.requestor_name}<br>
        <b>Email: </b><a href="mailto:${email}">${email}</a><br>
        <b>Phone: </b>${phone}<br>
        <b>Message: </b>${data.request.message}<br>
      </div>
    `;
    debugger
    $.post('/offers/2/requests', data, function(returnedData){
         console.log('data', returnedData);
      }).fail(function(){
      console.log("error");
    });
    // $.ajax({
    //   type: 'POST',
    //   url: '/offers/2/requests',
    //   data: data,
    //   success: () => {
    //     alert('hey it worked maybe')
    //     debugger
    //     // $('#offer-requests').append(html)
    //   },
    //   error: () => {
    //     alert('there\'s an error')
    //   }
    // });
  // $.post('/offers/${id}/requests', data, postData);
  // console.log(data);
  });
});
