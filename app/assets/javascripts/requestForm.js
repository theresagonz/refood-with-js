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

    $.post(`/offers/${id}/requests`, data, (returnedData) => {
         console.log('data', returnedData);
      }).fail(() => console.log("error"));
  //   $.ajax({
  //     type: 'POST',
  //     url: '/offers/2/requests',
  //     data: data,
  //     success: () => {
  //       alert('hey it worked maybe')
  //       debugger
  //       // $('#offer-requests').append(html)
  //     },
  //     error: () => {
  //       alert('there\'s an error')
  //     }
  //   });
  // $.post('/offers/${id}/requests', data, postData);
  // console.log(data);
  });
});
